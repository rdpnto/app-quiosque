import 'package:mobile/data/model/daily_balance_dto.dart';
import 'package:mobile/data/model/resource_dto.dart';
import 'package:mobile/domain/model/closure.dart';
import 'package:mobile/domain/model/daily_balance.dart';
import 'package:mobile/domain/model/resource.dart';

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

  static Resource toResource(ResourceDto dto) {
    var model = Resource(
      name: dto.name,
      description: dto.description,
      isEmployee: dto.isEmployee,
      salary: dto.salary
    );

    model.setId(dto.id);

    return model;
  }
}