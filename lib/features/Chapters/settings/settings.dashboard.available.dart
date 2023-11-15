import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class DashboardSettings {
  static List<TemplateSetting> getDashboardAvailableSettings(
      BuildContext context) {
    List<TemplateSetting> fontAvailable = [
      TemplateSetting(
          backgroundColor: const Color(0xFFEDEDED),
          fontColor: const Color(0xFF2D2D2D),
          fontFamily: CustomFonts.inter,
          fontSize: 15.2,
          isLeftAlign: true,
          locationButton: KeyChapterButtonScroll.none,
          isHorizontal: false),
      TemplateSetting(
          backgroundColor: const Color(0xFF2D2D2D),
          fontColor: const Color(0xFFEDEDED),
          fontFamily: CustomFonts.inter,
          fontSize: 15.2,
          isLeftAlign: true,
          locationButton: KeyChapterButtonScroll.none,
          isHorizontal: false),
      TemplateSetting(
          backgroundColor: themeMode(context, ColorCode.mainColor.name),
          fontColor: themeMode(context, ColorCode.textColor.name),
          fontFamily: CustomFonts.poppins,
          fontSize: 15.2,
          isLeftAlign: true,
          locationButton: KeyChapterButtonScroll.none,
          isHorizontal: false)
    ];
    return fontAvailable;
  }
}
