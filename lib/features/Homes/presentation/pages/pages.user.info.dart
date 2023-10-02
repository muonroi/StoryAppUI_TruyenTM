import 'package:flutter/material.dart';
import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/features/coins/presentation/pages/upgrade.account.dart';
import 'package:muonroi/features/contacts/presentation/pages/contact.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.user.info.items.dart';
import 'package:muonroi/features/settings/presentation/pages/setting.page.dart';
import 'package:muonroi/features/user_info/presentation/pages/user.detail.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.images.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signup.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserInfo extends StatefulWidget {
  final AccountInfo userInfo;
  const UserInfo({super.key, required this.userInfo});

  @override
  State<UserInfo> createState() => _UserInfoState();
}

class _UserInfoState extends State<UserInfo> {
  @override
  void initState() {
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }
  }

  late SharedPreferences? _sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themMode(context, ColorCode.modeColor.name),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(L(context, ViCode.myAccountTextInfo.toString()),
                  style: FontsDefault.h4(context)),
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
                      L(context, ViCode.notfoundTextInfo.toString()),
                  style: FontsDefault.h5(context),
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
                                  style: FontsDefault.h5(context)),
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
                                  L(context,
                                      ViCode.myAccountCoinTextInfo.toString()),
                                  style: FontsDefault.h5(context),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '|',
                            style: FontsDefault.h4(context)
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                          Column(
                            children: [
                              Text(
                                widget.userInfo.totalStoriesBought.toString(),
                                style: FontsDefault.h5(context),
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
                                  L(context,
                                      ViCode.storiesBoughtTextInfo.toString()),
                                  style: FontsDefault.h5(context),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SettingItems(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new UpgradeAccount())),
                      text: L(
                          context, ViCode.myAccountPremiumTextInfo.toString()),
                      image: ImageDefault.crown2x,
                      colorIcon: themMode(context, ColorCode.textColor.name),
                    ),
                    // SettingItems(
                    //     onPressed: () {},
                    //     text:L(context,ViCode.myAccountGiftCodeTextInfo.toString()),
                    //     image: ImageDefault.gift2x),
                    // SettingItems(
                    //     onPressed: () {},
                    //     text:L(context,ViCode.myAccountRechargeTextInfo.toString()),
                    //     image: ImageDefault.coin2x),
                    SettingItems(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => new ContactPage())),
                      text: L(context,
                          ViCode.myAccountContactAdminTextInfo.toString()),
                      image: ImageDefault.contact2x,
                      colorIcon: themMode(context, ColorCode.textColor.name),
                    ),
                    SettingItems(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserInfoPage())),
                      text:
                          L(context, ViCode.myAccountDetailTextInfo.toString()),
                      image: ImageDefault.user2x,
                      colorIcon: themMode(context, ColorCode.textColor.name),
                    ),
                    SettingItems(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => SettingsPage())),
                      text: L(
                          context, ViCode.myAccountSettingTextInfo.toString()),
                      image: ImageDefault.gear2x,
                      colorIcon: themMode(context, ColorCode.textColor.name),
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Divider(
                        color: themMode(context, ColorCode.disableColor.name),
                        thickness: 3,
                      ),
                    ),
                    SettingItems(
                      onPressed: () async {
                        var userChoice = await _showConfirmationDialog(
                            context,
                            L(context, ViCode.youSureLogoutTextInfo.toString()),
                            null);
                        userChoice = userChoice ?? false;
                        if (userChoice && mounted) {
                          Navigator.push(context,
                              MaterialPageRoute(builder: (builder) {
                            _sharedPreferences!
                                .remove(KeyToken.accessToken.name);
                            _sharedPreferences!
                                .remove(KeyToken.refreshToken.name);
                            return const SignInPage();
                          }));
                        }
                      },
                      text: L(context, ViCode.logoutAccountTextInfo.toString()),
                      image: ImageDefault.logout2x,
                      colorIcon: themMode(context, ColorCode.textColor.name),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<bool?> _showConfirmationDialog(
      BuildContext context, String notification, String? actionName) async {
    return showDialog<bool?>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            L(context, ViCode.notificationTextInfo.toString()),
            style: FontsDefault.h5(context),
          ),
          content: Text(
            notification,
            style: FontsDefault.h5(context),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  L(context, ViCode.isNotSureTextInfo.toString()),
                  style: FontsDefault.h6(context),
                )),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                actionName ?? L(context, ViCode.isSureTextInfo.toString()),
                style: FontsDefault.h6(context),
              ),
            ),
          ],
        );
      },
    );
  }
}
