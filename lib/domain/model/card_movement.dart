import 'package:mobile/data/db_cache.dart';

class CardMovement {
  double grossCredit;
  double grossDebit;
  late double grossBalance;
  
  late double netCredit;
  late double netDebit;
  late double netBalance;

  late double discountedAmount;

  CardMovement(this.grossCredit, this.grossDebit) {
    netCredit = grossCredit * (1 - DBCache.creditTax/100);
    netDebit = grossDebit * (1 - DBCache.debitTax/100);

    grossBalance = grossCredit + grossDebit;
    netBalance = netDebit + netCredit;

    discountedAmount =  grossBalance - netBalance;
  }
}