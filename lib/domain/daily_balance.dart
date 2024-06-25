class DailyBalance {
  DateTime date;
  double cash;
  double pix;
  double card;
  double change;
  double outcomes;
  double total;

  DailyBalance({
    required this.date,
    required this.cash,
    required this.pix,
    required this.card,
    required this.change,
    required this.outcomes,
    required this.total
  });

  Map<String, Object?> toMap() {
    return {
      'date': date,
      'cash': cash,
      'pix': pix,
      'card': card,
      'change': change,
      'outcomes': outcomes,
      'total': total
    };
  }

  @override
  String toString() {
    return 'Closure { date: $date, cash: $cash, pix: $pix, card: $card, change: $change, outcomes: $outcomes, total: $total }';
  }
}