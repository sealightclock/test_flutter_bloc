import 'package:hive_flutter/hive_flutter.dart';

import '../../../domain/models/health_entry.dart';

class HealthHiveService {
  static bool _isInitialized = false;
  static const String _boxName = 'healthBox';

  static Future<void> _init() async {
    if (!_isInitialized) {
      await Hive.initFlutter();
      Hive.registerAdapter(HealthEntryAdapter());
      _isInitialized = true;
    }
  }

  Future<void> storeHealthEntry(HealthEntry entry) async {
    await _init();
    final box = await Hive.openBox<HealthEntry>(_boxName);
    await box.put('entry', entry);
  }

  Future<HealthEntry?> getHealthEntry() async {
    await _init();
    final box = await Hive.openBox<HealthEntry>(_boxName);
    return box.get('entry');
  }
}
