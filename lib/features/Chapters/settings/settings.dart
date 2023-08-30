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
