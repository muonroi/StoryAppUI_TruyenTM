import 'package:flutter/material.dart';
import 'package:taxi/Pages/LaddingPages/pages.ladding_page.preview.dart';

import '../../Settings/settings.images.dart';

class IndexPage extends StatelessWidget {
  const IndexPage({super.key});

  @override
  Widget build(BuildContext context) {
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const PreviewPage()));
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
