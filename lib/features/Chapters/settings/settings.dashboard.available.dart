import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';

class DashboardSettings {
  static List<TemplateSetting> getDashboardAvailableSettings() {
    List<TemplateSetting> fontAvailable = [
      TemplateSetting(
          backgroundColor: ColorDefaults.lightAppColor,
          fontColor: ColorDefaults.thirdMainColor,
          fontFamily: FontsDefault.inter,
          fontSize: 15.2,
          isLeftAlign: true,
          locationButton: KeyChapterButtonScroll.none,
          isHorizontal: false),
      TemplateSetting(
          backgroundColor: ColorDefaults.thirdMainColor,
          fontColor: ColorDefaults.lightAppColor,
          fontFamily: FontsDefault.inter,
          fontSize: 15.2,
          isLeftAlign: true,
          locationButton: KeyChapterButtonScroll.none,
          isHorizontal: false),
      TemplateSetting(
          backgroundColor: const Color.fromARGB(217, 247, 244, 120),
          fontColor: ColorDefaults.thirdMainColor,
          fontFamily: FontsDefault.poppins,
          fontSize: 15.2,
          isLeftAlign: true,
          locationButton: KeyChapterButtonScroll.none,
          isHorizontal: false)
    ];
    return fontAvailable;
  }
}
