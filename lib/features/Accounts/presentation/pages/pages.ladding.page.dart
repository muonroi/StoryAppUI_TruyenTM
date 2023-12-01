import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:muonroi/core/authorization/enums/key.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.platform.dart';
import 'package:muonroi/features/homes/presentation/pages/page.book.case.dart';
import 'package:muonroi/features/homes/presentation/pages/page.ladding.index.dart';
import 'package:muonroi/shared/settings/setting.images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaddingPage extends StatefulWidget {
  final InternetConnectionChecker internetConnectionChecker;
  const LaddingPage({super.key, required this.internetConnectionChecker});

  @override
  State<LaddingPage> createState() => _LaddingPageState();
}

class _LaddingPageState extends State<LaddingPage> {
  @override
  void initState() {
    _isSigninView = false;
    _accountResult = null;
    uid = null;
    _initLocalStored().then((value) => _switchScreen());
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    _listener.cancel();
  }

  Future _initLocalStored() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  Future _switchScreen() async {
    _listener = InternetConnectionChecker().onStatusChange.listen(
      (InternetConnectionStatus status) {
        switch (status) {
          case InternetConnectionStatus.connected:
            _sharedPreferences.setBool('availableInternet', true);
            WidgetsBinding.instance.addPostFrameCallback((_) async {
              var method = _sharedPreferences.getString("MethodLogin");
              setState(() {
                _isSigninView =
                    _sharedPreferences.getString(KeyToken.accessToken.name) ==
                        null;
                if (_isSigninView) {
                  _loginOrIndex(null);
                }
              });
              if (method == EnumPlatform.google.name) {
                final FirebaseAuth auth = FirebaseAuth.instance;
                var userInfo = auth.currentUser;
                if (userInfo != null) {
                  var accountRepository = AccountRepository();
                  uid = userInfo.uid;
                  var accountInfo = await accountRepository.signIn(
                    userInfo.email!,
                    "${userInfo.uid}12345678Az*",
                    uid,
                  );

                  if (accountInfo.result == null) {
                    _isSigninView = true;
                  }

                  _sharedPreferences.setString(
                    KeyToken.accessToken.name,
                    accountInfo.result!.jwtToken,
                  );
                  _sharedPreferences.setString(
                    KeyToken.refreshToken.name,
                    accountInfo.result!.refreshToken,
                  );
                  _sharedPreferences.setString(
                    'userLogin',
                    accountSignInToJson(accountInfo),
                  );

                  if (mounted) {
                    setState(() {
                      _isSigninView = false;
                      _accountResult = accountSignInFromJson(
                              _sharedPreferences.getString('userLogin')!)
                          .result!;

                      _loginOrIndex(_accountResult);
                    });
                  }
                }
              }

              if (method == EnumPlatform.system.name) {
                if (!_isSigninView) {
                  if (mounted) {
                    setState(() {
                      _accountResult = accountSignInFromJson(
                              _sharedPreferences.getString('userLogin')!)
                          .result!;
                      _loginOrIndex(_accountResult);
                    });
                  }
                }
              }
            });
            break;
          case InternetConnectionStatus.disconnected:
            _sharedPreferences.setBool('availableInternet', false);
            Navigator.pushReplacement(context,
                MaterialPageRoute(builder: (builder) => const BookCase()));
            break;
        }
      },
    );
  }

  void _loginOrIndex(value) {
    if (value == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (builder) => const SignInPage()));
    } else {
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (builder) => IndexPage(accountResult: _accountResult!)));
    }
  }

  late String? uid;
  late bool _isSigninView;
  late AccountResult? _accountResult;
  late SharedPreferences _sharedPreferences;
  late StreamSubscription<InternetConnectionStatus> _listener;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: Image.asset(CustomImages.laddingLogo))
          ],
        ),
      ),
    );
  }
}
