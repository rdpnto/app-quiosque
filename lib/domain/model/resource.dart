class Resource {
  String name;
  String description;
  bool isEmployee;
  double? salary;

  int? id;

  Resource({
    required this.name,
    required this.description,
    required this.isEmployee,
    this.salary
  });

  void setId(int? id) {
    if (id == null) return;

    this.id = id;
  }

  Map<String, Object?> toMap() {
    if (id == null) {
      return {
        'name': name,
        'description': description,
        'fl_employee': isEmployee,
        'salary': salary
      };
    }

    return {
      'id': id,
      'name': name,
      'description': description,
      'fl_employee': isEmployee,
      'salary': salary
    };
  }
}