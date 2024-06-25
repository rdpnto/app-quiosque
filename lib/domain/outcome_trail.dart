class OutcomeTrail {
  Map<String, double> employees;
  double gas;
  double potato;
  late double total;

  OutcomeTrail({
    required this.employees,
    required this.gas,
    required this.potato
  }) {
    total = employees.values.reduce((sum, value) => sum + value) + gas + potato;
  }
}