import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

class CustomFonts {
  static List<String> getFontsNameAvailable() => [inter, poppins];
  // Fonts setting
  static const String inter = 'Inter';
  static const String poppins = 'Poppins';

  // Text style setting
  static TextStyle h1(BuildContext context) => TextStyle(
        fontFamily: inter,
        fontSize: 109.66,
        color: themMode(context, ColorCode.textColor.name),
      );

  static TextStyle h2(BuildContext context) => TextStyle(
        fontFamily: inter,
        fontSize: 67.77,
        color: themMode(context, ColorCode.textColor.name),
      );

  static TextStyle h3(BuildContext context) => TextStyle(
        fontFamily: inter,
        fontSize: 41.89,
        color: themMode(context, ColorCode.textColor.name),
      );

  static TextStyle h4(BuildContext context) => TextStyle(
        fontFamily: inter,
        fontSize: 25.89,
        color: themMode(context, ColorCode.textColor.name),
      );

  static TextStyle h5(BuildContext context) => TextStyle(
        fontFamily: inter,
        fontSize: 16,
        color: themMode(context, ColorCode.textColor.name),
      );

  static TextStyle h6(BuildContext context) => TextStyle(
        fontFamily: inter,
        fontSize: 9.89,
        color: themMode(context, ColorCode.textColor.name),
      );
}
