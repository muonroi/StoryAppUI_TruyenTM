import 'dart:math';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/core/authorization/enums/key.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signup.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.ladding.page.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/features/accounts/presentation/widgets/widget.alert.notification.confirm.dart';
import 'package:muonroi/features/accounts/presentation/widgets/widget.input.gender.signup.dart';
import 'package:muonroi/features/accounts/presentation/widgets/widget.input.info.signup.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.account.info.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.gender.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.platform.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

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
              userBox.put(AccountInfo.username.name, _usernameController.text);
              userBox.put(AccountInfo.password.name, _passwordController.text);
              userBox.put(AccountInfo.remember.name, true);
              userBox.put(
                  KeyToken.accessToken.name, accountInfo.result!.jwtToken);
              userBox.put(
                  KeyToken.refreshToken.name, accountInfo.result!.refreshToken);
              userBox.put('userLogin', accountSignInToJson(accountInfo));
              if (mounted) {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LaddingPage()));
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
