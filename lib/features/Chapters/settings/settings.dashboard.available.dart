import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';

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
        isHorizontal: false,
        disableColor: const Color.fromARGB(255, 179, 178, 178),
      ),
      TemplateSetting(
        backgroundColor: const Color(0xFF2D2D2D),
        fontColor: const Color(0xFFEDEDED),
        fontFamily: CustomFonts.inter,
        fontSize: 15.2,
        isLeftAlign: true,
        locationButton: KeyChapterButtonScroll.none,
        isHorizontal: false,
        disableColor: const Color.fromARGB(221, 57, 56, 56),
      ),
      TemplateSetting(
        backgroundColor: const Color(0xFF34495E),
        fontColor: const Color(0xFF2ECC71),
        fontFamily: CustomFonts.poppins,
        fontSize: 15.2,
        isLeftAlign: true,
        locationButton: KeyChapterButtonScroll.none,
        isHorizontal: false,
        disableColor: const Color.fromARGB(255, 179, 178, 178),
      )
    ];
    return fontAvailable;
  }
}
