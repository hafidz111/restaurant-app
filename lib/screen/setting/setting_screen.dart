import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/provider/setting/switch_setting_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  void initState() {
    super.initState();
    final switchProvider = context.read<SwitchSettingProvider>();

    Future.microtask(() => switchProvider.loadSettings());
  }

  @override
  Widget build(BuildContext context) {
    final switchProvider = context.watch<SwitchSettingProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          SwitchListTile(
            title: const Text('Dark Mode'),
            value: switchProvider.isDark,
            activeThumbColor: Colors.red,
            onChanged: (value) => switchProvider.toggleDarkMode(value, context),
          ),
          const SizedBox(height: 10),
          SwitchListTile(
            title: const Text('Notification (Daily 11 AM)'),
            value: switchProvider.isNotificationEnabled,
            activeThumbColor: Colors.blue,
            onChanged: (value) =>
                switchProvider.toggleNotification(value, context),
          ),
        ],
      ),
    );
  }
}
