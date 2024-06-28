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
    await updateCardTaxCache();

    return true;
  }

  Future<void> insertResource(
    String name,
    String description,
    bool isEmployee,
    double salary
  ) async {
    var resource = Resource(
      name: name,
      description: description,
      isEmployee: isEmployee,
      salary: salary
    );

    resource.setId(DBCache.resourceIds[resource.name]);

    await DB.insertResources(resource.toMap());

    await updateResourceCache();
  }

  Future<void> insertBalance(
    DateTime datePosition,
    double cashBalance,
    double pixBalance,
    double credit,
    double debit,
    double opening,
    double closure,
    Map<String, double> employeeOutcomes,
    double gas,
    double potato
  ) async {
    final expenses = employeeOutcomes;
    if (gas > 0) expenses['Gas'] = gas;
    if (potato > 0) expenses['Batata'] = potato;

    var model = Closure(
      datePosition: datePosition,
      cashBalance: cashBalance,
      pixBalance: pixBalance,
      credit: credit,
      debit: debit,
      opening: opening,
      closure: closure,
      expenseList: expenses
    );
    
    await DB.insertDailyBalance(model.toDailyBalanceMap());
    await DB.insertCardMovement(model.toCardMovementMap());
    await DB.insertRegister(model.toRegisterMap());

    for (var map in model.expenseTrail.map((e) => e.toMap())) {
      await DB.insertExpense(map);
    }
  }
  
  static Future<void> updateResourceCache() async {
    var resources = await DB.getResources();

    DBCache.setResourceIds(
      { for (var res in resources) res.name: res.id }
    );
  }

  static Future<void> updateCardTaxCache() async {
    var taxes = await DB.getCardTaxes();

    DBCache.setCardTax(taxes.creditTax, taxes.debitTax);
  }

  Future<List<DailyBalance>> getMontlyBalance(int year, int month) async {
    var startDate = DateTime(year, month, 1);
    var endDate = DateTime(year, month + 1, 1).add(Duration(days: -1));

    var response = await DB.getAllBalances(
      startDate.toUtc().millisecondsSinceEpoch,
      endDate.toUtc().millisecondsSinceEpoch
    );

    return response
      .map((dto) => DomainMapper.toClosure(dto))
      .map((mod) => DomainMapper.toDailyBalance(mod))
      .toList();
  }

  Future<List<Resource>> getResources() async {
    var response = await DB.getResources();

    return response
      .map((dto) => DomainMapper.toResource(dto))
      .toList();
  }

  Future<void> deleteResource(String name) async {
    var toDelete = Resource(
      name: name,
      description: "",
      isEmployee: false
    );
    
    var id = DBCache.resourceIds[toDelete.name]!;

    return await DB.deleteResource(id);
  }
}