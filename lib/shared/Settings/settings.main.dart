import 'dart:io';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/models/signalR/enum/enum.signalr.type.dart';
import 'package:muonroi/core/localization/settings.languages.dart';
import 'package:muonroi/core/models/settings/models.mainsettings.device.dart';
import 'package:muonroi/features/system/provider/theme.mode.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.mode.theme.dart';
import 'package:muonroi/core/localization/settings.localization.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:provider/provider.dart';

FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
String L(BuildContext context, String key, {String locate = Languages.vi}) {
  return LocalizationLib.L(key, locale: locate);
}

extension StringExtension on String {
  String capitalize() {
    return "${this[0].toUpperCase()}${substring(1).toLowerCase()}";
  }
}

Color themeMode(BuildContext context, String key, {String mode = Modes.light}) {
  CustomThemeModeProvider themePick = CustomThemeModeProvider();
  if (context.mounted) {
    themePick = context.watch<CustomThemeModeProvider>();
  }
  return CustomColors.themeMode(key,
      mode: themePick.mode == Modes.none ? mode : themePick.mode);
}

String N(BuildContext context, int type,
    {String locale = 'vi', List<String>? args}) {
  return LocalizationLib.N(type, locale: locale, args: args);
}

T? enumFromString<T>(Iterable<T> values, String value) {
  return values.firstWhere((type) => type.toString().split(".").last == value);
}

Widget netWorkImage(BuildContext context, String url, bool setCache,
        {bool isHome = false}) =>
    ExtendedImage.network(url,
        height: isHome
            ? MainSetting.getPercentageOfDevice(context, expectHeight: 145)
                .height
            : null,
        width: isHome
            ? MainSetting.getPercentageOfDevice(context, expectWidth: 90).width
            : null,
        fit: BoxFit.cover,
        cache: setCache, loadStateChanged: (state) {
      switch (state.extendedImageLoadState) {
        case LoadState.loading:
          return buildLoadingRow(
              context,
              MainSetting.getPercentageOfDevice(context, expectWidth: 90).width,
              MainSetting.getPercentageOfDevice(context, expectHeight: 145)
                  .height);
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

Icon backButtonCommon(BuildContext context) => Icon(
      Icons.arrow_back_ios_sharp,
      color: themeMode(context, ColorCode.textColor.name),
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

Future<XFile?> compressImage(File file, String targetPath) async {
  var result = await FlutterImageCompress.compressAndGetFile(
      file.absolute.path, targetPath,
      quality: 88, rotate: 180);
  return result;
}

Widget getEmptyData(BuildContext context) {
  return SizedBox(
    child: Center(
      child: Text(
        L(context, LanguageCodes.noDataTextInfo.toString()),
        style: CustomFonts.h5(context),
      ),
    ),
  );
}
