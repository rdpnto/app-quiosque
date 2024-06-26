import 'dart:async';

import 'package:mobile/data/mapper.dart';
import 'package:mobile/data/model/daily_balance_dto.dart';
import 'package:mobile/data/sql/commands.dart';
import 'package:mobile/data/sql/queries.dart';
import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static const String tableDailyBalance = 'tb_daily_balance';
  static const String tableCardMovement = 'tb_card_movement';
  static const String tableRegister = 'tb_register';
  static const String tableExpenses = 'tb_expenses';
  static const String tableResources = 'tb_resources';
  static const String tableCardTaxes = 'tb_card_taxes';

  static Database? _db;
  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) return;

    try {
      var dbPath = await getDatabasesPath();
      var path = p.join(dbPath, 'quiosque.db');

      _db = await openDatabase(
        path,
        version: _version,
        onCreate: (db, v) async { await db.execute(CommandSQL.createTablesSQL); await db.execute(CommandSQL.dummyDataSQL); }
      );
    }
    catch (ex) {
      print(ex);
    }
  }

  static Future<int> insertItemOnTableAsync(String tableName, Map<String, Object?> dto) async =>
    await _db!.insert(
      tableName,
      dto,
      conflictAlgorithm: ConflictAlgorithm.replace
    );

  static Future<int> insertDailyBalance(Map<String, Object?> dto) async => await insertItemOnTableAsync(tableDailyBalance, dto);
  static Future<int> insertCardMovement(Map<String, Object?> dto) async => await insertItemOnTableAsync(tableCardMovement, dto);
  static Future<int> insertRegister(Map<String, Object?> dto) async => await insertItemOnTableAsync(tableRegister, dto);
  static Future<int> insertExpenses(Map<String, Object?> dto) async => await insertItemOnTableAsync(tableExpenses, dto);
  static Future<int> insertResources(Map<String, Object?> dto) async => await insertItemOnTableAsync(tableResources, dto);
  static Future<int> insertCardTaxes(Map<String, Object?> dto) async => await insertItemOnTableAsync(tableCardTaxes, dto);

  static Future<List<DailyBalanceDto>> getAllBalances() async {
    return (await _db!
      .rawQuery(QueriesSQL.getDailyBalanceSql))
      .map((e) => Mapper.toDto(e))
      .toList();
  }
}