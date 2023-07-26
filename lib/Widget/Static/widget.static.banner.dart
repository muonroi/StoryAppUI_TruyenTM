import 'package:flutter/cupertino.dart';
import '../../Settings/settings.main.dart';

class BannerHomePage extends StatelessWidget {
  final double bannerHeight = 200;
  final double bannerWidth = 411.4;
  const BannerHomePage({super.key});
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
          height: MainSetting.getPercentageOfDevice(context,
                  expectHeight: bannerHeight)
              .height,
          child: PageView(
            children: [Image.asset('assets/images/2x/Banner_1.1.png')],
          )),
    );
  }
}
