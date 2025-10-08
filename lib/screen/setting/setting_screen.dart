import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:restaurant_app/data/model/setting.dart';
import 'package:restaurant_app/data/provider/setting/shared_preferences_provider.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  bool isDark = false;

  @override
  void initState() {
    super.initState();
    Future.microtask(() async {
      if (!mounted) return;
      final provider = context.read<SharedPreferencesProvider>();
      await provider.getSettingValue();
      final setting = provider.setting;
      if (mounted && setting != null) {
        setState(() => isDark = setting.isDarkMode);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<SharedPreferencesProvider>();

    return Scaffold(
      appBar: AppBar(title: const Text('Settings')),
      body: Center(
        child: SwitchListTile(
          title: const Text('Dark Mode'),
          value: isDark,
          activeThumbColor: Colors.red,
          onChanged: (value) async {
            setState(() => isDark = value);

            await provider.saveSettingValue(Setting(isDarkMode: value));
          
            // ignore: use_build_context_synchronously
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text(provider.message)),
            );
          },
        ),
      ),
    );
  }
}
