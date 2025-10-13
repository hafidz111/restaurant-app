import 'package:flutter/material.dart';
import 'package:restaurant_app/data/provider/setting/shared_preferences_provider.dart';

class AppInitProvider extends ChangeNotifier {
  bool _initialized = false;
  bool get initialized => _initialized;

  Future<void> initialize(SharedPreferencesProvider prefProvider) async {
    await prefProvider.getSettingValue();
    _initialized = true;
    notifyListeners();
  }
}
