abstract class MoodEvent {}

class LoadMood extends MoodEvent {}

class UpdateMood extends MoodEvent {
  final String mood;
  final String note;

  UpdateMood({required this.mood, required this.note});
}
