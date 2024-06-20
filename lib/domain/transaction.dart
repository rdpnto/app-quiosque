abstract class Transaction {
  String name;
  double amount;
  DateTime eventDate;

  Transaction({
    required this.name,
    required this.amount,
    required this.eventDate,
  });
}