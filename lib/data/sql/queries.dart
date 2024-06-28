class QueriesSQL {
  static const String getDailyBalanceSql = """
  SELECT
    bal.date,
    bal.cash,
    bal.pix,
    crd.credit,
    crd.debit,
    reg.opening,
    reg.closure,
    SUM(exp.value) expenses
  FROM tb_daily_balance bal
  LEFT JOIN tb_card_movement crd ON bal.date = crd.date
  LEFT JOIN tb_register reg ON bal.date = reg.date
  LEFT JOIN tb_expenses exp ON bal.date = exp.date
  LEFT JOIN tb_resources res ON exp.resource_id = res.id
  WHERE bal.date between ? and ?
  GROUP BY
    bal.date,
    bal.cash,
    bal.pix,
    crd.credit,
    crd.debit,
    reg.opening,
    reg.closure""";
}