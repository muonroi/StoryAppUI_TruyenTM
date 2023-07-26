import 'package:flutter/material.dart';
import 'package:taxi/Settings/settings.fonts.dart';
import '../../Settings/settings.images.dart';
import '../../Widget/Button/widget.button.dart';
import '../Accounts/Logins/pages.logins.sign_in.dart';

class AcceptLocationPage extends StatelessWidget {
  const AcceptLocationPage({super.key});

  @override
  Widget build(BuildContext context) {
    Size screenCurrentSize = MediaQuery.of(context).size;
    return Scaffold(
        body: Padding(
          padding:
              EdgeInsets.symmetric(horizontal: screenCurrentSize.width * 0.2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(ImageDefault.listviewFinish2x),
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: screenCurrentSize.height * 0.06),
                child: Text(
                  "Don't worry your data is private",
                  style: FontsDefault.h5,
                ),
              ),
            ],
          ),
        ),
        bottomNavigationBar: Padding(
          padding: EdgeInsets.symmetric(
              horizontal: screenCurrentSize.width * 1 / 5,
              vertical: screenCurrentSize.height * 1 / 50),
          child: ButtonWidget.buttonNavigatorNextPreviewLanding(
              context, const SignInPage(),
              textDisplay: 'Allow Location'),
        ));
  }
}
