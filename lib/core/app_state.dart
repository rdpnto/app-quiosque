import 'package:flutter/material.dart';
import 'package:mobile/domain/model/closure.dart';
import 'package:mobile/domain/model/daily_balance.dart';
import 'package:mobile/domain/service/balance_service.dart';

class AppState extends ChangeNotifier {
  BalanceService service = BalanceService();
  bool isServiceRunning = false;

  int month = DateTime.now().month;
  int year = DateTime.now().year;
  
  List<DailyBalance> balances = [];

  Future<void> initService() async {
    var success = await service.init();

    if (!success) throw Exception();

    isServiceRunning = success;
  }

  Future<void> insertBalance() async {
    if (!isServiceRunning) initService();

    var closure = Closure(
      datePosition: DateTime.now(),
      cashBalance: 10,
      pixBalance: 10,
      debit: 10,
      credit: 10,
      opening: 10,
      closure: 10,
      employeeExpenses: {'Vitor Pinto': 10},
      gas: 10,
      potato: 10
    );

    await service.insertBalance(
      closure.datePosition,
      closure.cashBalance,
      closure.pixBalance,
      closure.cardMovement.grossCredit,
      closure.cardMovement.grossCredit,
      closure.register.openingAmount,
      closure.register.closureAmount,
      closure.outcomeTrail.employees,
      closure.outcomeTrail.gas,
      closure.outcomeTrail.potato
    );
  
    getBalances();
  }

	Future<void> getBalances() async {
    // if (!isServiceRunning) initService();

    balances = await service.getMontlyBalance(month, year);
    
    notifyListeners();
  }
}