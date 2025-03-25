class HealthState {
  final int steps;
  final int water;

  const HealthState({required this.steps, required this.water});

  HealthState copyWith({int? steps, int? water}) {
    return HealthState(
      steps: steps ?? this.steps,
      water: water ?? this.water,
    );
  }
}
