import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:muonroi/shared/Settings/settings.colors.dart';

SettingObject settingObjectFromJson(String str) =>
    str == '' ? SettingObject() : SettingObject.fromJson(json.decode(str));

String settingObjectToJson(SettingObject data) => json.encode(data.toJson());

class SettingObject with ChangeNotifier {
  String? fontFamily;
  Color? fontColor;
  Color? backgroundColor;
  double? fontSize;
  SettingObject(
      {this.fontSize, this.fontFamily, this.fontColor, this.backgroundColor});
  set valueSetting(SettingObject newValue) {
    fontColor = newValue.fontColor;
    backgroundColor = newValue.backgroundColor;
    fontSize = newValue.fontSize;
    notifyListeners();
  }

  factory SettingObject.fromJson(Map<String, dynamic> json) => SettingObject(
        fontFamily: json["fontFamily"],
        fontColor: _colorFontFromJson(json["fontColor"]),
        backgroundColor: _colorBackgroundFromJson(json["backgroundColor"]),
        fontSize: json["fontSize"] ?? 15,
      );
  Map<String, dynamic> toJson() => {
        "fontFamily": fontFamily,
        "fontColor": _colorFontToJson(fontColor),
        "backgroundColor": _colorBackgroundToJson(backgroundColor),
        "fontSize": fontSize ?? 15,
      };

  static Color _colorFontFromJson(jsonColor) {
    if (jsonColor == null) {
      return ColorDefaults.thirdMainColor;
    }
    return Color(jsonColor);
  }

  static int _colorFontToJson(Color? color) {
    return color?.value ?? ColorDefaults.thirdMainColor.value;
  }

  static Color _colorBackgroundFromJson(jsonColor) {
    if (jsonColor == null) {
      return ColorDefaults.lightAppColor;
    }
    return Color(jsonColor);
  }

  static int _colorBackgroundToJson(Color? color) {
    return color?.value ?? ColorDefaults.lightAppColor.value;
  }
}
