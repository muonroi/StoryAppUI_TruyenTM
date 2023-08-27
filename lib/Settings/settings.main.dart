import 'dart:async';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:icons_flutter/icons_flutter.dart';
import 'package:intl/intl.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.stories.vertical.dart';
import 'package:muonroi/Models/Accounts/models.account.token.dart';
import 'package:muonroi/Models/Stories/models.single.story.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/Enums/enum.search.story.dart';
import 'package:muonroi/Settings/settings.api.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.languages.dart';
import 'package:muonroi/Settings/settings.localization.dart';
import 'package:muonroi/repository/Story/story_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../Models/Settings/models.mainsettings.device.dart';

String L(String key, {String locate = Languages.vi}) {
  return LocalizationLib.L(key, locale: locate);
}

// const Icon(
//                 RpgAwesome.book,
//                 size: 56,
//               )
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
                size: 56,
              ),
            ),
          );
      }
    });

Icon backButtonCommon() => const Icon(
      Icons.arrow_back_ios_sharp,
      color: ColorDefaults.thirdMainColor,
    );
//use with category
Widget showToolTipHaveAnimationStories(String message,
    {BuildContext? context, String? data}) {
  return Positioned.fill(
    child: Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: context == null
            ? () {}
            : () async {
                List<StoryItems> storiesData =
                    await _handleSearchByCategory(data!, SearchType.category);
                if (context.mounted) {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => StoriesVerticalData(
                        isShowBack: true,
                        isShowLabel: false,
                        categoryId: int.parse(data),
                        stories: storiesData,
                      ),
                    ),
                  );
                }
              },
        child: Tooltip(
          onTriggered: () => TooltipTriggerMode.longPress,
          message: message,
          showDuration: const Duration(milliseconds: 1000),
        ),
      ),
    ),
  );
}

Future<SingleStoryModel> getInfoStory(int storyId) async {
  final StoryRepository storyRepository = StoryRepository();
  try {
    final story = await storyRepository.fetchDetailStory(storyId);
    return story;
  } on NetworkError {
    throw Exception("Failed to fetch data. is your device online?");
  }
}

Future<List<StoryItems>> _handleSearchByCategory(
    String data, SearchType type) async {
  StoryRepository storyRepository = StoryRepository();
  var resultData = await storyRepository.searchStory([data], [type], 1, 15);
  return resultData.result.items;
}

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

Future<SharedPreferences> initLocalStored() async {
  SharedPreferences localTemp = await SharedPreferences.getInstance();
  return localTemp;
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

String formatValueNumber(double value) {
  final numberFormat = NumberFormat("#,###");

  return numberFormat.format(value);
}

StorySingleResult storySingleDefaultData() {
  return StorySingleResult(
      id: -1,
      guid: "3fa85f64-5717-4562-b3fc-2c963f66afa6",
      storyTitle: "",
      storySynopsis: "",
      imgUrl: "",
      isShow: false,
      totalView: 0,
      totalFavorite: 0,
      rankNumber: 0,
      rating: 0,
      slug: "",
      nameCategory: "",
      authorName: "",
      nameTag: [],
      totalVote: 0,
      totalChapter: 0,
      updatedDateTs: 0,
      updatedDateString: "",
      firstChapterId: 0,
      lastChapterId: 0);
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
