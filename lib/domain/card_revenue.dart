class CardRevenue {
  static const double creditTax = 2.99;
  static const double debitTax = 1.19;

  double grossCredit;
  double grossDebit;
  late double grossBalance;
  
  late double netCredit;
  late double netDebit;
  late double netBalance;

  late double discountedAmount;

  CardRevenue(this.grossCredit, this.grossDebit) {
    netCredit = grossCredit * (1 - creditTax);
    netDebit = grossDebit * (1 - debitTax);

    grossBalance = grossCredit + grossDebit;
    netBalance = netDebit + netCredit;

    discountedAmount =  grossBalance - netBalance;
  }
}