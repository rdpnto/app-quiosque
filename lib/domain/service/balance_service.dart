import 'package:mobile/data/db_cache.dart';
import 'package:mobile/data/db_management.dart';
import 'package:mobile/domain/mapper.dart';
import 'package:mobile/domain/model/closure.dart';
import 'package:mobile/domain/model/daily_balance.dart';
import 'package:mobile/domain/model/resource.dart';

class BalanceService {

  Future<bool> init() async {
    await DB.init();
    await updateResourceCache();

    return true;
  }

  Future<List<DailyBalance>> getMontlyBalance(int month, int year) async {
    var dto = await DB.getAllBalances();

    return dto
      .map((dto) => DomainMapper.toClosure(dto))
      .map((mod) => DomainMapper.toDailyBalance(mod))
      .toList();
  }

  Future<void> insertResource(Resource resource) async {
    var affected = await DB.insertResources(resource.toMap());

    if (affected != 1) throw Exception();

    await updateResourceCache();
  }

  static Future<void> updateResourceCache() async {
    var resources = await DB.getResources();

    DBCache.setResourceIds(
      { for (var res in resources) res.name: res.id }
    );
  }

  Future<void> insertBalance(
    DateTime datePosition,
    double cashBalance,
    double pixBalance,
    double debit,
    double credit,
    double opening,
    double closure,
    Map<String, double> employeeOutcomes,
    double gas,
    double potato
  ) async {
    var model = Closure(
      datePosition: datePosition,
      cashBalance: cashBalance,
      pixBalance: pixBalance,
      debit: debit,
      credit: credit,
      opening: opening,
      closure: closure,
      employeeExpenses: employeeOutcomes,
      gas: gas,
      potato: potato,
    );
    
    int affected = 0;

    affected += await DB.insertDailyBalance(model.toDailyBalanceMap());
    affected += await DB.insertCardMovement(model.toCardMovementMap());
    affected += await DB.insertRegister(model.toRegisterMap());

    for (var map in model.toExpensesMap()) {
      await DB.insertExpenses(map);
    }
  }
}