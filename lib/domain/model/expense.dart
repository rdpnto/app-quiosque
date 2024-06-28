import 'package:mobile/data/db_cache.dart';

class Expense {
  DateTime datePosition;
  int resourceId;
  String name;
  double value;

  Expense({
    required this.datePosition,
    required this.resourceId,
    required this.name,
    required this.value,
  });

  Map<String, Object?> toMap() {
    return {
      'date': datePosition.toUtc().millisecondsSinceEpoch,
      'resource_id': DBCache.resourceIds[name],
      'name': name,
      'value': value
    };
  }
}