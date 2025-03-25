import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static bool _isInitialized = false;

  static Future<void> _init() async {
    if (!_isInitialized) {
      await Hive.initFlutter();
      _isInitialized = true;
    }
  }

  Future<void> storeData(String boxName, String key, dynamic value) async {
    await _init();
    final box = await Hive.openBox(boxName);
    await box.put(key, value);
  }

  Future<dynamic> getData(String boxName, String key) async {
    await _init();
    final box = await Hive.openBox(boxName);
    return box.get(key);
  }
}
