import 'package:hive/hive.dart';

class HiveService {
  static const String moodBoxName = 'moodBox';
  static const String healthBoxName = 'healthBox';

  Future<void> storeData(String boxName, String key, dynamic value) async {
    final box = await Hive.openBox(boxName);
    await box.put(key, value);
  }

  Future<dynamic> getData(String boxName, String key) async {
    final box = await Hive.openBox(boxName);
    return box.get(key);
  }
}
