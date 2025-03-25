abstract class HealthEvent {}

class LoadHealth extends HealthEvent {}

class UpdateHealth extends HealthEvent {
  final int steps;
  final int water;

  UpdateHealth({required this.steps, required this.water});
}
