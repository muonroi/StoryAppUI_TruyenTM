import 'dart:math';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signup.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.forgot.password.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_up.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.account.info.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.platform.dart';
import 'package:muonroi/features/homes/presentation/pages/page.ladding.index.dart';
import 'package:muonroi/features/user/data/repository/user.repository.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.images.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/shared/static/items/widget.divider.dart';
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
    _accountRepository = AccountRepository();
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
  late AccountRepository _accountRepository;
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
                        expectHeight: 200)
                    .height,
                child: Image.asset(
                  CustomImages.mainLogo,
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 220)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 120)
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
        floatingActionButton: FloatingActionButton(
            backgroundColor: themeMode(context, ColorCode.mainColor.name),
            onPressed: () async {
              _sharedPreferences.setString(
                  "MethodLogin", EnumPlatform.system.name);
              setState(() {
                _isLoading = true;
              });
              var accountInfo = await _accountRepository.signIn(
                  _usernameController.text, _passwordController.text, null);
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
        bottomNavigationBar: !_isLoading
            ? SizedBox(
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 200)
                    .height,
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 15.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          SizedBox(
                            width: MainSetting.getPercentageOfDevice(context,
                                    expectWidth: 110)
                                .width,
                            child: const CustomDivider(
                              padding: EdgeInsets.only(left: 12.0),
                            ),
                          ),
                          SizedBox(
                            width: MainSetting.getPercentageOfDevice(context,
                                    expectWidth: 120)
                                .width,
                            child: Text(
                              L(
                                  context,
                                  LanguageCodes.continueWithGoogleTextInfo
                                      .toString()),
                              style: CustomFonts.h6(context).copyWith(
                                  fontSize: 14, fontWeight: FontWeight.w500),
                            ),
                          ),
                          SizedBox(
                            width: MainSetting.getPercentageOfDevice(context,
                                    expectWidth: 110)
                                .width,
                            child: const CustomDivider(
                              padding: EdgeInsets.only(right: 12.0),
                            ),
                          ),
                        ],
                      ),
                    ),
                    LoginWithSocialMedia(
                      ontap: () async {
                        _sharedPreferences.setString(
                            "MethodLogin", EnumPlatform.google.name);
                        var address = "Viet Nam";
                        var userInfo = await _accountRepository.authGoogle();
                        try {
                          if (userInfo != null) {
                            setState(() {
                              _isLoading = true;
                            });
                            final userRepository = UserRepository();
                            var isExistUser = await userRepository
                                .fetchUserInfoData(userInfo.email!);
                            if (isExistUser.result == null) {
                              var request = AccountSignUpDTO(
                                  name: "${Random().nextInt(100000) + 0}",
                                  surname: "user",
                                  username:
                                      userInfo.email ?? "anonymous@gmail.com",
                                  phoneNumber: "",
                                  email:
                                      userInfo.email ?? "anonymous@gmail.com",
                                  address: address,
                                  gender: 0,
                                  uid: userInfo.uid,
                                  isSignInThirdParty: true,
                                  platform: EnumPlatform.google.index,
                                  passwordHash: "${userInfo.uid}12345678Az*");
                              var accountInfo =
                                  await _accountRepository.register(request);
                              if (accountInfo.result == null) {
                                setState(() {
                                  _isShowLabelError = true;
                                  _isLoading = false;
                                });
                              } else {
                                _sharedPreferences.setString(
                                    AccountInfo.username.name,
                                    _usernameController.text);
                                _sharedPreferences.setString(
                                    AccountInfo.password.name,
                                    _passwordController.text);
                                _sharedPreferences.setBool(
                                    AccountInfo.remember.name, _rememberMe);
                                _sharedPreferences.setString(
                                    KeyToken.accessToken.name,
                                    accountInfo.result!.jwtToken);
                                _sharedPreferences.setString(
                                    KeyToken.refreshToken.name,
                                    accountInfo.result!.refreshToken);
                                _isShowLabelError = false;
                                _sharedPreferences.setString('userLogin',
                                    accountSignInToJson(accountInfo));
                                if (mounted) {
                                  _isLoading = false;
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => IndexPage(
                                                accountResult:
                                                    accountInfo.result!,
                                              )));
                                }
                              }
                            } else {
                              setState(() {
                                _isLoading = true;
                              });
                              var accountInfo = await _accountRepository.signIn(
                                  userInfo.email!,
                                  "${userInfo.uid}12345678Az*",
                                  userInfo.uid);
                              if (accountInfo.result == null) {
                                setState(() {
                                  _isShowLabelError = true;
                                  _isLoading = false;
                                });
                              } else {
                                _sharedPreferences.setString(
                                    AccountInfo.username.name,
                                    _usernameController.text);
                                _sharedPreferences.setString(
                                    AccountInfo.password.name,
                                    _passwordController.text);
                                _sharedPreferences.setBool(
                                    AccountInfo.remember.name, _rememberMe);
                                _sharedPreferences.setString(
                                    KeyToken.accessToken.name,
                                    accountInfo.result!.jwtToken);
                                _sharedPreferences.setString(
                                    KeyToken.refreshToken.name,
                                    accountInfo.result!.refreshToken);
                                _isShowLabelError = false;
                                _sharedPreferences.setString('userLogin',
                                    accountSignInToJson(accountInfo));
                                if (mounted) {
                                  _isLoading = false;
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => IndexPage(
                                                accountResult:
                                                    accountInfo.result!,
                                              )));
                                }
                              }
                            }
                          }
                        } catch (e) {
                          setState(() {
                            _isShowLabelError = true;
                            _isLoading = false;
                          });
                        }
                      },
                      image: CustomImages.google2x,
                      width: MainSetting.getPercentageOfDevice(context,
                              expectWidth: 70)
                          .width!,
                      height: MainSetting.getPercentageOfDevice(context,
                              expectHeight: 70)
                          .height!,
                      borderRadius: 20.0,
                      padding: 12.0,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 32.0),
                      child: RichText(
                        text: TextSpan(
                            text: L(
                                context,
                                LanguageCodes.noHaveAccountTextConfigTextInfo
                                    .toString()),
                            style: CustomFonts.h5(context).copyWith(
                                color: themeMode(
                                    context, ColorCode.textColor.name)),
                            children: [
                              TextSpan(
                                  text:
                                      " ${L(context, LanguageCodes.signupConfigTextInfo.toString())}",
                                  style: CustomFonts.h5(context).copyWith(
                                    fontWeight: FontWeight.w900,
                                    color: themeMode(
                                        context, ColorCode.mainColor.name),
                                  ),
                                  recognizer: TapGestureRecognizer()
                                    ..onTap = () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  const SignUpPage()));
                                    })
                            ]),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ],
                ),
              )
            : null);
  }
}

class LoginWithSocialMedia extends StatelessWidget {
  final String image;
  final double width;
  final double height;
  final double borderRadius;
  final double padding;
  final void Function() ontap;
  const LoginWithSocialMedia(
      {super.key,
      required this.image,
      required this.width,
      required this.height,
      required this.borderRadius,
      required this.padding,
      required this.ontap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: ontap,
      child: Container(
        padding: EdgeInsets.all(padding),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            color: themeMode(context, ColorCode.disableColor.name)),
        width: MainSetting.getPercentageOfDevice(context, expectWidth: width)
            .width,
        height: MainSetting.getPercentageOfDevice(context, expectHeight: height)
            .height,
        child: ClipRRect(
            borderRadius: BorderRadius.circular(borderRadius),
            child: Image.asset(image)),
      ),
    );
  }
}
