class DailyBalanceDto {
  late int date;
  late double cash;
  late double pix;
  late double credit;
  late double debit;
  late double opening;
  late double closure;
  late double expenses;

  DailyBalanceDto({
    required this.date,
    required this.cash,
    required this.pix,
    required this.credit,
    required this.debit,
    required this.opening,
    required this.closure,
    required this.expenses
  });
}