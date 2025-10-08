import 'package:shared_preferences/shared_preferences.dart';
import 'package:restaurant_app/data/model/setting.dart';

class SharedPreferencesService {
  static const String keyDarkMode = 'isDarkMode';

  Future<void> saveSettingValue(Setting setting) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyDarkMode, setting.isDarkMode);
  }

  Future<Setting> getSettingValue() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(keyDarkMode) ?? false;
    return Setting(isDarkMode: isDarkMode);
  }
}
