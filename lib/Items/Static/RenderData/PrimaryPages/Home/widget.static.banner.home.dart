import 'dart:async';

import 'package:flutter/cupertino.dart';

import '../../../../../Settings/settings.main.dart';

class BannerHomePage extends StatefulWidget {
  final List<Widget> bannerListImage;
  final int numberOfBanner;
  final PageController bannerController;
  const BannerHomePage(
      {super.key,
      required this.bannerListImage,
      required this.numberOfBanner,
      required this.bannerController});

  @override
  State<BannerHomePage> createState() => _BannerHomePageState();
}

class _BannerHomePageState extends State<BannerHomePage> {
  @override
  void initState() {
    super.initState();
    _startAutoScroll();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  final double bannerHeight = 200;
  final double bannerWidth = 411.4;
  int _currentPage = 0;
  Timer? _timer;

  void _startAutoScroll() {
    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (_currentPage < widget.numberOfBanner - 1) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      widget.bannerController.animateToPage(
        _currentPage,
        duration: const Duration(milliseconds: 500),
        curve: Curves.ease,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8.0),
      child: SizedBox(
          height: MainSetting.getPercentageOfDevice(context,
                  expectHeight: bannerHeight)
              .height,
          child: PageView(
            controller: widget.bannerController,
            children: [
              Image.asset('assets/images/2x/Banner_1.1.png'),
              Image.asset('assets/images/2x/Banner_2.png'),
              Image.asset('assets/images/2x/Banner_3.png')
            ],
          )),
    );
  }
}
