import 'package:flutter/material.dart';
import 'package:taxi/Settings/settings.colors.dart';

class FontsDefault {
  //Fonts setting
  static const String inter = 'Inter';
  static const String poppins = 'Poppins';
  static const String abeeZees = 'AbeeZees';
  //Text style setting
  static TextStyle h1 = const TextStyle(
      fontFamily: abeeZees, fontSize: 109.66, color: ColorDefaults.titleColor);
  static TextStyle h2 = const TextStyle(
      fontFamily: abeeZees, fontSize: 67.77, color: ColorDefaults.titleColor);
  static TextStyle h3 = const TextStyle(
      fontFamily: abeeZees, fontSize: 41.89, color: ColorDefaults.titleColor);
  static TextStyle h4 = const TextStyle(
      fontFamily: poppins,
      fontSize: 25.89,
      color: ColorDefaults.defaultTextColor);
  static TextStyle h5 = const TextStyle(
      fontFamily: poppins, fontSize: 16, color: ColorDefaults.defaultTextColor);
  static TextStyle h6 = const TextStyle(
      fontFamily: poppins,
      fontSize: 9.89,
      color: ColorDefaults.defaultTextColor);
}
