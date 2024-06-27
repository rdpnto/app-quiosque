class DailyBalance {
  DateTime date;
  double cash;
  double card;
  double pix;
  double change;
  double expenses;
  double netBalance;

  DailyBalance({
    required this.date,
    required this.cash,
    required this.pix,
    required this.card,
    required this.change,
    required this.expenses,
    required this.netBalance
  });

  Map<String, Object?> toMap() {
    return {
      'date': date,
      'cash': cash,
      'pix': pix,
      'card': card,
      'change': change,
      'expenses': expenses,
      'total': netBalance
    };
  }

  @override
  String toString() {
    return 'Closure { date: $date, cash: $cash, pix: $pix, card: $card, change: $change, expenses: $expenses, netBalance: $netBalance }';
  }
}