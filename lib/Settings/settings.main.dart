import 'package:flutter/material.dart';
import 'package:taxi/Settings/settings.languages.dart';
import 'package:taxi/Settings/settings.localization.dart';

String L(String key, {String locate = Languages.vi}) {
  return LocalizationLib.L(key, locale: locate);
}

class SizeDeviceScreen {
  late double? width;
  late double? height;
  SizeDeviceScreen({this.width, this.height});
}

class MainSetting {
  static SizeDeviceScreen getPercentageOfDevice(BuildContext context,
      {double expectHeight = 0.0, double expectWidth = 0.0}) {
    double baseWidth = MediaQuery.of(context).size.width;
    double baseHeight = MediaQuery.of(context).size.height;
    return SizeDeviceScreen(
        width: (((expectWidth / baseWidth) * 100) / 100) * baseWidth,
        height: (((expectHeight / baseHeight) * 100) / 100) * baseHeight);
  }
}
