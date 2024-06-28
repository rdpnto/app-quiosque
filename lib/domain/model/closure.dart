import 'package:mobile/data/db_cache.dart';
import 'package:mobile/domain/model/card_movement.dart';
import 'package:mobile/domain/model/expense.dart';
import 'package:mobile/domain/model/register.dart';

class Closure {
  late CardMovement cardMovement;
  late Register register;
  late List<Expense> expenseTrail;

  DateTime datePosition;
  double cashBalance;
  double pixBalance;

  double get cardBalance => cardMovement.netBalance;
  double get change => register.dailyChange;
  
  late double expenses;
  late double grossBalance;
  late double netBalance;

  Closure({
    required this.datePosition,
    required this.cashBalance,
    required this.pixBalance,
    required double debit,
    required double credit,
    required double opening,
    required double closure,
    required Map<String, double> expenseList
  }) {
    cardMovement = CardMovement(credit, debit);
    register = Register(opening, closure);

    expenseTrail = expenseList.entries.map((e) => Expense(
      datePosition: datePosition,
      name: e.key,
      resourceId: DBCache.resourceIds[e.key]!.toInt(),
      value: e.value
    ))
    .toList();

    expenses = expenseTrail.fold(0.0, (sum, exp) => sum + exp.value);
    grossBalance = cashBalance + pixBalance + cardMovement.grossBalance - change;
    netBalance = grossBalance - expenses - cardMovement.discountedAmount;
  }

  Closure.totalExpense({
    required this.datePosition,
    required this.cashBalance,
    required this.pixBalance,
    required double debit,
    required double credit,
    required double opening,
    required double closure,
    required this.expenses
  }) {
    cardMovement = CardMovement(credit, debit);
    register = Register(opening, closure);

    grossBalance = cashBalance + pixBalance + cardMovement.grossBalance - change;
    netBalance = grossBalance - expenses - cardMovement.discountedAmount;
  }

  Map<String, Object?> toDailyBalanceMap() {
    return {
      'date': datePosition.toUtc().millisecondsSinceEpoch,
      'cash': cashBalance,
      'pix': pixBalance
    };
  }

  Map<String, Object?> toCardMovementMap() {
    return {
      'date': datePosition.toUtc().millisecondsSinceEpoch,
      'credit': cardMovement.grossCredit,
      'debit': cardMovement.grossDebit
    };
  }

  Map<String, Object?> toRegisterMap() {
    return {
      'date': datePosition.toUtc().millisecondsSinceEpoch,
      'opening': register.openingAmount,
      'closure': register.closureAmount,
      'difference': register.dailyChange
    };
  }

  @override
  String toString() {
    return 'Closure { date: $datePosition, cash: $cashBalance, pix: $pixBalance, card: $cardBalance, change: $change, expenses: $expenseTrail, total: $netBalance }';
  }
}