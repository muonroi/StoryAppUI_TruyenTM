import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

TemplateSetting templateSettingFromJson(String str, BuildContext context) =>
    str == ''
        ? TemplateSetting()
        : TemplateSetting.fromJson(context, json.decode(str));

String templateSettingToJson(TemplateSetting data, BuildContext context) =>
    json.encode(data.toJson(context));

class TemplateSetting with ChangeNotifier {
  String? fontFamily;
  Color? fontColor;
  Color? backgroundColor;
  double? fontSize;
  bool? isLeftAlign;
  bool? isHorizontal;
  Color? disableColor;
  KeyChapterButtonScroll? locationButton;

  TemplateSetting(
      {this.fontSize,
      this.fontFamily,
      this.fontColor,
      this.backgroundColor,
      this.isLeftAlign,
      this.locationButton,
      this.isHorizontal,
      this.disableColor});
  set valueSetting(TemplateSetting newValue) {
    disableColor = newValue.disableColor;
    fontColor = newValue.fontColor;
    backgroundColor = newValue.backgroundColor;
    fontSize = newValue.fontSize;
    isLeftAlign = newValue.isLeftAlign;
    locationButton = newValue.locationButton;
    fontFamily = newValue.fontFamily;
    isHorizontal = newValue.isHorizontal;
    notifyListeners();
  }

  factory TemplateSetting.fromJson(
          BuildContext context, Map<String, dynamic> json) =>
      TemplateSetting(
        disableColor: colorFromJson(json["disableColor"],
            themeMode(context, ColorCode.textColor.name), context),
        fontFamily: json["fontFamily"],
        fontColor: colorFromJson(json["fontColor"],
            themeMode(context, ColorCode.textColor.name), context),
        backgroundColor: colorFromJson(json["backgroundColor"],
            themeMode(context, ColorCode.modeColor.name), context),
        fontSize: checkDouble(json["fontSize"]),
        isLeftAlign: json["isLeftAlign"] != "null"
            ? bool.parse(json["isLeftAlign"])
            : bool.parse("false"),
        locationButton:
            KeyChapterButtonScroll.fromJson(json["locationButton"] ?? 'none'),
        isHorizontal: json["isHorizontal"] != "null"
            ? bool.parse(json["isHorizontal"])
            : bool.parse("false"),
      );
  Map<String, dynamic> toJson(BuildContext context) => {
        "disableColor": colorToJson(disableColor,
            themeMode(context, ColorCode.textColor.name).value, context),
        "fontFamily": fontFamily,
        "fontColor": colorToJson(fontColor,
            themeMode(context, ColorCode.textColor.name).value, context),
        "backgroundColor": colorToJson(backgroundColor,
            themeMode(context, ColorCode.modeColor.name).value, context),
        "fontSize": checkDouble(fontSize),
        "isLeftAlign": isLeftAlign.toString(),
        "locationButton": locationButton?.toJson(),
        "isHorizontal": isHorizontal.toString(),
      };
}
