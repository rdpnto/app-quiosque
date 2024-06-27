class OutcomeTrail {
  Map<String, double> employees;
  double gas;
  double potato;

  double get total => employees.values.reduce((sum, val) => sum + val) + gas + potato;

  OutcomeTrail({
    required this.employees,
    required this.gas,
    required this.potato
  });
}