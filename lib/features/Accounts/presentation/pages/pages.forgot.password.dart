import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.valid_otp.dart';
import 'package:muonroi/features/accounts/presentation/widgets/widget.alert.notification.confirm.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/shared/static/buttons/widget.static.button.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  @override
  void initState() {
    _usernameController = TextEditingController();
    super.initState();
  }

  late TextEditingController _usernameController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                child: Container(
                  margin: const EdgeInsets.only(bottom: 30.0),
                  child: Text(
                    L(context, LanguageCodes.forgotPasswordTextInfo.toString()),
                    style: CustomFonts.h4(context),
                  ),
                ),
              ),
              SizedBox(
                child: Text(
                  L(context,
                      LanguageCodes.forgotPasswordMoreInfoTextInfo.toString()),
                  style: CustomFonts.h6(context),
                ),
              ),
              SizedBox(
                child: TextFormField(
                  controller: _usernameController,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: themeMode(context, ColorCode.mainColor.name),
                      ),
                      border: const UnderlineInputBorder(),
                      labelText: L(
                          context,
                          LanguageCodes.inputUsernameTextConfigTextInfo
                              .toString())),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 130)
                        .width,
                    child: ButtonGlobal(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            themeMode(context, ColorCode.modeColor.name),
                      ),
                      text:
                          L(context, LanguageCodes.backInfoTextInfo.toString()),
                      textStyle: CustomFonts.h5(context).copyWith(
                        color: themeMode(context, ColorCode.textColor.name),
                      ),
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(top: 12.0),
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 120)
                        .width,
                    child: ButtonGlobal(
                      onPressed: () async {
                        var accountRepository =
                            AccountRepository(_usernameController.text, "", "");
                        var result = await accountRepository.forgotPassword();
                        if (result == true) {
                          if (mounted) {
                            showConfirmAlert(
                                context,
                                L(
                                    context,
                                    LanguageCodes.sendPasswordSuccessTextInfo
                                        .toString()),
                                ColorCode.mainColor.name,
                                isNextRoute: true,
                                nextRoute: OTPScreen(
                                    username: _usernameController.text));
                          }
                        } else {
                          if (mounted) {
                            showConfirmAlert(
                                context,
                                L(
                                    context,
                                    LanguageCodes.serverErrorTextInfo
                                        .toString()),
                                ColorCode.closeColor.name);
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            themeMode(context, ColorCode.mainColor.name),
                      ),
                      text: L(context, LanguageCodes.submitTextInfo.toString()),
                      textStyle: CustomFonts.h5(context).copyWith(
                          color: themeMode(context, ColorCode.modeColor.name)),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
