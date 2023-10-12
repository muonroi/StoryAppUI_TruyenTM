import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.images.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/shared/static/buttons/widget.static.button.dart';

class UpgradeAccount extends StatefulWidget {
  const UpgradeAccount({super.key});

  @override
  State<UpgradeAccount> createState() => _UpgradeAccountState();
}

class _UpgradeAccountState extends State<UpgradeAccount> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeMode(context, ColorCode.modeColor.name),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: themeMode(context, ColorCode.textColor.name),
        ),
        backgroundColor: themeMode(context, ColorCode.mainColor.name),
        elevation: 0,
        title: Text(
          L(context, LanguageCodes.upgradeAccountTextInfo.toString()),
          style: CustomFonts.h4(context),
        ),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              width:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 300)
                      .width,
              height:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 300)
                      .height,
              decoration: BoxDecoration(
                  border: Border.all(
                      color: themeMode(context, ColorCode.mainColor.name)),
                  color: themeMode(context, ColorCode.disableColor.name),
                  borderRadius: BorderRadius.circular(32.0)),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 50)
                        .width,
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 50)
                        .height,
                    child: Image.asset(
                      CustomImages.crown2x,
                      fit: BoxFit.cover,
                      color: themeMode(context, ColorCode.mainColor.name),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      L(context,
                          LanguageCodes.upgradeAccountTextInfo.toString()),
                      style: CustomFonts.h4(context).copyWith(
                          color: themeMode(context, ColorCode.mainColor.name)),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      '45.000đ/${L(context, LanguageCodes.monthTextInfo.toString())}',
                      style: CustomFonts.h4(context),
                    ),
                  ),
                  SizedBox(
                    child: ButtonWidget.buttonNavigatorNextPreviewLanding(
                        context, const SignInPage(),
                        textDisplay:
                            L(context, LanguageCodes.buyNowTextInfo.toString()),
                        textStyle: CustomFonts.h5(context).copyWith(
                            color:
                                themeMode(context, ColorCode.modeColor.name))),
                  ),
                ],
              ),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 10.0),
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 500)
                      .width,
                  child: Text(
                    'I. ${L(context, LanguageCodes.customerBenefitsTextInfo.toString())}',
                    style: CustomFonts.h4(context),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(20.0),
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 500)
                      .width,
                  child: Text(
                    '1. ${L(context, LanguageCodes.oneLawsUpgradeAccountTextInfo.toString())}',
                    style: CustomFonts.h5(context),
                    textAlign: TextAlign.left,
                    overflow: TextOverflow.ellipsis,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
