import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';

class ButtonDefaults {
  static final ButtonStyle buttonNextPagePreview = ButtonStyle(
      shape: MaterialStateProperty.all(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(50.0))),
      textStyle: MaterialStateProperty.all<TextStyle>(
          FontsDefault.h5.copyWith(fontWeight: FontWeight.w700)),
      backgroundColor: MaterialStateProperty.all(ColorDefaults.buttonColor));
}
