import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muonroi/Models/Stories/models.single.story.dart';
import 'package:muonroi/Settings/settings.api.dart';
import 'package:muonroi/Settings/settings.languages.dart';
import 'package:muonroi/Settings/settings.localization.dart';
import '../Models/Settings/models.mainsettings.device.dart';

String L(String key, {String locate = Languages.vi}) {
  return LocalizationLib.L(key, locale: locate);
}

Dio baseUrl() => Dio(
    BaseOptions(responseType: ResponseType.plain, baseUrl: ApiNetwork.baseApi));

String formatValueNumber(double value) {
  final numberFormat = NumberFormat("#,###");

  return numberFormat.format(value);
}

SingleResult StorySingleDefaultData() {
  return SingleResult(
      id: -1,
      guid: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      storyTitle: "",
      storySynopsis: "",
      imgUrl: "",
      isShow: false,
      totalView: 0,
      totalFavorite: 0,
      rating: 0,
      slug: "",
      nameCategory: "",
      authorName: "",
      nameTag: [],
      totalChapters: 0,
      updatedDateTs: 0,
      updatedDateString: "");
}

String formatNumberThouSand(double value) {
  if (value >= 1000) {
    var number = value / 1000;
    var initNumber = number.truncate();
    var decimalNumber = ((number - initNumber) * 10).toInt();
    var numberString =
        '${initNumber}k${decimalNumber > 0 ? decimalNumber : ''}';
    return numberString;
  } else {
    return value.toInt().toString();
  }
}

class Debouncer {
  final Duration delay;
  Timer? _timer;

  Debouncer(this.delay);

  void call(VoidCallback action) {
    _timer?.cancel();
    _timer = Timer(delay, action);
  }

  void cancel() {
    _timer?.cancel();
  }
}

class Throttle {
  final Duration delay;
  Timer? _timer;
  bool _canCall = true;

  Throttle(this.delay);

  void call(VoidCallback action) {
    if (_canCall) {
      _canCall = false;
      action();
      _timer = Timer(delay, () => _canCall = true);
    }
  }

  void cancel() {
    _timer?.cancel();
    _canCall = true;
  }
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
