import 'package:flutter_bloc/flutter_bloc.dart';
import 'health_event.dart';
import 'health_state.dart';
import '../../../data/local/hive_service.dart';

class HealthBloc extends Bloc<HealthEvent, HealthState> {
  final HiveService hiveService;

  HealthBloc(this.hiveService)
      : super(HealthState(steps: 0, water: 0)) {
    on<LoadHealth>((event, emit) async {
      final steps = await hiveService.getData(HiveService.healthBoxName, 'steps') ?? 0;
      final water = await hiveService.getData(HiveService.healthBoxName, 'water') ?? 0;
      emit(HealthState(steps: steps, water: water));
    });

    on<UpdateHealth>((event, emit) async {
      await hiveService.storeData(HiveService.healthBoxName, 'steps', event.steps);
      await hiveService.storeData(HiveService.healthBoxName, 'water', event.water);
      emit(HealthState(steps: event.steps, water: event.water));
    });
  }
}
