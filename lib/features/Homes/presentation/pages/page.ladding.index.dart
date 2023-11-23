import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/homes/bloc/banner/banner_bloc.dart';
import 'package:muonroi/features/homes/presentation/pages/page.controller.main.dart';
import 'package:muonroi/features/homes/settings/enum/enum.setting.type.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/features/story/bloc/user/stories_for_user_bloc.dart';
import 'package:muonroi/features/story/settings/enums/enum.story.user.dart';
import 'package:shared_preferences/shared_preferences.dart';

class IndexPage extends StatefulWidget {
  final AccountResult accountResult;
  const IndexPage({super.key, required this.accountResult});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  @override
  void initState() {
    _storiesForUserBloc = StoriesForUserBloc(
        pageIndex: 1, pageSize: 20, storyForUserType: StoryForUserType.recent);
    _bannerBloc = BannerBloc(EnumSettingType.banner);
    _bannerBloc.add(const GetBannerList());
    _storiesForUserBloc.add(const StoriesForUserList(true, isPrevious: false));
    _initSharedPreferences();
    super.initState();
  }

  @override
  void dispose() {
    _bannerBloc.close();
    super.dispose();
  }

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  late SharedPreferences _sharedPreferences;
  late BannerBloc _bannerBloc;
  late StoriesForUserBloc _storiesForUserBloc;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: BlocProvider(
      create: (context) => _bannerBloc,
      child: BlocListener<BannerBloc, BannerState>(
        listener: (context, state) {
          homeLoading();
        },
        child: BlocBuilder<BannerBloc, BannerState>(
          builder: (context, state) {
            if (state is BannerLoadingState) {
              return homeLoading();
            }
            if (state is BannerLoadedState) {
              var bannerUrl = state.banners.result.bannerUrl;
              return _homePage(context, widget.accountResult, bannerUrl,
                  _storiesForUserBloc, _sharedPreferences);
            }
            return homeLoading();
          },
        ),
      ),
    ));
  }
}

Widget _homePage(
    BuildContext context,
    AccountResult accountResult,
    List<String> bannerUrl,
    StoriesForUserBloc storiesForUserBloc,
    SharedPreferences sharedPreferences) {
  return BlocProvider(
    create: (context) => storiesForUserBloc,
    child: BlocListener<StoriesForUserBloc, StoriesForUserState>(
      listener: (context, state) {
        homeLoading();
      },
      child: BlocBuilder<StoriesForUserBloc, StoriesForUserState>(
        builder: (context, state) {
          if (state is StoriesForUserLoadingState) {
            return homeLoading();
          }
          if (state is StoriesForUserLoadedState) {
            var storiesItem = state.stories.result.items;
            for (int index = 0; index < storiesItem.length; index++) {
              if (sharedPreferences.getInt(
                      "story-${storiesItem[index].id}-current-chapter-id") ==
                  null) {
                sharedPreferences.setInt(
                    "story-${storiesItem[index].id}-current-chapter-id",
                    storiesItem[index].chapterLatestId);
              }
              if (sharedPreferences.getInt(
                      "story-${storiesItem[index].id}-current-page-index") ==
                  null) {
                sharedPreferences.setInt(
                    "story-${storiesItem[index].id}-current-page-index",
                    storiesItem[index].pageCurrentIndex == 0
                        ? 1
                        : storiesItem[index].pageCurrentIndex);
              }
              if (sharedPreferences.getInt(
                      "story-${storiesItem[index].id}-current-chapter-index") ==
                  null) {
                sharedPreferences.setInt(
                    "story-${storiesItem[index].id}-current-chapter-index",
                    storiesItem[index].currentIndex);
              }
              if (sharedPreferences.getInt(
                      "story-${storiesItem[index].id}-current-chapter") ==
                  null) {
                sharedPreferences.setInt(
                    "story-${storiesItem[index].id}-current-chapter",
                    storiesItem[index].numberOfChapter);
              }

              if (sharedPreferences
                      .getDouble("scrollPosition-${storiesItem[index].id}") ==
                  null) {
                sharedPreferences.setDouble(
                    "scrollPosition-${storiesItem[index].id}",
                    storiesItem[index].chapterLatestLocation);
              }
            }

            return HomePage(
              accountResult: accountResult,
              bannerUrl: bannerUrl,
            );
          }
          return homeLoading();
        },
      ),
    ),
  );
}
