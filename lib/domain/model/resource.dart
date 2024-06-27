class Resource {
  String name;
  String description;
  bool isEmployee;
  double? salary;

  Resource({
    required this.name,
    required this.description,
    required this.isEmployee,
    this.salary
  });

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'description': description,
      'isEmployee': isEmployee,
      'salary': salary
    };
  }
}