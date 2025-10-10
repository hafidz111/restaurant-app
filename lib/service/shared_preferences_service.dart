import 'package:restaurant_app/data/model/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferencesService {
  static const String keyDarkMode = 'isDarkMode';
  static const String keyNotification = 'isNotification';

  Future<void> saveSettingValue(Setting setting) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(keyDarkMode, setting.isDarkMode);
    await prefs.setBool(keyNotification, setting.isNotification);
  }

  Future<Setting> getSettingValue() async {
    final prefs = await SharedPreferences.getInstance();
    final isDarkMode = prefs.getBool(keyDarkMode) ?? false;
    final isNotification = prefs.getBool(keyNotification) ?? false;
    return Setting(isDarkMode: isDarkMode, isNotification: isNotification);
  }
}
