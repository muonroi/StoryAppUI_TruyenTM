import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';
import 'package:muonroi/features/homes/bloc/banner/banner_bloc.dart';
import 'package:muonroi/features/homes/presentation/pages/controller.main.dart';
import 'package:muonroi/features/homes/settings/enum/enum.setting.type.dart';
import 'package:muonroi/shared/settings/settings.images.dart';

class IndexPage extends StatefulWidget {
  final AccountResult accountResult;
  const IndexPage({super.key, required this.accountResult});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    _bannerBloc = BannerBloc(EnumSettingType.banner);
    _bannerBloc.add(const GetBannerList());
    super.initState();
  }

  @override
  void dispose() {
    _bannerBloc.close();
    super.dispose();
  }

  late BannerBloc _bannerBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => _bannerBloc,
      child: BlocListener<BannerBloc, BannerState>(
        listener: (context, state) {
          _homeLoading();
        },
        child: BlocBuilder<BannerBloc, BannerState>(
          builder: (context, state) {
            if (state is BannerLoadingState) {
              return _homeLoading();
            }
            if (state is BannerLoadedState) {
              var bannerUrl = state.banners.result.bannerUrl;
              return _homePage(context, widget.accountResult, bannerUrl);
            }
            return _homeLoading();
          },
        ),
      ),
    ));
  }
}

Widget _homePage(
    BuildContext context, AccountResult accountResult, List<String> bannerUrl) {
  return HomePage(
    accountResult: accountResult,
    bannerUrl: bannerUrl,
  );
}

Widget _homeLoading() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: Image.asset(CustomImages.laddingLogo))
        ],
      ),
    );
