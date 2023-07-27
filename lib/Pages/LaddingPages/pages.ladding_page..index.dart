import 'package:flutter/material.dart';
import '../../Settings/settings.images.dart';
import '../Accounts/Logins/pages.logins.sign_in.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const SignInPage()));
    });
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 32),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(flex: 2, child: Image.asset(ImageDefault.mainLogo2x)),
            Expanded(flex: 1, child: Image.asset(ImageDefault.laddingLogo2x)),
          ],
        ),
      ),
    );
  }
}
