import 'package:hive/hive.dart';

part 'health_entry.g.dart';

@HiveType(typeId: 1)
class HealthEntry {
  @HiveField(0)
  final int steps;

  @HiveField(1)
  final int water;

  HealthEntry({required this.steps, required this.water});
}
