import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.languages.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class CustomThemeModeProvider extends ChangeNotifier {
  String _modeName = Modes.none;
  String _languageName = Languages.none;
  CustomThemeModeProvider() {
    _loadLanguageThemeMode();
  }

  Future<void> _loadLanguageThemeMode() async {
    if (_modeName == Modes.none) {
      _modeName = systemBox.get('currentTemplate') ?? Modes.light;
    }
    if (_languageName == Languages.none) {
      _languageName = systemBox.get('currentLanguage') ?? Languages.vi;
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
