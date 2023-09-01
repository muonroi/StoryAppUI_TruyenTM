import 'dart:ui';

import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color colorFromJson(jsonColor, Color colorDefault) {
  if (jsonColor == null) {
    return ColorDefaults.thirdMainColor;
  }
  return Color(jsonColor);
}

int colorToJson(Color? color, int colorDefault) {
  return color?.value ?? ColorDefaults.thirdMainColor.value;
}

TemplateSetting getCurrentTemplate(SharedPreferences _sharedPreferences) =>
    templateSettingFromJson(_sharedPreferences
            .getString(KeyChapterTemplate.chapterConfig.toString()) ??
        '');

void setCurrentTemplate(
        SharedPreferences _sharedPreferences, TemplateSetting value) =>
    _sharedPreferences.setString(KeyChapterTemplate.chapterConfig.toString(),
        templateSettingToJson(value));
int calculatePageCount(int itemCount) {
  return (itemCount / 1).ceil();
}

String convertTagHtmlFormatToString(String string) {
  return string
      .replaceAll("<p>", "\n")
      .replaceAll("</p>", ".")
      .replaceAll("<br>", "\n")
      .replaceAll("<div>", "")
      .replaceAll("</div>", "")
      .replaceAll("&quot;", "\\")
      .replaceAll("&apos;", "'")
      .replaceAll("&lt;", ">")
      .replaceAll("&gt;", "<")
      .replaceAll("..", ".")
      .replaceAll(RegExp(r'<ol[^>]*>[\s\S]*?<\/ol>'), '')
      .trim();
}

double checkDouble(dynamic value) {
  if (value == null) {
    return 15.0;
  }
  if (value is String || value is int) {
    return double.parse(value.toString());
  } else {
    return value;
  }
}
