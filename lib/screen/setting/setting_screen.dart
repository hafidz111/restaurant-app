// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/setting.dart';
import 'package:restaurant_app/data/provider/setting/local_notification_provider.dart';
import 'package:restaurant_app/data/provider/setting/shared_preferences_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDark = false;
  bool isNotificationEnabled = false;

  Future<void> _scheduleDailyTenAMNotification() async {
    context.read<LocalNotificationProvider>().scheduleDailyTenAMNotification();
  }

  Future<void> _cancelAllNotifications() async {
    final provider = context.read<LocalNotificationProvider>();
    for (final notif in provider.pendingNotificationRequests) {
      await provider.cancelNotification(notif.id);
    }
  }

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;
      final prefProvider = context.read<SharedPreferencesProvider>();
      await prefProvider.getSettingValue();
      final setting = prefProvider.setting;
      if (mounted && setting != null) {
        setState(() {
          isDark = setting.isDarkMode;
          isNotificationEnabled = setting.isNotification;
        });
      }

      await context
          .read<LocalNotificationProvider>()
          .checkPendingNotificationRequests(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefProvider = context.watch<SharedPreferencesProvider>();
    final notifProvider = context.watch<LocalNotificationProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: isDark,
            activeThumbColor: Colors.red,
            onChanged: (value) async {
              setState(() => isDark = value);
              await prefProvider.saveSettingValue(
                Setting(
                  isDarkMode: value,
                  isNotification: isNotificationEnabled,
                ),
              );

              final message = value
                  ? 'Dark Mode is Active'
                  : 'Dark Mode is Deactive';

              ScaffoldMessenger.of(
                context,
              ).showSnackBar(SnackBar(content: Text(message)));
            },
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            title: const Text('Notification (Daily 10 AM)'),
            value: isNotificationEnabled,
            activeThumbColor: Colors.blue,
            onChanged: (value) async {
              setState(() => isNotificationEnabled = value);
              await prefProvider.saveSettingValue(
                Setting(isDarkMode: isDark, isNotification: value),
              );

              if (value) {
                await notifProvider.requestPermissions();
                await _scheduleDailyTenAMNotification();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Daily notification scheduled at 10 AM'),
                  ),
                );
              } else {
                await _cancelAllNotifications();

                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('All scheduled notifications cancelled'),
                  ),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}
