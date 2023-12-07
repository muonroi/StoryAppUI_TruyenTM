import 'dart:async';
import 'package:flutter/widgets.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class CounterTimeAds extends StatefulWidget {
  final VoidCallback onSuccess;
  final int second;
  const CounterTimeAds(
      {super.key, required this.onSuccess, required this.second});

  @override
  State<CounterTimeAds> createState() => _CounterTimeAdsState();
}

class _CounterTimeAdsState extends State<CounterTimeAds> {
  @override
  void initState() {
    _strCountTimersController = StreamController<int>();
    _seconds = widget.second;
    super.initState();
    _timer = startCountDown();
  }

  Timer startCountDown() {
    const oneSecond = Duration(seconds: 1);
    return Timer.periodic(oneSecond, (timer) {
      if (_seconds == 0) {
        timer.cancel();
        widget.onSuccess();
      } else {
        _strCountTimersController.add(--_seconds);
      }
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _strCountTimersController.close();
    super.dispose();
  }

  late Timer _timer;
  late int _seconds;
  late StreamController<int> _strCountTimersController;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(30.0),
        color: themeMode(context, ColorCode.modeColor.name),
      ),
      child: StreamBuilder<int>(
        stream: _strCountTimersController.stream,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return Text(
              "${snapshot.data}",
              style: CustomFonts.h6(context).copyWith(
                color: themeMode(context, ColorCode.textColor.name),
              ),
            );
          } else {
            return Text(
              L(context, LanguageCodes.prepareCountTimesTextInfo.toString()),
              style: CustomFonts.h6(context).copyWith(
                color: themeMode(context, ColorCode.textColor.name),
              ),
            );
          }
        },
      ),
    );
  }
}
