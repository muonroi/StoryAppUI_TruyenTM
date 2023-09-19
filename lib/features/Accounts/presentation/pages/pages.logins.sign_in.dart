import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/homes/presentation/pages/pages.ladding.index.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.images.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_up.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  late String username;
  late String password;
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  late bool isShowLabelError = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            SizedBox(
              height:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 100)
                      .height,
              child: Image.asset(
                ImageDefault.mainLogo,
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 220)
                        .width,
                height:
                    MainSetting.getPercentageOfDevice(context, expectHeight: 60)
                        .height,
              ),
            ),
            isShowLabelError
                ? Container(
                    margin: const EdgeInsets.only(top: 30),
                    child: Text(
                      L(ViCode.inValidAccountTextConfigTextInfo.toString()),
                      style: FontsDefault.h5
                          .copyWith(fontSize: 13, color: Colors.red),
                    ),
                  )
                : Container(),
            SizedBox(
              height:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 100)
                      .height,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  controller: usernameController,
                  decoration: InputDecoration(
                      icon: Icon(
                        Icons.person,
                        color: ColorDefaults.buttonColor,
                      ),
                      border: UnderlineInputBorder(),
                      labelText:
                          L(ViCode.inputUsernameTextConfigTextInfo.toString())),
                ),
              ),
            ),
            SizedBox(
              height:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 100)
                      .height,
              child: Align(
                alignment: Alignment.bottomLeft,
                child: TextFormField(
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    icon: Icon(
                      Icons.lock,
                      color: ColorDefaults.buttonColor,
                    ),
                    border: UnderlineInputBorder(),
                    labelText:
                        L(ViCode.inputPasswordTextConfigTextInfo.toString()),
                    suffixIcon: const Icon(
                      Icons.visibility,
                      color: ColorDefaults.buttonColor,
                    ),
                  ),
                ),
              ),
            ),
          ]),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: RichText(
            text: TextSpan(
                text: L(ViCode.noHaveAccountTextConfigTextInfo.toString()),
                style: FontsDefault.h5,
                children: [
                  TextSpan(
                      text: " ${L(ViCode.signupConfigTextInfo.toString())}",
                      style: FontsDefault.h5.copyWith(
                          fontWeight: FontWeight.w900,
                          color: ColorDefaults.mainColor),
                      recognizer: TapGestureRecognizer()
                        ..onTap = () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const SignUpPage()));
                        })
                ]),
            textAlign: TextAlign.center,
          ),
        ),
        floatingActionButton: FloatingActionButton(
            backgroundColor: ColorDefaults.mainColor,
            onPressed: () async {
              var sharedPreferences = await SharedPreferences.getInstance();
              AccountRepository account = AccountRepository(
                  usernameController.text, passwordController.text);
              var accountInfo = await account.signIn();
              if (accountInfo.statusCode == 400) {
                setState(() {
                  isShowLabelError = true;
                });
              } else {
                sharedPreferences.setString(
                    KeyToken.accessToken.name, accountInfo.result!.jwtToken);
                sharedPreferences.setString(KeyToken.refreshToken.name,
                    accountInfo.result!.refreshToken);
                isShowLabelError = false;
                Navigator.pushReplacement(context,
                    MaterialPageRoute(builder: (context) => IndexPage()));
              }
            },
            child: const Icon(Icons.login)));
  }
}
