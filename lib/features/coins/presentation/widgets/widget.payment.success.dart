import 'dart:async';

import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/homes/presentation/pages/page.ladding.index.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprintf/sprintf.dart';

class PaymentSuccessNotice extends StatefulWidget {
  final String paymentInfo;
  const PaymentSuccessNotice({super.key, required this.paymentInfo});

  @override
  State<PaymentSuccessNotice> createState() => _PaymentSuccessNoticeState();
}

class _PaymentSuccessNoticeState extends State<PaymentSuccessNotice> {
  @override
  void initState() {
    _seconds = 5;
    super.initState();
    _initSharedPreferences().then((value) {
      startCountdown();
    });
  }

  void startCountdown() {
    const oneSecond = Duration(seconds: 1);
    Timer.periodic(oneSecond, (timer) {
      if (_seconds == 0) {
        var accountResult =
            accountSignInFromJson(_sharedPreferences.getString('userLogin')!)
                .result!;
        timer.cancel();
        Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (builder) => IndexPage(accountResult: accountResult)));
      } else {
        setState(() {
          _seconds--;
        });
      }
    });
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  late SharedPreferences _sharedPreferences;
  late int _seconds;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
          child: Container(
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: themeMode(context, ColorCode.modeColor.name),
          borderRadius: BorderRadius.circular(8),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              size: MainSetting.getPercentageOfDevice(context, expectHeight: 90)
                  .height,
              Icons.check_circle,
              color: themeMode(context, ColorCode.mainColor.name),
            ),
            SizedBox(
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 10)
                        .width),
            Text(
              L(context, LanguageCodes.paymentSuccessTextInfo.toString()),
              style: CustomFonts.h5(context),
            ),
            SizedBox(
                height:
                    MainSetting.getPercentageOfDevice(context, expectHeight: 18)
                        .height),
            Text(
              sprintf(
                  L(
                      context,
                      LanguageCodes.paymentSuccessCustomerInfoTextInfo
                          .toString()),
                  [widget.paymentInfo]),
              style:
                  CustomFonts.h5(context).copyWith(fontStyle: FontStyle.italic),
            ),
            SizedBox(
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 10)
                        .width),
            Text(
              sprintf(
                  "${L(context, LanguageCodes.timeBackToHomeTextInfo.toString())}s",
                  [_seconds]),
              style:
                  CustomFonts.h5(context).copyWith(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      )),
    );
  }
}
