class DBCache {
  static Map<String, int> resourceIds = {};
  static double creditTax = 0.0;
  static double debitTax = 0.0;

  static void setResourceIds(Map<String, int> ids) {
    resourceIds = ids;
  }

  static void setCardTax(double credit, double debit) {
    creditTax = credit;
    debitTax = debit;
  }
}