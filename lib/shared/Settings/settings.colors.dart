import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';

class ColorDefaults {
  static final Map<String, Map<String, Color>> _themeSetting = {
    Modes.dark: {
      ColorCode.mainColor.name: Color(0xFFFFB800),
      ColorCode.textColor.name: Color(0xFFEDEDED),
      ColorCode.modeColor.name: Color(0xFF2D2D2D),
      ColorCode.disableColor.name: Color.fromARGB(221, 57, 56, 56)
    },
    Modes.light: {
      ColorCode.mainColor.name: Color(0xFFFFB800),
      ColorCode.textColor.name: Color(0xFF2D2D2D),
      ColorCode.modeColor.name: Color(0xFFFFFFFF),
      ColorCode.disableColor.name: Color.fromRGBO(238, 238, 238, 1)
    },
  };
  static Color themeMode(String key, {String mode = Modes.light}) {
    return _themeSetting[mode]![key] ??
        _themeSetting[mode]![ColorCode.mainColor.name]!;
  }
}
