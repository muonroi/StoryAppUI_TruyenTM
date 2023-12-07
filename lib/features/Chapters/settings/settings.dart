import 'package:encrypt/encrypt.dart' as encrypt;
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.group.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

List<String> decryptChunkBody(dynamic items, int size) {
  List<String> chunkBody = [];
  items = convertDynamicToList(items);
  for (int i = 0; i < size; i++) {
    var chunkTemp = convertDynamicToList(items)[i];
    chunkTemp = decryptStringAES(chunkTemp);
    chunkBody.add(chunkTemp);
  }
  return chunkBody;
}

List<GroupChapterItems> decryptBodyChapterAndChunk(
    List<GroupChapterItems> items) {
  for (int i = 0; i < items.length; i++) {
    var tempChunk = [];
    for (int j = 0; j < items[i].chunkSize; j++) {
      var chunkContent =
          decryptStringAES(convertDynamicToList(items[i].bodyChunk)[j]);
      tempChunk.add(chunkContent);
    }
    items[i].bodyChunk = tempChunk;
    items[i].body = decryptStringAES(items[i].body);
  }
  return items;
}

List<String> convertDynamicToList(dynamic dynamicObject, [String? insertItem]) {
  if (dynamicObject is Iterable) {
    List<String> stringList = insertItem != null ? [insertItem] : [];
    for (var item in dynamicObject) {
      stringList.add(item.toString());
    }
    return stringList;
  } else {
    throw ArgumentError("Dynamic object is not iterable.");
  }
}

void removeIndex(int totalPageIndex, int storyId, bool isAudio) {
  for (var i = 0; i < totalPageIndex; i++) {
    chapterBox.delete("selected-chapter-$i-$storyId-$isAudio-item-index");
  }
}

Color colorFromJson(jsonColor, Color colorDefault, BuildContext context) {
  if (jsonColor == null) {
    return themeMode(context, ColorCode.textColor.name);
  }
  return Color(jsonColor);
}

int colorToJson(Color? color, int colorDefault, BuildContext context) {
  return color?.value ?? themeMode(context, ColorCode.textColor.name).value;
}

TemplateSetting getCurrentTemplate(BuildContext context) =>
    templateSettingFromJson(
        templateChapterBox.get(KeyChapterTemplate.chapterConfig.toString()) ??
            '',
        context);

void setCurrentTemplate(TemplateSetting value, BuildContext context) =>
    templateChapterBox.put(KeyChapterTemplate.chapterConfig.toString(),
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
