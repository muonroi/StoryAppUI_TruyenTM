import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/homes/bloc/banner/banner_bloc.dart';
import 'package:muonroi/features/homes/settings/enum/enum.setting.type.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

class BannerHomePage extends StatefulWidget {
  final int numberOfBanner;
  final PageController bannerController;
  const BannerHomePage(
      {super.key,
      required this.numberOfBanner,
      required this.bannerController});

  @override
  State<BannerHomePage> createState() => _BannerHomePageState();
}

class _BannerHomePageState extends State<BannerHomePage> {
  @override
  void initState() {
    _bannerBloc = BannerBloc(EnumSettingType.banner);
    _bannerBloc.add(const GetBannerList());
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
      if (widget.bannerController.hasClients) {
        widget.bannerController.animateToPage(
          _currentPage,
          duration: const Duration(milliseconds: 500),
          curve: Curves.ease,
        );
      }
    });
  }

  late BannerBloc _bannerBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _bannerBloc,
      child: BlocListener<BannerBloc, BannerState>(
        listener: (context, state) {},
        child: BlocBuilder<BannerBloc, BannerState>(
          builder: (context, state) {
            if (state is BannerLoadingState) {
              return buildLoadingListView(
                  context,
                  null,
                  MainSetting.getPercentageOfDevice(context, expectHeight: 200)
                      .height,
                  MainSetting.getPercentageOfDevice(context, expectWidth: 100)
                      .width!);
            }
            if (state is BannerLoadedState) {
              var bannerList = state.banners.result.bannerUrl;
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: SizedBox(
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 200)
                        .height,
                    child: PageView.builder(
                      controller: widget.bannerController,
                      itemCount: bannerList.length,
                      itemBuilder: (BuildContext context, int index) {
                        return netWorkImage(context, bannerList[index], true,
                            isBanner: true);
                      },
                    )),
              );
            }
            return buildLoadingListView(
                context,
                null,
                MainSetting.getPercentageOfDevice(context, expectHeight: 200)
                    .height,
                MainSetting.getPercentageOfDevice(context, expectWidth: 100)
                    .width!);
          },
        ),
      ),
    );
  }
}
