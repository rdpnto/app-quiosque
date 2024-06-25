import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static const String tableName = 'tb_daily_balance';

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
        onCreate: onCreate
      );
    }
    catch (ex) {
      print(ex);
    }
  }

  static onCreate(Database db, int version) {
    db.execute('''
      create table if not exists $tableName(
        date integer primary key,
        cash integer not null,
        pix integer not null,
        card integer not null,
        change integer not null,
        outcomes integer not null,
        total integer not null
      )'''
    );
  }

  static Future<void> insertDailyBalance(Map<String, Object?> dto) async {
    await _db!.insert(
      tableName,
      dto,
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }

  static Future<int> getAllBalances() async {
    var query = await _db!.query(tableName);

    return query.length;
  }
}