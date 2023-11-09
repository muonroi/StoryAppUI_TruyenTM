import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';

class CustomColors {
  static final Map<String, Map<String, Color>> _themeSetting = {
    Modes.dark: {
      ColorCode.mainColor.name: const Color(0xFFFFB800),
      ColorCode.textColor.name: const Color(0xFFEDEDED),
      ColorCode.modeColor.name: const Color(0xFF2D2D2D),
      ColorCode.disableColor.name: const Color.fromARGB(221, 57, 56, 56),
      ColorCode.selectedColor.name: const Color.fromARGB(71, 152, 152, 152),
    },
    Modes.light: {
      ColorCode.mainColor.name: const Color(0xFFFFB800),
      ColorCode.textColor.name: const Color(0xFF2D2D2D),
      ColorCode.modeColor.name: const Color(0xFFFFFFFF),
      ColorCode.disableColor.name: const Color.fromRGBO(238, 238, 238, 1),
      ColorCode.selectedColor.name: const Color.fromARGB(40, 91, 90, 90),
    },
  };
  static Color themeMode(String key, {String mode = Modes.light}) {
    return _themeSetting[mode]![key] ??
        _themeSetting[mode]![ColorCode.mainColor.name]!;
  }
}
