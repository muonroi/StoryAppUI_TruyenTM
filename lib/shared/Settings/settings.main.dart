import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:muonroi/shared/Settings/settings.api.dart';
import 'package:muonroi/shared/Settings/settings.colors.dart';
import 'package:muonroi/shared/Settings/settings.languages.dart';
import 'package:muonroi/shared/Settings/settings.localization.dart';
import 'package:muonroi/features/Accounts/data/models/models.account.token.dart';
import 'package:muonroi/core/models/Settings/models.mainsettings.device.dart';

String L(String key, {String locate = Languages.vi}) {
  return LocalizationLib.L(key, locale: locate);
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
                size: 30,
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

Dio baseUrl() {
  Dio dio = Dio();
  dio.options.baseUrl = ApiNetwork.baseApi;
  dio.options.responseType = ResponseType.plain;
  // dio.interceptors.add(LogInterceptor());
  String token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJuYW1lX3VzZXIiOiJtdW9uIiwidXNlcm5hbWUiOiJtdW9ucm9pIiwidXNlcl9pZCI6IjAxMjg0MDg5LWRhMGUtNDEwOC05MTM3LTM4NTQ3ZGFkZTY1OSIsImVtYWlsIjoibGVhbmhwaGkxNzA2QGdtYWlsLmNvbSIsImdyb3VwX2lkIjoiMSIsInJvbGUiOlsiUkVBRCIsIldSSVRFIiwiRURJVCIsIkRFTEVURSJdLCJuYmYiOjE2OTIzMzEzNDQsImV4cCI6MTY5MjMzMjI0NCwiaWF0IjoxNjkyMzMxMzQ0LCJpc3MiOiJMRjMxTE9Ga01sZjNwR1BFeXpBYWNLeFJNcHJ4ZFdaUnlhTHhDbWpEIiwiYXVkIjoiaHR0cHM6Ly9sb2NhbGhvc3Q6NTAwMS9hcGkifQ.3sFBeFYUBSnhIH5zzexLnnyoDL9uv78hk_bithoAaZc';
  String refreshTokenStr = 'XmpoRiNaYiQ0Yl5IemtuZUBUZnQlRmQhRk9ReHRnRUA=';
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler) {
        if (token != '') {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(request);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          try {
            await dio
                .post(ApiNetwork.renewToken,
                    data: jsonEncode({"refreshToken": refreshTokenStr}))
                .then((value) async {
              if (value.statusCode == 200) {
                var newToken = tokenModelFromJson(value.data.toString());
                token = newToken.result;
                e.requestOptions.headers["Authorization"] =
                    "Bearer ${newToken.result}";
                final opts = Options(
                    method: e.requestOptions.method,
                    headers: e.requestOptions.headers);
                final cloneReq = await dio.request(e.requestOptions.path,
                    options: opts, data: e.requestOptions.data);
                return handler.resolve(cloneReq);
              }
            });
          } catch (e) {
            return;
          }
        }
      },
    ),
  );
  return dio;
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
