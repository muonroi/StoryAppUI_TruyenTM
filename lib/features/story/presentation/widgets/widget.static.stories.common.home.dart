import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/story/bloc/common/common_stories_bloc.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.common.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.model.full.stories.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoriesCommonHome extends StatefulWidget {
  final EnumStoriesCommon type;
  const StoriesCommonHome({super.key, required this.type});

  @override
  State<StoriesCommonHome> createState() => _StoriesCommonHomeState();
}

class _StoriesCommonHomeState extends State<StoriesCommonHome> {
  @override
  void initState() {
    _isPrevious = false;
    _refreshController = RefreshController();
    _scrollController = ScrollController();
    _commonStoriesBloc = CommonStoriesBloc(1, 20, widget.type);
    _commonStoriesBloc.add(GetCommonStoriesList(true, isPrevious: _isPrevious));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _commonStoriesBloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _commonStoriesBloc
              .add(const GetCommonStoriesList(false, isPrevious: true));
        });
      });
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    if (mounted) {
      if (_scrollController.offset >
          _scrollController.position.maxScrollExtent + 150) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _commonStoriesBloc
                .add(const GetCommonStoriesList(false, isPrevious: false));
          });
        });
      }
    }
    _refreshController.loadComplete();
  }

  late bool _isPrevious;
  late ScrollController _scrollController;
  late CommonStoriesBloc _commonStoriesBloc;
  late RefreshController _refreshController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeMode(context, ColorCode.modeColor.name),
      body: BlocProvider(
        create: (context) => _commonStoriesBloc,
        child: BlocListener<CommonStoriesBloc, CommonStoriesState>(
          listener: (context, state) {
            const Center(child: CircularProgressIndicator());
          },
          child: BlocBuilder<CommonStoriesBloc, CommonStoriesState>(
            builder: (context, state) {
              if (state is CommonStoriesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is CommonStoriesNoDataState) {
                return getEmptyData(context);
              }
              if (state is CommonStoriesLoadedState) {
                var storiesInfo = state.stories.result.items;
                return SmartRefresher(
                    enablePullDown: true,
                    enablePullUp: true,
                    controller: _refreshController,
                    onRefresh: _onRefresh,
                    onLoading: _onLoading,
                    footer: ClassicFooter(
                      canLoadingIcon: const Icon(Icons.arrow_downward),
                      canLoadingText: L(
                          context,
                          LanguageCodes.viewNextNotificationTextInfo
                              .toString()),
                      idleText: L(
                          context,
                          LanguageCodes.viewNextNotificationTextInfo
                              .toString()),
                    ),
                    header: ClassicHeader(
                      idleIcon: const Icon(Icons.arrow_upward),
                      refreshingText: L(
                          context,
                          LanguageCodes.viewPreviousNotificationTextInfo
                              .toString()),
                      releaseText: L(
                          context,
                          LanguageCodes.viewPreviousNotificationTextInfo
                              .toString()),
                      idleText: L(
                          context,
                          LanguageCodes.viewPreviousNotificationTextInfo
                              .toString()),
                    ),
                    child: ListView.builder(
                        controller: _scrollController,
                        physics: const BouncingScrollPhysics(),
                        itemCount: storiesInfo.length,
                        scrollDirection: Axis.vertical,
                        itemBuilder: (context, index) {
                          var storySingleInfo = storiesInfo[index];
                          return Column(
                            children: [
                              StoriesFullModelWidget(
                                isShowRank: true,
                                storiesItem: storySingleInfo,
                              )
                            ],
                          );
                        }));
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
