import 'package:flutter/material.dart';
import 'package:muonroi/features/Homes/presentation/widgets/widget.static.user.info.items.dart';
import 'package:muonroi/shared/Settings/settings.colors.dart';
import 'package:muonroi/shared/Settings/settings.fonts.dart';
import 'package:muonroi/shared/Settings/settings.images.dart';
import 'package:muonroi/shared/Settings/settings.language_code.vi..dart';
import 'package:muonroi/shared/Settings/settings.main.dart';
import 'package:muonroi/features/Accounts/data/models/models.account.signup.dart';
import 'package:muonroi/features/Homes/settings/settings.dart';

class UserInfo extends StatefulWidget {
  final AccountInfo userInfo;
  const UserInfo({super.key, required this.userInfo});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorDefaults.lightAppColor,
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(L(ViCode.myAccountTextInfo.toString()),
                  style: FontsDefault.h4),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 70)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 70)
                      .height,
                  child: netWorkImage(
                      widget.userInfo.imageLink ??
                          ImageDefault.imageAvatarDefault,
                      true),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.userInfo.username ??
                      L(ViCode.notfoundTextInfo.toString()),
                  style: FontsDefault.h5,
                ),
              ),
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 10.0),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Column(
                            children: [
                              Text(formatValueNumber(widget.userInfo.coin ?? 0),
                                  style: FontsDefault.h5),
                              SizedBox(
                                width: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectWidth: 120)
                                    .width,
                                height: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectHeight: 25)
                                    .height,
                                child: Text(
                                  L(ViCode.myAccountCoinTextInfo.toString()),
                                  style: FontsDefault.h5,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '|',
                            style: FontsDefault.h4
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                          Column(
                            children: [
                              Text(
                                widget.userInfo.totalStoriesBought.toString(),
                                style: FontsDefault.h5,
                              ),
                              SizedBox(
                                width: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectWidth: 120)
                                    .width,
                                height: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectHeight: 25)
                                    .height,
                                child: Text(
                                  L(ViCode.storiesBoughtTextInfo.toString()),
                                  style: FontsDefault.h5,
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SettingItems(
                        text: L(ViCode.myAccountPremiumTextInfo.toString()),
                        image: ImageDefault.crown2x),
                    SettingItems(
                        text: L(ViCode.myAccountGiftCodeTextInfo.toString()),
                        image: ImageDefault.gift2x),
                    SettingItems(
                        text: L(ViCode.myAccountRechargeTextInfo.toString()),
                        image: ImageDefault.coin2x),
                    SettingItems(
                        text:
                            L(ViCode.myAccountContactAdminTextInfo.toString()),
                        image: ImageDefault.contact2x),
                    SettingItems(
                        text: L(ViCode.myAccountDetailTextInfo.toString()),
                        image: ImageDefault.user2x),
                    SettingItems(
                        text: L(ViCode.myAccountSettingTextInfo.toString()),
                        image: ImageDefault.gear2x),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
