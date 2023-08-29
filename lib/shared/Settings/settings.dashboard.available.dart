import 'package:flutter/material.dart';
import 'package:muonroi/shared/Settings/settings.colors.dart';
import 'package:muonroi/shared/Settings/settings.fonts.dart';
import 'package:muonroi/features/Chapters/provider/models.chapter.ui.available.settings.dart';

class DashboardSettings {
  static List<SettingObject> getDashboardAvailableSettings() {
    List<SettingObject> fontAvailable = [
      SettingObject(
        backgroundColor: ColorDefaults.thirdMainColor,
        fontColor: ColorDefaults.lightAppColor,
        fontFamily: FontsDefault.inter,
        fontSize: 15,
      ),
      SettingObject(
        backgroundColor: const Color.fromARGB(217, 247, 244, 120),
        fontColor: ColorDefaults.thirdMainColor,
        fontFamily: FontsDefault.poppins,
        fontSize: 15,
      )
    ];
    return fontAvailable;
  }
}
