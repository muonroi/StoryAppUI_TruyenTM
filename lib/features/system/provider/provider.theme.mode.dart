import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomThemeModeProvider extends ChangeNotifier {
  String _modeName = Modes.none;
  CustomThemeModeProvider() {
    _loadThemeMode();
  }

  Future<void> _loadThemeMode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (_modeName == Modes.none) {
      _modeName = sharedPreferences.getString('currentTemplate') ?? Modes.light;
    }
    notifyListeners();
  }

  String get mode => _modeName;
  set changeMode(String mode) {
    _modeName = mode;
    notifyListeners();
  }
}
