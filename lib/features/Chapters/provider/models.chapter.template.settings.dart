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
  bool? isHorizontal;
  KeyChapterButtonScroll? locationButton;

  TemplateSetting(
      {this.fontSize,
      this.fontFamily,
      this.fontColor,
      this.backgroundColor,
      this.isLeftAlign,
      this.locationButton,
      this.isHorizontal});
  set valueSetting(TemplateSetting newValue) {
    fontColor = newValue.fontColor;
    backgroundColor = newValue.backgroundColor;
    fontSize = newValue.fontSize;
    isLeftAlign = newValue.isLeftAlign;
    locationButton = newValue.locationButton;
    fontFamily = newValue.fontFamily;
    isHorizontal = newValue.isHorizontal;
    notifyListeners();
  }

  factory TemplateSetting.fromJson(Map<String, dynamic> json) =>
      TemplateSetting(
        fontFamily: json["fontFamily"],
        fontColor:
            colorFromJson(json["fontColor"], ColorDefaults.thirdMainColor),
        backgroundColor:
            colorFromJson(json["backgroundColor"], ColorDefaults.lightAppColor),
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
  Map<String, dynamic> toJson() => {
        "fontFamily": fontFamily,
        "fontColor": colorToJson(fontColor, ColorDefaults.thirdMainColor.value),
        "backgroundColor":
            colorToJson(backgroundColor, ColorDefaults.lightAppColor.value),
        "fontSize": checkDouble(fontSize),
        "isLeftAlign": isLeftAlign.toString(),
        "locationButton": locationButton?.toJson(),
        "isHorizontal": isHorizontal.toString(),
      };
}
