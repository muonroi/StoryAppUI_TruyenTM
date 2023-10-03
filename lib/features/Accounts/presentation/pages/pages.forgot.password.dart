import 'package:flutter/material.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
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
                        color: themMode(context, ColorCode.mainColor.name),
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
                            themMode(context, ColorCode.modeColor.name),
                      ),
                      text:
                          L(context, LanguageCodes.backInfoTextInfo.toString()),
                      textStyle: CustomFonts.h5(context).copyWith(
                        color: themMode(context, ColorCode.textColor.name),
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
                            AccountRepository(_usernameController.text, "");
                        var result = await accountRepository.forgotPassword();
                        if (result == true) {
                          if (mounted) {
                            showDialog(
                                context: context,
                                builder: (builder) {
                                  return AlertDialog(
                                    title: Text(
                                      L(
                                          context,
                                          LanguageCodes.notificationTextInfo
                                              .toString()),
                                      style: CustomFonts.h3(context),
                                    ),
                                    content: Text(
                                      L(
                                          context,
                                          LanguageCodes
                                              .sendPasswordSuccessTextInfo
                                              .toString()),
                                      style: CustomFonts.h5(context),
                                    ),
                                    actions: <Widget>[
                                      TextButton(
                                        style: TextButton.styleFrom(
                                          textStyle: Theme.of(context)
                                              .textTheme
                                              .labelLarge,
                                        ),
                                        child: Container(
                                          padding: const EdgeInsets.all(8.0),
                                          decoration: BoxDecoration(
                                              color: themMode(context,
                                                  ColorCode.mainColor.name),
                                              borderRadius:
                                                  BorderRadius.circular(30.0)),
                                          child: Text(
                                              L(
                                                  context,
                                                  LanguageCodes.ignoreTextInfo
                                                      .toString()),
                                              style: CustomFonts.h5(context)
                                                  .copyWith(
                                                      color: themMode(
                                                          context,
                                                          ColorCode.modeColor
                                                              .name))),
                                        ),
                                        onPressed: () {
                                          Navigator.of(context).pop();
                                        },
                                      )
                                    ],
                                  );
                                });
                          }
                        }
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor:
                            themMode(context, ColorCode.mainColor.name),
                      ),
                      text: L(context, LanguageCodes.submitTextInfo.toString()),
                      textStyle: CustomFonts.h5(context).copyWith(
                          color: themMode(context, ColorCode.modeColor.name)),
                    ),
                  ),
                ],
              )
            ],
          )),
    );
  }
}
