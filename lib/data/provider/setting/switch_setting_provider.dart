import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/setting.dart';
import 'package:restaurant_app/data/provider/setting/local_notification_provider.dart';
import 'package:restaurant_app/data/provider/setting/shared_preferences_provider.dart';

class SwitchSettingProvider with ChangeNotifier {
  final SharedPreferencesProvider prefProvider;
  final LocalNotificationProvider notifProvider;

  bool _isDark = false;
  bool _isNotificationEnabled = false;

  bool get isDark => _isDark;
  bool get isNotificationEnabled => _isNotificationEnabled;

  SwitchSettingProvider({
    required this.prefProvider,
    required this.notifProvider,
  });

  Future<void> loadSettings() async {
    await prefProvider.getSettingValue();
    final setting = prefProvider.setting;
    if (setting != null) {
      _isDark = setting.isDarkMode;
      _isNotificationEnabled = setting.isNotification;
      notifyListeners();
    }
  }

  Future<void> toggleDarkMode(bool value, BuildContext context) async {
    _isDark = value;
    await prefProvider.saveSettingValue(
      Setting(isDarkMode: _isDark, isNotification: _isNotificationEnabled),
    );
    notifyListeners();

    final message = value ? 'Dark Mode is Active' : 'Dark Mode is Deactive';
    if (context.mounted) {
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text(message)));
    }
  }

  Future<void> toggleNotification(bool value, BuildContext context) async {
    _isNotificationEnabled = value;
    await prefProvider.saveSettingValue(
      Setting(isDarkMode: _isDark, isNotification: _isNotificationEnabled),
    );
    notifyListeners();

    if (value) {
      await notifProvider.requestPermissions();
      notifProvider.scheduleDailyElevenAMNotification();
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Daily notification scheduled at 11 AM'),
          ),
        );
      }
    } else {
      if (context.mounted) {
        await notifProvider.checkPendingNotificationRequests(context);
      }

      for (final notif in notifProvider.pendingNotificationRequests) {
        await notifProvider.cancelNotification(notif.id);
      }

      notifProvider.pendingNotificationRequests.clear();
      notifProvider.notifyListeners();

      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('All scheduled notifications cancelled'),
          ),
        );
      }
    }
  }
}
