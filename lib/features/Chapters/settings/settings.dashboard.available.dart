import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

class DashboardSettings {
  static List<TemplateSetting> getDashboardAvailableSettings(
      BuildContext context) {
    List<TemplateSetting> fontAvailable = [
      TemplateSetting(
          backgroundColor: themMode(context, ColorCode.modeColor.name),
          fontColor: themMode(context, ColorCode.textColor.name),
          fontFamily: FontsDefault.inter,
          fontSize: 15.2,
          isLeftAlign: true,
          locationButton: KeyChapterButtonScroll.none,
          isHorizontal: false),
      TemplateSetting(
          backgroundColor: themMode(context, ColorCode.textColor.name),
          fontColor: themMode(context, ColorCode.modeColor.name),
          fontFamily: FontsDefault.inter,
          fontSize: 15.2,
          isLeftAlign: true,
          locationButton: KeyChapterButtonScroll.none,
          isHorizontal: false),
      TemplateSetting(
          backgroundColor: themMode(context, ColorCode.mainColor.name),
          fontColor: themMode(context, ColorCode.textColor.name),
          fontFamily: FontsDefault.poppins,
          fontSize: 15.2,
          isLeftAlign: true,
          locationButton: KeyChapterButtonScroll.none,
          isHorizontal: false)
    ];
    return fontAvailable;
  }
}
