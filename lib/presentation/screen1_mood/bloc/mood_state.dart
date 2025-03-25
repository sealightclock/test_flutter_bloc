class MoodState {
  final String mood;
  final String note;

  MoodState({required this.mood, required this.note});

  MoodState copyWith({String? mood, String? note}) {
    return MoodState(
      mood: mood ?? this.mood,
      note: note ?? this.note,
    );
  }
}
