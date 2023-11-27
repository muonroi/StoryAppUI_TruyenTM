import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/core/authorization/enums/key.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:muonroi/features/accounts/presentation/pages/pages.logins.sign_in.dart';
import 'package:muonroi/features/accounts/settings/enum/enum.platform.dart';
import 'package:muonroi/features/homes/presentation/pages/page.book.case.dart';
import 'package:muonroi/features/homes/presentation/pages/page.ladding.index.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/shared/settings/setting.images.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LaddingPage extends StatefulWidget {
  const LaddingPage({super.key});

  @override
  State<LaddingPage> createState() => _LaddingPageState();
}

class _LaddingPageState extends State<LaddingPage> {
  @override
  void initState() {
    _checkInternet = false;
    _isSigninView = false;
    _accountResult = null;
    initLocalStored();
    uid = null;
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  initLocalStored() async {
    _checkInternet = await checkInternetAvailable();
    await SharedPreferences.getInstance().then((value) {
      value.setBool('notification', true);
      if (context.mounted) {
        value.setBool('availableInternet', _checkInternet);
        if (!_checkInternet) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (builder) => const BookCase()));
        } else {
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            var method = value.getString("MethodLogin");
            setState(() {
              _isSigninView =
                  value.getString(KeyToken.accessToken.name) == null;
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

                value.setString(
                  KeyToken.accessToken.name,
                  accountInfo.result!.jwtToken,
                );
                value.setString(
                  KeyToken.refreshToken.name,
                  accountInfo.result!.refreshToken,
                );
                value.setString(
                  'userLogin',
                  accountSignInToJson(accountInfo),
                );

                if (mounted) {
                  setState(() {
                    _isSigninView = false;
                    _accountResult =
                        accountSignInFromJson(value.getString('userLogin')!)
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
                    _accountResult =
                        accountSignInFromJson(value.getString('userLogin')!)
                            .result!;
                    _loginOrIndex(_accountResult);
                  });
                }
              }
            }
          });
        }
      }

      return value;
    });
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
  late bool _checkInternet;
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
