import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';

class CustomThemeModeProvider extends ChangeNotifier {
  String _modeName = Modes.light;
  String get mode => _modeName;
  set changeMode(String mode) {
    _modeName = mode;
    notifyListeners();
  }
}
