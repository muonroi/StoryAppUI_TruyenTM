import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';

TemplateSetting templateSettingFromJson(String str) =>
    str == '' ? TemplateSetting() : TemplateSetting.fromJson(json.decode(str));

String templateSettingToJson(TemplateSetting data) =>
    json.encode(data.toJson());

class TemplateSetting with ChangeNotifier {
  String? fontFamily;
  Color? fontColor;
  Color? backgroundColor;
  double? fontSize;
  bool? isLeftAlign;
  KeyChapterButtonScroll? locationButton;

  TemplateSetting(
      {this.fontSize,
      this.fontFamily,
      this.fontColor,
      this.backgroundColor,
      this.isLeftAlign,
      this.locationButton});
  set valueSetting(TemplateSetting newValue) {
    fontColor = newValue.fontColor;
    backgroundColor = newValue.backgroundColor;
    fontSize = newValue.fontSize;
    isLeftAlign = newValue.isLeftAlign;
    locationButton = newValue.locationButton;
    fontFamily = newValue.fontFamily;
    notifyListeners();
  }

  factory TemplateSetting.fromJson(Map<String, dynamic> json) =>
      TemplateSetting(
          fontFamily: json["fontFamily"],
          fontColor:
              colorFromJson(json["fontColor"], ColorDefaults.thirdMainColor),
          backgroundColor: colorFromJson(
              json["backgroundColor"], ColorDefaults.lightAppColor),
          fontSize: json["fontSize"] ?? 15,
          isLeftAlign: bool.parse(json["isLeftAlign"]),
          locationButton: KeyChapterButtonScroll.fromJson(
              json["locationButton"] ?? 'none'));
  Map<String, dynamic> toJson() => {
        "fontFamily": fontFamily,
        "fontColor": colorToJson(fontColor, ColorDefaults.thirdMainColor.value),
        "backgroundColor":
            colorToJson(backgroundColor, ColorDefaults.lightAppColor.value),
        "fontSize": fontSize ?? 15,
        "isLeftAlign": isLeftAlign.toString(),
        "locationButton": locationButton?.toJson(),
      };
}
