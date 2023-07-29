import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/Pages/Accounts/Logins/pages.loggins.sign_up.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.images.dart';

import '../../../Widget/Button/widget.button.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  @override
  Widget build(BuildContext context) {
    Size totalSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 32),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.only(top: totalSize.height * 1 / 7),
                  child: SizedBox(
                    height: totalSize.height *
                        (((109 / totalSize.height) * 100) / 100),
                    child: Image.asset(
                      ImageDefault.mainLogo2x,
                      width: 220,
                      height: 60,
                    ),
                  ),
                ),
                SizedBox(
                  height: totalSize.height *
                      (((150 / totalSize.height) * 100) / 100),
                  child: Column(
                    children: [
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Text('Login', style: FontsDefault.h3)),
                      Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 8, vertical: 16),
                          child: Text(
                            'Login with your phone number',
                            style: FontsDefault.h5,
                          )),
                    ],
                  ),
                ),
                SizedBox(
                  height: totalSize.height *
                      (((130 / totalSize.height) * 100) / 100),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 8, vertical: 16),
                    child: Align(
                      alignment: Alignment.bottomLeft,
                      child: TextFormField(
                        decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                            labelText: 'Enter your phone number'),
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: totalSize.height *
                      (((50 / totalSize.height) * 100) / 100),
                  width: totalSize.width,
                  child: ButtonWidget.buttonNavigatorNextPreviewLanding(
                      context, const SignInPage(),
                      textDisplay: 'Send Code'),
                ),
              ]),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(vertical: 32.0),
          child: RichText(
            text: TextSpan(
                text: 'Don’t have an account?',
                style: FontsDefault.h5,
                children: [
                  TextSpan(
                      text: ' Sign Up',
                      style: FontsDefault.h5.copyWith(
                          fontWeight: FontWeight.w900,
                          color: ColorDefaults.buttonColor),
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
        ));
  }
}
