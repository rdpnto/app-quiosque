import 'package:mobile/data/db_cache.dart';
import 'package:mobile/domain/model/card_movement.dart';
import 'package:mobile/domain/model/outcome_trail.dart';
import 'package:mobile/domain/model/register.dart';

class Closure {
  late CardMovement cardMovement;
  late Register register;
  late OutcomeTrail outcomeTrail;

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
    required Map<String, double> employeeExpenses,
    required double gas,
    required double potato
  }) {
    cardMovement = CardMovement(credit, debit);
    register = Register(opening, closure);

    outcomeTrail = OutcomeTrail(
      employees: employeeExpenses,
      gas: gas,
      potato: potato
    );

    expenses = outcomeTrail.total;

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

  List<Map<String, Object?>> toExpensesMap() {
    return outcomeTrail
      .employees
      .entries
      .map((kvp) {
        return {
          'date': datePosition.toUtc().millisecondsSinceEpoch,
          'resource_id': DBCache.resourceIds[kvp.key],
          'name': kvp.key,
          'value': kvp.value
        };
      })
      .toList();
  }

  @override
  String toString() {
    return 'Closure { date: $datePosition, cash: $cashBalance, pix: $pixBalance, card: $cardBalance, change: $change, expenses: $expenses, total: $netBalance }';
  }
}