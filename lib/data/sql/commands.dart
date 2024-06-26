import 'dart:core';

class CommandSQL {
  static const String tableDailyBalance = 'tb_daily_balance';
  static const String tableCardMovement = 'tb_card_movement';
  static const String tableRegister = 'tb_register';
  static const String tableExpenses = 'tb_expenses';
  static const String tableResources = 'tb_resources';
  static const String tableCardTaxes = 'tb_card_taxes';

  static const String createTablesSQL = """
  create table if not exists $tableDailyBalance(
    date integer primary key,
    cash real not null,
    pix real not null
  );

  create table if not exists $tableCardMovement(
    date integer primary key,
    credit real not null,
    debit real not null
  );

  create table if not exists $tableRegister(
    date integer primary key,
    opening real not null,
    closure real not null,
    difference real
  );

  create table if not exists $tableExpenses(
    date integer,
    resource_id integer not null,
    name text not null,
    value real not null,
    foreign key (resource_id) references tb_resources(id)
  );

  create table if not exists $tableResources(
    id integer primary key autoincrement,
    name text not null,
    description text,
    fl_employee integer not null,
    salary real
  );

  create table if not exists $tableCardTaxes(
    credit_tax real not null,
    debit_tax real not null
  );""";

  static const String dummyDataSQL = """
  INSERT INTO $tableDailyBalance(date, cash, pix) VALUES
  (1717238400, 1000.00, 500.00);

  INSERT INTO $tableCardMovement(date, credit, debit) VALUES
  (1717238400, 300.00, 200.00);

  INSERT INTO $tableRegister(date, opening, closure, difference) VALUES
  (1717238400, 1500.00, 1550.00, 50.00);

  INSERT INTO $tableResources(id, name, description, fl_employee, salary) VALUES
  ('Vitor Pinto', 'Funcionario', 1, 800),
  ('Vitor Paulo', 'Funcionario', 1, 1500),
  ('Gabriel', 'Funcionario', 1, 1200),
  ('Gas', 'Gas', 0, null),
  ('Batata', 'Batata', 0, null);

  INSERT INTO $tableExpenses(date, resource_id, name, value) VALUES
  (1717238400, 2, 'Vale', 100),
  (1717238400, 1, 'Vale', 50),
  (1717238400, 4, 'Gas', 87),
  (1717238400, 5, 'Batata', 300);

  INSERT INTO $tableCardTaxes(credit_tax, debit_tax) VALUES
  (2.99, 1.19);
  """;

  static const String reset = """
  drop table if exists $tableDailyBalance;
  drop table if exists $tableCardMovement;
  drop table if exists $tableRegister;
  drop table if exists $tableExpenses;
  drop table if exists $tableResources;
  drop table if exists $tableCardTaxes;
  """;

  static const String createDailyBalanceTableSql = """
  create table if not exists $tableDailyBalance(
    date integer primary key,
    cash real not null,
    pix real not null
  );""";

  static const String createCardMovementTableSql = """
  create table if not exists $tableCardMovement(
    date integer primary key,
    credit real not null,
    debit real not null
  );""";

  static const String createRegisterTableSql = """
  create table if not exists $tableRegister(
    date integer primary key,
    opening real not null,
    closure real not null,
    difference real
  );""";

  static const String createExpensesTableSql = """
  create table if not exists $tableExpenses(
    date integer,
    resource_id integer not null,
    name text not null,
    value real not null,
    foreign key (resource_id) references tb_resources(id)
  );""";

  static const String createResourcesTableSql = """
  create table if not exists $tableResources(
    id integer primary key autoincrement,
    name text not null,
    description text,
    fl_employee integer not null,
    salary real
  );""";

  static const String createCardTaxesTableSql = """
  create table if not exists $tableCardTaxes(
    credit_tax real not null,
    debit_tax real not null
  );""";

  static const String insertDummyIntoDailyBalanceSql = """
  INSERT INTO $tableDailyBalance(date, cash, pix) VALUES
  (1717238400, 1000.00, 500.00),
  (1717324800, 1100.00, 550.00),
  (1717411200, 1050.00, 525.00),
  (1717497600, 1200.00, 600.00),
  (1717584000, 1150.00, 575.00),
  (1717670400, 1300.00, 650.00),
  (1717756800, 1250.00, 625.00),
  (1717843200, 1400.00, 700.00),
  (1717929600, 1350.00, 675.00),
  (1718016000, 1500.00, 750.00);""";

  static const String insertDummyIntoCardMovementSql = """
  INSERT INTO $tableCardMovement(date, credit, debit) VALUES
  (1717238400, 300.00, 200.00),
  (1717324800, 350.00, 250.00),
  (1717411200, 325.00, 225.00),
  (1717497600, 400.00, 300.00),
  (1717584000, 375.00, 275.00),
  (1717670400, 450.00, 350.00),
  (1717756800, 425.00, 325.00),
  (1717843200, 500.00, 400.00),
  (1717929600, 475.00, 375.00),
  (1718016000, 550.00, 450.00);""";

  static const String insertDummyIntoRegisterSql = """
  INSERT INTO $tableRegister(date, opening, closure, difference) VALUES
  (1717238400, 1500.00, 1550.00, 50.00),
  (1717324800, 1600.00, 1650.00, 50.00),
  (1717411200, 1550.00, 1600.00, 50.00),
  (1717497600, 1700.00, 1750.00, 50.00),
  (1717584000, 1650.00, 1700.00, 50.00),
  (1717670400, 1800.00, 1850.00, 50.00),
  (1717756800, 1750.00, 1800.00, 50.00),
  (1717843200, 1900.00, 1950.00, 50.00),
  (1717929600, 1850.00, 1900.00, 50.00),
  (1718016000, 2000.00, 2050.00, 50.00);""";

  static const String insertDummyIntoResourceSql = """
  insert into tb_resources(name, description, fl_employee, salary) values
  ('Vitor Pinto', 'Funcionario', 1, 800),
  ('Vitor Paulo', 'Funcionario', 1, 1500),
  ('Gabriel', 'Funcionario', 1, 1200),
  ('Gas', 'Gas', 0, null),
  ('Batata', 'Batata', 0, null);""";

  static const String insertDummyIntoExpenseTableSql = """
  INSERT INTO $tableExpenses(date, resource_id, name, value) VALUES
  (1717238400, 1, 'Expense 1', 100.00),
  (1717324800, 2, 'Expense 2', 200.00),
  (1717411200, 3, 'Expense 3', 300.00),
  (1717497600, 4, 'Expense 4', 400.00),
  (1717584000, 5, 'Expense 5', 500.00),
  (1717670400, 6, 'Expense 6', 600.00),
  (1717756800, 7, 'Expense 7', 700.00),
  (1717843200, 8, 'Expense 8', 800.00),
  (1717929600, 9, 'Expense 9', 900.00),
  (1718016000, 10, 'Expense 10', 1000.00);""";

  static const String insertDummyIntoCardTaxesSql = """
  INSERT INTO $tableCardTaxes(credit_tax, debit_tax) VALUES
  (2.99, 1.19);""";
}