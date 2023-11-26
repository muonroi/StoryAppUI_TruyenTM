import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.languages.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

class CustomThemeModeProvider extends ChangeNotifier {
  String _modeName = Modes.none;
  String _languageName = Languages.none;
  CustomThemeModeProvider() {
    _loadLanguageThemeMode();
  }

  Future<void> _loadLanguageThemeMode() async {
    final sharedPreferences = await SharedPreferences.getInstance();
    if (_modeName == Modes.none) {
      _modeName = sharedPreferences.getString('currentTemplate') ?? Modes.light;
    }
    if (_languageName == Languages.none) {
      _languageName =
          sharedPreferences.getString('currentLanguage') ?? Languages.vi;
    }
    notifyListeners();
  }

  String get language => _languageName;
  set changeLanguage(String value) {
    _languageName = value;
    notifyListeners();
  }

  String get mode => _modeName;
  set changeMode(String mode) {
    _modeName = mode;
    notifyListeners();
  }
}
