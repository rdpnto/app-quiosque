import 'package:mobile/data/model/daily_balance_dto.dart';
import 'package:mobile/domain/model/closure.dart';
import 'package:mobile/domain/model/daily_balance.dart';

class DomainMapper {
  static DailyBalance toDailyBalance(Closure model) {
    return DailyBalance(
      date: model.datePosition,
      cash: model.cashBalance,
      pix: model.pixBalance,
      card: model.cardBalance,
      change: model.change,
      expenses: model.expenses,
      netBalance: model.netBalance,
    );
  }

  static Closure toClosure(DailyBalanceDto dto) {
    return Closure.totalExpense(
      datePosition: DateTime.fromMillisecondsSinceEpoch(dto.date),
      cashBalance: dto.cash,
      pixBalance: dto.pix,
      debit: dto.debit,
      credit: dto.credit,
      opening: dto.opening,
      closure: dto.closure,
      expenses: dto.expenses,
    );
  }
}