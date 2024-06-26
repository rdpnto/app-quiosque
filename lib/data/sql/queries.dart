class QueriesSQL {
  static const String getDailyBalanceSql = """
  select
    bal.date,
    bal.cash,
    bal.pix,
    crd.credit,
    crd.debit,
    reg.opening,
    reg.closure,
    sum(exp.value) expenses
  from tb_daily_balance bal
  join tb_card_movement crd
    on bal.date = crd.date
  join tb_register reg
    on bal.date = reg.date
  join tb_expenses exp
    on bal.date = exp.date
  join tb_resources res
    on exp.resource_id = res.id
  group BY
    bal.date,
      bal.cash,
      bal.pix,
      crd.credit,
      crd.debit,
      reg.opening,
      reg.closure;""";
}