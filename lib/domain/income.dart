import 'package:mobile/domain/transaction.dart';

class Income extends Transaction {
  Income({
    required String name,
    required double amount,
    required DateTime eventDate
}) : super(
    name: name,
    amount: amount,
    eventDate: eventDate
  );
}