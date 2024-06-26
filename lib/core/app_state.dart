import 'package:flutter/material.dart';
import 'package:mobile/data/db_management.dart';
import 'package:mobile/data/model/daily_balance_dto.dart';
import 'package:mobile/domain/closure.dart';
import 'package:mobile/domain/daily_balance.dart';

class AppState extends ChangeNotifier {
  int month = DateTime.now().month;
  int year = DateTime.now().year;

  AppState() {
    DB.init();
  }
  
  List<DailyBalance> balances = <DailyBalance>[];

  Future<void> insertBalance() async {
    var dto = Mapper.toDto(Closure(
      datePosition: DateTime.now(),
      cashBalance: 100,
      pixBalance: 100,
      credit: 100,
      debit: 100,
      opening: 100,
      closure: 120,
      employeeOutcomes: { 'vitor': 10 },
      gas: 10,
      potato: 10
    ));

    await DB.insertDailyBalance(dto);
    notifyListeners();
  }

	Future<void> getBalances() async {
    total = await DB.getAllBalances();
    
    notifyListeners();
  }
}