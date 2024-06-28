import 'package:flutter/material.dart';
import 'package:mobile/domain/model/daily_balance.dart';
import 'package:mobile/domain/model/resource.dart';
import 'package:mobile/domain/service/balance_service.dart';

class AppState extends ChangeNotifier {
  BalanceService service = BalanceService();
  bool serviceStarted = false;

  int month = DateTime.now().month;
  int year = DateTime.now().year;
  
  List<DailyBalance> balances = [];
  List<Resource> resources = [];

  bool flagEmpl = false;

  Future<void> initService() async {
    var success = await service.init();

    if (!success) throw Exception();

    serviceStarted = success;
  }

  Future<void> insertBalance(
    DateTime datePosition,
    double cashBalance,
    double pixBalance,
    double credit,
    double debit,
    double opening,
    double closure,
    Map<String, double> employeeExpenses,
    double gas,
    double potato
  ) async {
    if (!serviceStarted) await initService();

    await service.insertBalance(
      datePosition,
      cashBalance,
      pixBalance,
      credit,
      debit,
      opening,
      closure,
      employeeExpenses,
      gas,
      potato
    );
  
    await getBalances();
  }

  Future<void> insertResource(
    String name,
    String description,
    bool isEmployee,
    double salary
  ) async {
    if (!serviceStarted) await initService();

    await service.insertResource(
      name,
      description,
      isEmployee,
      salary
    );

    await getResources();
  }

	Future<void> getBalances() async {
    if (!serviceStarted) await initService();

    balances = await service.getMontlyBalance(year, month);
    
    notifyListeners();
  }

  Future<void> getResources() async {
    if (!serviceStarted) await initService();

    resources = await service.getResources();

    notifyListeners();
  }

  Future<void> deleteResource(String name) async {
    return await service.deleteResource(name);
  }

  void setDate(int year, int month) {
    this.year = year;
    this.month = month;
  }

  void setFlag(bool flag) {
    flagEmpl = flag;
    notifyListeners();
  }
}