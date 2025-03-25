import 'package:flutter_bloc/flutter_bloc.dart';
import 'mood_event.dart';
import 'mood_state.dart';
import '../../../data/local/hive_service.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final HiveService hiveService;

  MoodBloc(this.hiveService)
      : super(MoodState(mood: 'Happy', note: 'Feeling good!')) {
    on<LoadMood>((event, emit) async {
      final mood = await hiveService.getData(HiveService.moodBoxName, 'mood') ?? 'Happy';
      final note = await hiveService.getData(HiveService.moodBoxName, 'note') ?? 'Feeling good!';
      emit(MoodState(mood: mood, note: note));
    });

    on<UpdateMood>((event, emit) async {
      await hiveService.storeData(HiveService.moodBoxName, 'mood', event.mood);
      await hiveService.storeData(HiveService.moodBoxName, 'note', event.note);
      emit(MoodState(mood: event.mood, note: event.note));
    });
  }
}
