import 'package:flutter/material.dart';
import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/features/coins/presentation/pages/page.upgrade.account.dart';
import 'package:muonroi/features/contacts/presentation/pages/page.contact.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.user.info.items.dart';
import 'package:muonroi/features/system/presentation/pages/page.setting.dart';
import 'package:muonroi/features/user/presentation/pages/page.confirm.delete.dart';
import 'package:muonroi/features/user/presentation/pages/page.user.detail.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.images.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/accounts/data/models/model.account.info.dart';
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
    _avatar = widget.userInfo.avatar;
    super.initState();
    _initSharedPreferences();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    if (mounted) {
      setState(() {});
    }
  }

  void renewAvatar(String avatarLink) {
    setState(() {
      _avatar = avatarLink;
    });
  }

  late String _avatar;
  late SharedPreferences? _sharedPreferences;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeMode(context, ColorCode.modeColor.name),
      body: Container(
        margin: const EdgeInsets.symmetric(vertical: 10.0),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(L(context, LanguageCodes.myAccountTextInfo.toString()),
                  style: CustomFonts.h4(context)),
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 70)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 70)
                      .height,
                  child: netWorkImage(context, _avatar, true,
                      isSize: true, width: 70, height: 70),
                ),
              ),
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8.0),
                child: Text(
                  widget.userInfo.username,
                  style: CustomFonts.h5(context),
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
                                  style: CustomFonts.h5(context)),
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
                                  L(
                                      context,
                                      LanguageCodes.myAccountCoinTextInfo
                                          .toString()),
                                  style: CustomFonts.h5(context),
                                  textAlign: TextAlign.center,
                                ),
                              ),
                            ],
                          ),
                          Text(
                            '|',
                            style: CustomFonts.h4(context)
                                .copyWith(fontWeight: FontWeight.w300),
                          ),
                          Column(
                            children: [
                              Text(
                                widget.userInfo.totalStoriesBought.toString(),
                                style: CustomFonts.h5(context),
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
                                  L(
                                      context,
                                      LanguageCodes.savedStoriesTextInfo
                                          .toString()),
                                  style: CustomFonts.h5(context),
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
                              builder: (context) => const UpgradeAccount())),
                      text: L(context,
                          LanguageCodes.myAccountPremiumTextInfo.toString()),
                      image: CustomImages.crown2x,
                      colorIcon: themeMode(context, ColorCode.textColor.name),
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
                              builder: (context) => const ContactPage())),
                      text: L(
                          context,
                          LanguageCodes.myAccountContactAdminTextInfo
                              .toString()),
                      image: CustomImages.contact2x,
                      colorIcon: themeMode(context, ColorCode.textColor.name),
                    ),
                    SettingItems(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => UserInfoPage(
                                    renewAvatar: renewAvatar,
                                    userGuid: widget.userInfo.userGuid,
                                    username: widget.userInfo.username,
                                    avatar: _avatar,
                                  ))),
                      text: L(context,
                          LanguageCodes.myAccountDetailTextInfo.toString()),
                      image: CustomImages.user2x,
                      colorIcon: themeMode(context, ColorCode.textColor.name),
                    ),

                    SettingItems(
                      onPressed: () => Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const SettingsPage())),
                      text: L(context,
                          LanguageCodes.myAccountSettingTextInfo.toString()),
                      image: CustomImages.gear2x,
                      colorIcon: themeMode(context, ColorCode.textColor.name),
                    ),

                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 50.0),
                      child: Divider(
                        color: themeMode(context, ColorCode.disableColor.name),
                        thickness: 3,
                      ),
                    ),

                    SettingItems(
                      onPressed: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (builder) {
                          return ConfirmDeleteAccountWidget(
                            title: L(
                                context,
                                LanguageCodes.requestDeleteAccountTextInfo
                                    .toString()),
                          );
                        }));
                      },
                      text: L(
                          context,
                          LanguageCodes.requestDeleteAccountTextInfo
                              .toString()),
                      image: CustomImages.deleteAccount2x,
                      colorIcon: themeMode(context, ColorCode.textColor.name),
                    ),
                    SettingItems(
                      onPressed: () async {
                        var userChoice = await _showConfirmationDialog(
                            context,
                            L(context,
                                LanguageCodes.youSureLogoutTextInfo.toString()),
                            null);
                        userChoice = userChoice ?? false;
                        if (userChoice && mounted) {
                          final accountRepository = AccountRepository();
                          await accountRepository
                              .logout(widget.userInfo.userGuid);
                          if (mounted) {
                            Navigator.push(context,
                                MaterialPageRoute(builder: (builder) {
                              _sharedPreferences!
                                  .remove(KeyToken.accessToken.name);
                              _sharedPreferences!
                                  .remove(KeyToken.refreshToken.name);
                              return const SignInPage();
                            }));
                          }
                        }
                      },
                      text: L(context,
                          LanguageCodes.logoutAccountTextInfo.toString()),
                      image: CustomImages.logout2x,
                      colorIcon: themeMode(context, ColorCode.textColor.name),
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
          backgroundColor: themeMode(context, ColorCode.modeColor.name),
          title: Text(
            L(context, LanguageCodes.notificationTextInfo.toString()),
            style: CustomFonts.h5(context),
          ),
          content: Text(
            notification,
            style: CustomFonts.h5(context),
          ),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text(
                  L(context, LanguageCodes.isNotSureTextInfo.toString()),
                  style: CustomFonts.h6(context),
                )),
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(true);
              },
              child: Text(
                actionName ??
                    L(context, LanguageCodes.isSureTextInfo.toString()),
                style: CustomFonts.h6(context),
              ),
            ),
          ],
        );
      },
    );
  }
}
