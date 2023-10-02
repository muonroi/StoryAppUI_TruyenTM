import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
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
      backgroundColor: themMode(context, ColorCode.modeColor.name),
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          onPressed: () => Navigator.pop(context),
          color: themMode(context, ColorCode.modeColor.name),
        ),
        backgroundColor: themMode(context, ColorCode.mainColor.name),
        elevation: 0,
        title: Text(L(context, ViCode.upgradeAccountTextInfo.toString())),
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
                      color: themMode(context, ColorCode.mainColor.name)),
                  color: themMode(context, ColorCode.disableColor.name),
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
                      ImageDefault.crown2x,
                      fit: BoxFit.cover,
                      color: themMode(context, ColorCode.mainColor.name),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      L(context, ViCode.upgradeAccountTextInfo.toString()),
                      style: FontsDefault.h4(context).copyWith(
                          color: themMode(context, ColorCode.mainColor.name)),
                    ),
                  ),
                  SizedBox(
                    child: Text(
                      '45.000đ/${L(context, ViCode.monthTextInfo.toString())}',
                      style: FontsDefault.h4(context),
                    ),
                  ),
                  SizedBox(
                    child: ButtonWidget.buttonNavigatorNextPreviewLanding(
                        context, SignInPage(),
                        textDisplay:
                            L(context, ViCode.buyNowTextInfo.toString()),
                        textStyle: FontsDefault.h5(context).copyWith(
                            color:
                                themMode(context, ColorCode.modeColor.name))),
                  ),
                ],
              ),
            ),
            Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 10.0),
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 500)
                        .width,
                    child: Text(
                      'I. ${L(context, ViCode.customerBenefitsTextInfo.toString())}',
                      style: FontsDefault.h4(context),
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
                      '1. ${L(context, ViCode.oneLawsUpgradeAccountTextInfo.toString())}',
                      style: FontsDefault.h5(context),
                      textAlign: TextAlign.left,
                      overflow: TextOverflow.ellipsis,
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
