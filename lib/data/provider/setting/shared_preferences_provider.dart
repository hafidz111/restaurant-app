import 'package:flutter/foundation.dart';
import 'package:restaurant_app/data/model/setting.dart';
import 'package:restaurant_app/service/shared_preferences_service.dart';

class SharedPreferencesProvider extends ChangeNotifier {
  final SharedPreferencesService _service;

  SharedPreferencesProvider(this._service);

  String _message = "";
  String get message => _message;

  Setting? _setting;
  Setting? get setting => _setting;

  Future<void> saveSettingValue(Setting value) async {
    try {
      await _service.saveSettingValue(value);
      _setting = value;
    } catch (e) {
      _message = "Failed to save your data";
    }
    notifyListeners();
  }

  Future<void> getSettingValue() async {
    try {
      _setting = await _service.getSettingValue();
    } catch (e) {
      _message = "Failed to get your data";
    }
    notifyListeners();
  }
}
