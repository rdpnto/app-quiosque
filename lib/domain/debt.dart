class Debt {
  String description;

  String debtor;
  String creditor;

  double amount;
  DateTime eventDate;

  Debt({
    required this.description,
    required this.debtor,
    required this.creditor,
    required this.amount,
    required this.eventDate,
  });
}