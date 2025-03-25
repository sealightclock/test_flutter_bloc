import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../data/local/hive_service.dart';
import '../../../domain/models/mood_entry.dart';
import 'mood_event.dart';
import 'mood_state.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  final HiveService hiveService;

  MoodBloc(this.hiveService)
      : super(const MoodState(mood: 'Happy', note: 'Feeling good!')) {
    on<LoadMood>(_onLoadMood);
    on<UpdateMood>(_onUpdateMood);
  }

  Future<void> _onLoadMood(LoadMood event, Emitter<MoodState> emit) async {
    final entry = await hiveService.getMoodEntry();
    emit(MoodState(
      mood: entry?.mood ?? 'Happy',
      note: entry?.note ?? 'Feeling good!',
    ));
  }

  Future<void> _onUpdateMood(UpdateMood event, Emitter<MoodState> emit) async {
    final entry = MoodEntry(mood: event.mood, note: event.note);
    await hiveService.storeMoodEntry(entry);
    emit(MoodState(mood: event.mood, note: event.note));
  }
}
