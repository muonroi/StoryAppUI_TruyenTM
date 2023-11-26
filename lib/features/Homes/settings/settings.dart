import 'dart:async';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/features/homes/presentation/pages/page.ladding.index.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.loading.stories.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.images.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

Widget homeLoading({AccountResult? accountResult, bool? signinView}) {
  if (signinView != null) {
    if (accountResult == null) {
      if (signinView) {
        return const SignInPage();
      }
    } else {
      return IndexPage(
        accountResult: accountResult,
      );
    }
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: Image.asset(CustomImages.laddingLogo))
          ],
        ),
      ),
    );
  } else {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: Image.asset(CustomImages.laddingLogo))
        ],
      ),
    );
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

String formatValueNumber(double value) {
  final numberFormat = NumberFormat("#,###");

  return numberFormat.format(value);
}

void showTooltipNotification(BuildContext context) {
  final tooltip = Tooltip(
      message: L(context, LanguageCodes.recentlyStoryTextInfo.toString()),
      child: Text(
        L(context, LanguageCodes.recentlyStoryTextInfo.toString()),
        style: CustomFonts.h5(context),
        textAlign: TextAlign.center,
      ));

  ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: tooltip,
      duration: const Duration(seconds: 2),
      backgroundColor: themeMode(context, ColorCode.disableColor.name),
    ),
  );
}

Widget buildLoadingListView(
    BuildContext context, double? width, double? height, double itemExtent) {
  return SizedBox(
      height: height,
      child: CustomScrollView(
        scrollDirection: Axis.horizontal,
        slivers: <Widget>[
          SliverFixedExtentList(
            itemExtent: itemExtent,
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return buildLoadingRow(context, width, height);
              },
            ),
          ),
        ],
      ));
}

Widget buildLoadingRow(BuildContext context, double? width, double? height) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.spaceBetween,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [
      LoadingStoriesHome(
        width: width,
        height: height,
      ),
    ],
  );
}
