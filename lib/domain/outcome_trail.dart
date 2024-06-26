class OutcomeTrail {
  double employees;
  double gas;
  double potato;
  double get total => employees + gas + potato;

  OutcomeTrail({
    required this.employees,
    required this.gas,
    required this.potato
  });
}