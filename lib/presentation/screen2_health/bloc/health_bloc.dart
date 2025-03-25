import 'package:flutter_bloc/flutter_bloc.dart';
import 'health_event.dart';
import 'health_state.dart';
import '../../../data/local/hive_service.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  static const String healthBoxName = 'healthBox';

  final HiveService hiveService;

  HealthBloc(this.hiveService)
      : super(const HealthState(steps: 0, water: 0)) {
    on<LoadHealth>(_onLoadHealth);
    on<UpdateHealth>(_onUpdateHealth);
  }

  Future<void> _onLoadHealth(LoadHealth event, Emitter<HealthState> emit) async {
    final steps = await hiveService.getData(healthBoxName, 'steps') ?? 0;
    final water = await hiveService.getData(healthBoxName, 'water') ?? 0;
    emit(HealthState(steps: steps, water: water));
  }

  Future<void> _onUpdateHealth(UpdateHealth event, Emitter<HealthState> emit) async {
    await hiveService.storeData(healthBoxName, 'steps', event.steps);
    await hiveService.storeData(healthBoxName, 'water', event.water);
    emit(HealthState(steps: event.steps, water: event.water));
  }
}
