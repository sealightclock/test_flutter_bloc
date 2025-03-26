import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/models/mood_entry.dart';

class MoodHiveService {
  static bool _isInitialized = false;
  static const String _boxName = 'moodBox';

  static Future<void> _init() async {
    if (!_isInitialized) {
      await Hive.initFlutter();
      Hive.registerAdapter(MoodEntryAdapter());
      _isInitialized = true;
    }
  }

  Future<void> storeMoodEntry(MoodEntry entry) async {
    await _init();
    final box = await Hive.openBox<MoodEntry>(_boxName);
    await box.put('entry', entry);
  }

  Future<MoodEntry?> getMoodEntry() async {
    await _init();
    final box = await Hive.openBox<MoodEntry>(_boxName);
    return box.get('entry');
  }
}
