import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/core/authorization/enums/key.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signup.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/features/accounts/presentation/widgets/widget.alert.notification.confirm.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.account.info.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.platform.dart';
import 'package:muonroi/features/homes/presentation/pages/page.ladding.index.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/shared/static/textField/widget.static.textfield.text_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

enum Gender { male, female }

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  late List<Widget> _pageViewsSignUp;
  late PageController _pageController;
  late int _currentPage;
  late bool _isPageViewReady;
  late bool _isEnableButton;
  late TextEditingController _usernameController;
  late TextEditingController _passwordController;
  late TextEditingController _emailController;
  late Gender gender;
  @override
  void initState() {
    _passwordController = TextEditingController();
    _usernameController = TextEditingController();
    _emailController = TextEditingController();
    _pageViewsSignUp = [];
    _currentPage = 0;
    _isPageViewReady = false;
    _isEnableButton = false;

    _pageController = PageController(initialPage: _currentPage);
    super.initState();
    _pageViewsSignUp = [
      InputBasicInfoSignUp(
        callback: updateCountUnlock,
        usernameController: _usernameController,
        passwordController: _passwordController,
        emailController: _emailController,
      ),
      InputMoreInfoSignUp(
        callback: getGender,
      ),
    ];
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isPageViewReady = true;
      });
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void updateCountUnlock(value) {
    setState(() {
      _isEnableButton = value;
    });
  }

  void getGender(value) {
    setState(() {
      gender = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget floatingActionButton;
    if (_isPageViewReady &&
        _pageController.hasClients &&
        _currentPage == _pageViewsSignUp.length - 1) {
      floatingActionButton = FloatingActionButton(
          backgroundColor: themeMode(context, ColorCode.mainColor.name),
          onPressed: () async {
            final accountRepository = AccountRepository();
            var address = "Viet Nam";
            final sharedPreferences = await SharedPreferences.getInstance();
            var request = AccountSignUpDTO(
                avatar: "",
                name: "${Random().nextInt(100000) + 0}",
                surname: "user",
                username: _usernameController.text,
                phoneNumber: "",
                email: _emailController.text,
                address: address,
                gender: gender.index,
                uid: "",
                isSignInThirdParty: false,
                platform: EnumPlatform.system.index,
                passwordHash: _passwordController.text);
            var accountInfo = await accountRepository.register(request);
            if (accountInfo.result != null) {
              sharedPreferences.setString(
                  AccountInfo.username.name, _usernameController.text);
              sharedPreferences.setString(
                  AccountInfo.password.name, _passwordController.text);
              sharedPreferences.setBool(AccountInfo.remember.name, true);
              sharedPreferences.setString(
                  KeyToken.accessToken.name, accountInfo.result!.jwtToken);
              sharedPreferences.setString(
                  KeyToken.refreshToken.name, accountInfo.result!.refreshToken);
              sharedPreferences.setString(
                  'userLogin', accountSignInToJson(accountInfo));
              if (mounted) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => IndexPage(
                              accountResult: accountInfo.result!,
                            )));
              }
            } else {
              if (mounted) {
                showConfirmAlert(
                    context,
                    L(context,
                        LanguageCodes.serverErrorReLoginTextInfo.toString()),
                    ColorCode.closeColor.name,
                    isNextRoute: true,
                    nextRoute: const SignInPage());
              }
            }
          },
          child: const Icon(Icons.check));
    } else {
      floatingActionButton = FloatingActionButton(
          backgroundColor: !_isEnableButton
              ? themeMode(context, ColorCode.disableColor.name)
              : themeMode(context, ColorCode.mainColor.name),
          onPressed: !_isEnableButton
              ? null
              : () {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 300),
                    curve: Curves.ease,
                  );
                },
          child: const Icon(Icons.arrow_forward));
    }
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: PageView.builder(
        controller: _pageController,
        onPageChanged: (value) {
          setState(() {
            _currentPage = value;
          });
        },
        physics: const NeverScrollableScrollPhysics(),
        scrollDirection: Axis.horizontal,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(32.0),
            child: _pageViewsSignUp[index],
          );
        },
        itemCount: _pageViewsSignUp.length,
      ),
      floatingActionButton: floatingActionButton,
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: RichText(
          text: TextSpan(
              text: L(context, LanguageCodes.haveAccountTextInfo.toString()),
              style: CustomFonts.h5(context),
              children: [
                TextSpan(
                    text:
                        ' ${L(context, LanguageCodes.signinConfigTextInfo.toString())}',
                    style: CustomFonts.h5(context).copyWith(
                        fontWeight: FontWeight.w900,
                        color: themeMode(context, ColorCode.mainColor.name)),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const SignInPage()));
                      })
              ]),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}

class InputMoreInfoSignUp extends StatefulWidget {
  final Function(Gender value) callback;
  const InputMoreInfoSignUp({Key? key, required this.callback})
      : super(key: key);
  @override
  State<InputMoreInfoSignUp> createState() => _InputMoreInfoSignUpState();
}

class _InputMoreInfoSignUpState extends State<InputMoreInfoSignUp> {
  Gender? _character = Gender.male;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Center(
            child: SizedBox(
              child: Text(
                L(context, LanguageCodes.chosseGenderTextInfo.toString()),
                style: CustomFonts.h3(context)
                    .copyWith(fontWeight: FontWeight.w300),
                textAlign: TextAlign.center,
              ),
            ),
          ),
        ),
        Expanded(
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: <Widget>[
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _character = Gender.male;
                      widget.callback(_character!);
                    });
                  },
                  child: Container(
                    color: _character == Gender.male
                        ? themeMode(context, ColorCode.mainColor.name)
                        : null,
                    child: ListTile(
                      title: Text(
                          L(context, LanguageCodes.maleTextInfo.toString())),
                      leading: const Icon(Icons.male),
                    ),
                  ),
                ),
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      _character = Gender.female;
                      widget.callback(_character!);
                    });
                  },
                  child: Container(
                    color: _character == Gender.female ? Colors.blue : null,
                    child: ListTile(
                      title: Text(
                          L(context, LanguageCodes.femaleTextInfo.toString())),
                      leading: const Icon(Icons.female),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class InputBasicInfoSignUp extends StatefulWidget {
  final TextEditingController usernameController;
  final TextEditingController passwordController;
  final TextEditingController emailController;
  final void Function(bool) callback;
  const InputBasicInfoSignUp({
    Key? key,
    required this.usernameController,
    required this.passwordController,
    required this.emailController,
    required this.callback,
  }) : super(key: key);

  @override
  State<InputBasicInfoSignUp> createState() => _InputBasicInfoSignUpState();
}

class _InputBasicInfoSignUpState extends State<InputBasicInfoSignUp> {
  @override
  void initState() {
    _emailValidationError = "";
    _passwordValidationError = "";
    _usernameValidationError = "";
    _isVisibility = true;

    super.initState();
  }

  String _updatePasswordValidation() {
    setState(() {
      _passwordValidationError =
          validatePassword(widget.passwordController.text)
              ? ""
              : L(context, LanguageCodes.requiredPasswordTextInfo.toString());
    });
    return _passwordValidationError;
  }

  void _updateUsernameValidation() {
    setState(() {
      _usernameValidationError = validateUsername(
              widget.usernameController.text)
          ? ""
          : L(context, LanguageCodes.usernameSignUpErrorTextInfo.toString());
    });
  }

  void _updateEmailValidation() {
    setState(() {
      _emailValidationError = validateEmail(widget.emailController.text)
          ? ""
          : L(context, LanguageCodes.emailSignUpErrorTextInfo.toString());
    });
  }

  bool validatePassword(String password) {
    RegExp regex = RegExp(
        r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[#?!@$%^&*-]).{8,}$');

    return regex.hasMatch(password);
  }

  bool validateUsername(String username) {
    RegExp regex = RegExp(
        r'^[a-zA-Z][a-zA-Z0-9_\.]{3,99}[a-z0-9](\@([a-zA-Z0-9][a-zA-Z0-9\.]+[a-zA-Z0-9]{2,}){1,5})?$');
    return regex.hasMatch(username);
  }

  bool validateEmail(String email) {
    RegExp regex = RegExp(
        r'^(([^<>()[\]\\.,;:\s@\""]+(\.[^<>()[\]\\.,;:\s@\""]+)*)|(\"".+\""))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
    return regex.hasMatch(email);
  }

  late String _passwordValidationError;
  late String _usernameValidationError;
  late String _emailValidationError;
  late bool _isVisibility;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        RoundedInputField(
          textController: widget.usernameController,
          errorMessage: _usernameValidationError,
          isShowIcon: false,
          readonly: false,
          hintText:
              L(context, LanguageCodes.myAccountDetailTextInfo.toString()),
          icon: Icons.person,
          onChange: (value) {
            setState(() {
              _updateUsernameValidation();
            });
          },
          isPassword: false,
        ),
        RoundedInputField(
          textController: widget.emailController,
          isShowIcon: false,
          readonly: false,
          hintText: L(context, LanguageCodes.emailSignUpTextInfo.toString()),
          icon: Icons.email,
          onChange: (value) {
            setState(() {
              _updateEmailValidation();
            });
          },
          errorMessage: _emailValidationError,
          isPassword: false,
        ),
        RoundedInputField(
          textController: widget.passwordController,
          iconAction: () {
            setState(() {
              _isVisibility = !_isVisibility;
            });
          },
          isVisibility: _isVisibility,
          isShowIcon: true,
          readonly: false,
          hintText: L(context,
              LanguageCodes.inputPasswordTextConfigTextInfo.toString()),
          icon: Icons.lock,
          onChange: (value) {
            setState(() {
              var result = _updatePasswordValidation();
              widget.callback((result == "" &&
                      _emailValidationError == "" &&
                      _usernameValidationError == "")
                  ? true
                  : false);
            });
          },
          errorMessage: _passwordValidationError,
          isPassword: _isVisibility,
        ),
      ],
    );
  }
}
