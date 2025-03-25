import 'package:hive_flutter/hive_flutter.dart';

import '../../domain/models/health_entry.dart';
import '../../domain/models/mood_entry.dart';

class HiveService {
  static bool _isInitialized = false;

  static const String moodBoxName = 'moodBox';
  static const String healthBoxName = 'healthBox';

  static Future<void> _init() async {
    if (!_isInitialized) {
      await Hive.initFlutter();
      Hive.registerAdapter(MoodEntryAdapter());
      Hive.registerAdapter(HealthEntryAdapter());
      _isInitialized = true;
    }
  }

  Future<void> storeMoodEntry(MoodEntry entry) async {
    await _init();
    final box = await Hive.openBox<MoodEntry>(moodBoxName);
    await box.put('entry', entry);
  }

  Future<MoodEntry?> getMoodEntry() async {
    await _init();
    final box = await Hive.openBox<MoodEntry>(moodBoxName);
    return box.get('entry');
  }

  Future<void> storeHealthEntry(HealthEntry entry) async {
    await _init();
    final box = await Hive.openBox<HealthEntry>(healthBoxName);
    await box.put('entry', entry);
  }

  Future<HealthEntry?> getHealthEntry() async {
    await _init();
    final box = await Hive.openBox<HealthEntry>(healthBoxName);
    return box.get('entry');
  }
}
