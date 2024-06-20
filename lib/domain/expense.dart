import 'package:mobile/domain/transaction.dart';

class Expense extends Transaction {
  DateTime? maturityDate;
  DateTime? dueDate;

  Expense({
    required String name,
    required double amount,
    required DateTime eventDate,
  }) : super(
    name: name,
    amount: amount,
    eventDate: eventDate
  );
}