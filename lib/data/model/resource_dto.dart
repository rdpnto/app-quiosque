class ResourceDto {
  int id;
  String name;
  String description;
  bool isEmployee;
  double? salary;

  ResourceDto({
    required this.id,
    required this.name,
    required this.description,
    required this.isEmployee,
    this.salary
  });
}