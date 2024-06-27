import 'dart:async';

import 'package:mobile/data/mapper.dart';
import 'package:mobile/data/model/daily_balance_dto.dart';
import 'package:mobile/data/model/resource_dto.dart';
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
        onCreate: (db, version) async => await db.execute(CommandSQL.createTablesSQL),
        onOpen: (db) async => await reset(db, _version)
      );
    }
    catch (ex) {
      print(ex);
    }
  }

  static reset(Database db, int version) async {
    await db.execute('drop table if exists $tableDailyBalance;');
    await db.execute('drop table if exists $tableCardMovement;');
    await db.execute('drop table if exists $tableRegister;');
    await db.execute('drop table if exists $tableExpenses;');
    await db.execute('drop table if exists $tableResources;');
    await db.execute('drop table if exists $tableCardTaxes;');

    await db.execute(CommandSQL.createDailyBalanceTableSql);
    await db.execute(CommandSQL.createCardMovementTableSql);
    await db.execute(CommandSQL.createRegisterTableSql);
    await db.execute(CommandSQL.createExpensesTableSql);
    await db.execute(CommandSQL.createResourcesTableSql);
    await db.execute(CommandSQL.createCardTaxesTableSql);

    await db.execute(CommandSQL.insertDummyIntoResourceSql);
    await db.execute(CommandSQL.insertDummyIntoCardTaxesSql);
  }

  static Future<int> insertDailyBalance(Map<String, Object?> map) async => await insertItemOnTableAsync(tableDailyBalance, map);
  static Future<int> insertCardMovement(Map<String, Object?> map) async => await insertItemOnTableAsync(tableCardMovement, map);
  static Future<int> insertRegister(Map<String, Object?> map) async => await insertItemOnTableAsync(tableRegister, map);
  static Future<int> insertExpenses(Map<String, Object?> map) async => await insertItemOnTableAsync(tableExpenses, map);
  static Future<int> insertResources(Map<String, Object?> map) async => await insertItemOnTableAsync(tableResources, map);
  static Future<int> insertCardTaxes(Map<String, Object?> map) async => await insertItemOnTableAsync(tableCardTaxes, map);

  static Future<int> insertItemOnTableAsync(String tableName, Map<String, Object?> dto) async {
    return await _db!.insert(
      tableName,
      dto,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<List<DailyBalanceDto>> getAllBalances() async {
    return (await _db!
      .rawQuery(QueriesSQL.getDailyBalanceSql))
      .map((e) => DataMapper.toDailyBalanceDto(e))
      .toList();
  }

  static Future<List<ResourceDto>> getResources() async {
    return (await _db!
      .query(tableResources))
      .map((e) => DataMapper.toResourceDto(e))
      .toList();
  }
}