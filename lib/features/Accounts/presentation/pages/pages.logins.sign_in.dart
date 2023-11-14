import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.forgot.password.dart';
import 'package:muonroi/features/accounts/settings/enum/account.info.dart';
import 'package:muonroi/features/homes/presentation/pages/pages.ladding.index.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.images.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/shared/static/textField/widget.static.textfield.text_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  void initState() {
    _usernameController = TextEditingController();
    _passwordController = TextEditingController();
    _isShowLabelError = false;
    _rememberMe = false;
    _isVisibility = true;
    _isLoading = false;
    _initSharedPreferences().then((value) {
      _usernameController.text =
          _sharedPreferences.getString(AccountInfo.username.name) ?? "";
      _passwordController.text =
          _sharedPreferences.getString(AccountInfo.password.name) ?? "";
      _rememberMe =
          _sharedPreferences.getBool(AccountInfo.remember.name) ?? false;
    });
    super.initState();
  }

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  late SharedPreferences _sharedPreferences;
  late String username;
  late String password;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late bool _isShowLabelError;
  late bool _rememberMe;
  late bool _isVisibility;
  late bool _isLoading;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        resizeToAvoidBottomInset: false,
        body: Stack(children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 32),
            child:
                Column(mainAxisAlignment: MainAxisAlignment.center, children: [
              SizedBox(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 100)
                    .height,
                child: Image.asset(
                  CustomImages.mainLogo,
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 220)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 60)
                      .height,
                ),
              ),
              _isShowLabelError
                  ? Container(
                      margin: const EdgeInsets.only(top: 30),
                      child: Text(
                        L(context,
                            LanguageCodes.invalidAccountTextInfo.toString()),
                        style: CustomFonts.h5(context)
                            .copyWith(fontSize: 13, color: Colors.red),
                      ),
                    )
                  : Container(),
              SizedBox(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 100)
                    .height,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: TextFormFieldGlobal(
                    obscureText: false,
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
              ),
              SizedBox(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 100)
                    .height,
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: TextFormFieldGlobal(
                    controller: _passwordController,
                    obscureText: _isVisibility,
                    decoration: InputDecoration(
                        icon: Icon(
                          Icons.lock,
                          color: themeMode(context, ColorCode.mainColor.name),
                        ),
                        border: const UnderlineInputBorder(),
                        labelText: L(
                            context,
                            LanguageCodes.inputPasswordTextConfigTextInfo
                                .toString()),
                        suffixIcon: IconButton(
                          onPressed: () {
                            setState(() {
                              _isVisibility = !_isVisibility;
                            });
                          },
                          icon: Icon(
                            _isVisibility
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: themeMode(context, ColorCode.mainColor.name),
                          ),
                        )),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 70)
                        .height,
                    child: Row(
                      children: [
                        Checkbox(
                          value: _rememberMe,
                          onChanged: (value) {
                            setState(() {
                              _rememberMe = value!;
                            });
                          },
                        ),
                        Text(
                          L(context, LanguageCodes.rememberTextInfo.toString()),
                          style: CustomFonts.h5(context).copyWith(fontSize: 16),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 70)
                        .height,
                    child: Row(
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ForgotPasswordPage()));
                          },
                          child: Text(
                            L(
                                context,
                                LanguageCodes.forgotPasswordTextInfo
                                    .toString()),
                            style: CustomFonts.h5(context).copyWith(
                              fontWeight: FontWeight.w900,
                              color:
                                  themeMode(context, ColorCode.mainColor.name),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ]),
          ),
          _isLoading
              ? Positioned.fill(
                  child: Material(
                  color: const Color.fromARGB(50, 85, 78, 78),
                  child: SpinKitWave(
                    color: themeMode(context, ColorCode.mainColor.name),
                  ),
                ))
              : Container()
        ]),
        floatingActionButton: Padding(
          padding: EdgeInsets.only(
              bottom:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 100)
                      .height!),
          child: FloatingActionButton(
              backgroundColor: themeMode(context, ColorCode.mainColor.name),
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });
                var accountRepository = AccountRepository(
                    _usernameController.text, _passwordController.text, "");
                var accountInfo = await accountRepository.signIn();
                if (accountInfo.result == null) {
                  setState(() {
                    _isShowLabelError = true;
                    _isLoading = false;
                  });
                } else {
                  if (_rememberMe) {
                    _sharedPreferences.setString(
                        AccountInfo.username.name, _usernameController.text);
                    _sharedPreferences.setString(
                        AccountInfo.password.name, _passwordController.text);
                    _sharedPreferences.setBool(
                        AccountInfo.remember.name, _rememberMe);
                  }
                  _sharedPreferences.setString(
                      KeyToken.accessToken.name, accountInfo.result!.jwtToken);
                  _sharedPreferences.setString(KeyToken.refreshToken.name,
                      accountInfo.result!.refreshToken);
                  _isShowLabelError = false;
                  _sharedPreferences.setString(
                      'userLogin', accountSignInToJson(accountInfo));
                  if (mounted) {
                    _isLoading = false;
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => IndexPage(
                                  accountResult: accountInfo.result!,
                                )));
                  }
                }
              },
              child: Icon(
                Icons.login,
                color: themeMode(context, ColorCode.modeColor.name),
              )),
        ),
        bottomNavigationBar: !_isLoading
            ? Padding(
                padding: const EdgeInsets.symmetric(vertical: 32.0),
                child: RichText(
                  text: TextSpan(
                      text: L(
                          context,
                          LanguageCodes.noHaveAccountTextConfigTextInfo
                              .toString()),
                      style: CustomFonts.h5(context).copyWith(
                          color: themeMode(context, ColorCode.textColor.name)),
                      children: [
                        TextSpan(
                            text:
                                " ${L(context, LanguageCodes.signupConfigTextInfo.toString())}",
                            style: CustomFonts.h5(context).copyWith(
                              fontWeight: FontWeight.w900,
                              color:
                                  themeMode(context, ColorCode.mainColor.name),
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => Container()));
                              })
                      ]),
                  textAlign: TextAlign.center,
                ),
              )
            : null);
  }
}
