import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:shared_preferences/shared_preferences.dart';

Color colorFromJson(jsonColor, Color colorDefault, BuildContext context) {
  if (jsonColor == null) {
    return themeMode(context, ColorCode.textColor.name);
  }
  return Color(jsonColor);
}

int colorToJson(Color? color, int colorDefault, BuildContext context) {
  return color?.value ?? themeMode(context, ColorCode.textColor.name).value;
}

TemplateSetting getCurrentTemplate(
        SharedPreferences sharedPreferences, BuildContext context) =>
    templateSettingFromJson(
        sharedPreferences
                .getString(KeyChapterTemplate.chapterConfig.toString()) ??
            '',
        context);

void setCurrentTemplate(SharedPreferences sharedPreferences,
        TemplateSetting value, BuildContext context) =>
    sharedPreferences.setString(KeyChapterTemplate.chapterConfig.toString(),
        templateSettingToJson(value, context));
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

String decryptStringAES(String encryptedText) {
  encrypt.IV iv = encrypt.IV.fromBase64(dotenv.env['ENV_IV'] ?? '');
  encrypt.Key key = encrypt.Key.fromBase64(dotenv.env['ENV_SECRET'] ?? '');
  final encrypter =
      encrypt.Encrypter(encrypt.AES(key, mode: encrypt.AESMode.cbc));

  final encrypted = encrypt.Encrypted.fromBase64(encryptedText);
  final decrypted = encrypter.decrypt(encrypted, iv: iv);
  return decrypted;
}
