import 'dart:async';

import 'package:path/path.dart' as p;
import 'package:sqflite/sqflite.dart';

abstract class DB {
  static Database? _db;
  static int get _version => 1;

  static Future<void> init() async {
    if (_db != null) return;

    try {
      var dbPath = await getDatabasesPath();
      var path = p.join(dbPath, 'my_db_name.db');

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

  static onCreate(Database db, int version) => db.execute('''
    create table if not exists transactions(
      id integer primary key,
      name varchar(128) not null,
      amount integer not null,
      eventdate integer not null,
      fl_income_expense char(1) not null default 'I',
      maturity_date integer,
      due_date integer
    )'''
  );
}