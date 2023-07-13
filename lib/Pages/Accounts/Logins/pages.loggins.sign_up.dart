import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:taxi/Pages/Accounts/Logins/pages.logins.sign_in.dart';
import '../../../Settings/settings.colors.dart';
import '../../../Settings/settings.fonts.dart';
import '../../../Settings/settings.images.dart';
import '../../../Widget/Button/button.widget.dart';
import '../../../Widget/TextField/widget.textfield.password_input.dart';
import '../../../Widget/TextField/widget.textfield.text_input.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  @override
  Widget build(BuildContext context) {
    var totalSize = MediaQuery.of(context).size;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Padding(
        padding: EdgeInsets.symmetric(vertical: totalSize.height * 0.15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Center(
              child: SizedBox(
                child: Image.asset(
                  ImageDefault.mainLogo2x,
                  width: 220,
                  height: 60,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: totalSize.height * 0.05),
              child: SizedBox(
                child: Text(
                  'Sign Up',
                  style: FontsDefault.h3.copyWith(fontWeight: FontWeight.w300),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            RoundedInputField(
              hintText: "Your full name",
              onChanged: (value) => {},
              icon: Icons.person,
            ),
            RoundedInputField(
              hintText: "Your username",
              onChanged: (value) => {},
              icon: Icons.key,
            ),
            const RoundedPasswordField(hintText: "Your password"),
            Container(
              padding: const EdgeInsets.all(0.8),
              width: totalSize.width * 0.8,
              child: ButtonWidget.buttonNavigatorNextPreviewLanding(
                  context, const SignInPage(),
                  textDisplay: 'Next'),
            )
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(vertical: 32.0),
        child: RichText(
          text: TextSpan(
              text: 'Already have an account?',
              style: FontsDefault.h5,
              children: [
                TextSpan(
                    text: ' Sign In',
                    style: FontsDefault.h5.copyWith(
                        fontWeight: FontWeight.w900,
                        color: ColorDefaults.buttonColor),
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
