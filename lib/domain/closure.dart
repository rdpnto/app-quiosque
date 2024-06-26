import 'package:mobile/domain/card_revenue.dart';
import 'package:mobile/domain/outcome_trail.dart';
import 'package:mobile/domain/register.dart';

class Closure {
  late CardRevenue cardRevenue;
  late Register register;
  late OutcomeTrail outcomeTrail;

  DateTime datePosition;
  double cashBalance;
  double pixBalance;

  double get cardBalance => cardRevenue.netBalance;
  double get change => register.dailyChange;
  double get outcomes => outcomeTrail.total;
  
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
    required double employeeOutcomes,
    required double gas,
    required double potato
  }) {
    cardRevenue = CardRevenue(credit, debit);
    register = Register(opening, closure);

    outcomeTrail = OutcomeTrail(
      employees: employeeOutcomes,
      gas: gas,
      potato: potato
    );

    grossBalance = cashBalance + pixBalance + cardRevenue.grossBalance - change;
    netBalance = grossBalance - outcomes - cardRevenue.discountedAmount;
  }

  Map<String, Object?> toMap() {
    return {
      'date': datePosition,
      'cash': cashBalance,
      'pix': pixBalance,
      'card': cardBalance,
      'change': change,
      'outcomes': outcomes,
      'total': netBalance
    };
  }

  @override
  String toString() {
    return 'Closure { date: $datePosition, cash: $cashBalance, pix: $pixBalance, card: $cardBalance, change: $change, outcomes: $outcomes, total: $netBalance }';
  }
}