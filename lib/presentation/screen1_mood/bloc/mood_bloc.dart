import 'package:flutter_bloc/flutter_bloc.dart';
import 'mood_event.dart';
import 'mood_state.dart';
import '../../../data/local/hive_service.dart';

class MoodBloc extends Bloc<MoodEvent, MoodState> {
  static const String moodBoxName = 'moodBox';

  final HiveService hiveService;

  MoodBloc(this.hiveService)
      : super(const MoodState(mood: 'Happy', note: 'Feeling good!')) {
    on<LoadMood>(_onLoadMood);
    on<UpdateMood>(_onUpdateMood);
  }

  Future<void> _onLoadMood(LoadMood event, Emitter<MoodState> emit) async {
    final mood = await hiveService.getData(moodBoxName, 'mood') ?? 'Happy';
    final note = await hiveService.getData(moodBoxName, 'note') ?? 'Feeling good!';
    emit(MoodState(mood: mood, note: note));
  }

  Future<void> _onUpdateMood(UpdateMood event, Emitter<MoodState> emit) async {
    await hiveService.storeData(moodBoxName, 'mood', event.mood);
    await hiveService.storeData(moodBoxName, 'note', event.note);
    emit(MoodState(mood: event.mood, note: event.note));
  }
}
