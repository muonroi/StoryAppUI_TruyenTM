import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:muonroi/core/SignalR/enum/enum.signalr.type.dart';
import 'package:muonroi/core/localization/settings.languages.dart';
import 'package:muonroi/core/models/settings/models.mainsettings.device.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/core/localization/settings.localization.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
String L(String key, {String locate = Languages.vi}) {
  return LocalizationLib.L(key, locale: locate);
}

String N(int type, {String locale = 'vi', List<String>? args}) {
  return LocalizationLib.N(type, locale: locale, args: args);
}

T? enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split(".").last == value);
}

Widget netWorkImage(String url, bool setCache) =>
    ExtendedImage.network(url, fit: BoxFit.cover, cache: setCache,
        loadStateChanged: (state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return const Center(child: CircularProgressIndicator());
        case LoadState.completed:
          return state.completedWidget;
        case LoadState.failed:
          return const Expanded(
            child: FittedBox(
              fit: BoxFit.cover,
              child: Icon(
                RpgAwesome.book,
                size: 25,
              ),
            ),
          );
      }
    });

Icon backButtonCommon() => const Icon(
      Icons.arrow_back_ios_sharp,
      color: ColorDefaults.thirdMainColor,
    );

Widget showToolTip(String message) {
  return Positioned.fill(
    child: Material(
      color: Colors.transparent,
      child: Tooltip(
        onTriggered: () => TooltipTriggerMode.longPress,
        message: message,
        showDuration: const Duration(milliseconds: 1000),
      ),
    ),
  );
}

TypeSignalr intToEnum(int value) {
  if (value < 0 || value >= TypeSignalr.values.length) {
    throw Exception('Invalid enum value');
  }
  return TypeSignalr.values[value];
}

class MainSetting {
  static SizeDeviceScreen getPercentageOfDevice(BuildContext context,
      {double expectHeight = 0.0, double expectWidth = 0.0}) {
    double baseWidth = MediaQuery.of(context).size.width;
    double baseHeight = MediaQuery.of(context).size.height;
    return SizeDeviceScreen(
        width: (((expectWidth / baseWidth) * 100) / 100) * baseWidth,
        height: (((expectHeight / baseHeight) * 100) / 100) * baseHeight);
  }
}
