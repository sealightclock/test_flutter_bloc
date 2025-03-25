import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/local/hive_service.dart';
import '../../../domain/models/health_entry.dart';
import 'health_event.dart';
import 'health_state.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final HiveService hiveService;

  HealthBloc(this.hiveService)
      : super(const HealthState(steps: 0, water: 0)) {
    on<LoadHealth>(_onLoadHealth);
    on<UpdateHealth>(_onUpdateHealth);
  }

  Future<void> _onLoadHealth(LoadHealth event, Emitter<HealthState> emit) async {
    final entry = await hiveService.getHealthEntry();
    emit(HealthState(
      steps: entry?.steps ?? 0,
      water: entry?.water ?? 0,
    ));
  }

  Future<void> _onUpdateHealth(UpdateHealth event, Emitter<HealthState> emit) async {
    final entry = HealthEntry(steps: event.steps, water: event.water);
    await hiveService.storeHealthEntry(entry);
    emit(HealthState(steps: event.steps, water: event.water));
  }
}
