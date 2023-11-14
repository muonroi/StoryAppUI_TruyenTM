import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:muonroi/shared/settings/settings.main.dart';

class BannerHomePage extends StatefulWidget {
  final List<String> bannerListImage;
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
          height: MainSetting.getPercentageOfDevice(context, expectHeight: 200)
              .height,
          child: PageView.builder(
            controller: widget.bannerController,
            itemCount: 3,
            itemBuilder: (BuildContext context, int index) {
              return netWorkImage(context, widget.bannerListImage[index], true,
                  isBanner: true);
            },
          )),
    );
  }
}
