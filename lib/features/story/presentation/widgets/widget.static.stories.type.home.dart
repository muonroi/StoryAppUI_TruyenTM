import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/story/bloc/special/special_bloc.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.special.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.model.full.stories.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class StoriesSpecial extends StatefulWidget {
  final EnumStoriesSpecial type;
  const StoriesSpecial({super.key, required this.type});

  @override
  State<StoriesSpecial> createState() => _StoriesSpecialState();
}

class _StoriesSpecialState extends State<StoriesSpecial> {
  @override
  void initState() {
    _isPrevious = false;
    _refreshController = RefreshController();
    _scrollController = ScrollController();
    _specialStoriesBloc = SpecialStoriesBloc(1, 20, widget.type);
    _specialStoriesBloc
        .add(GetSpecialStoriesList(true, isPrevious: _isPrevious));
    super.initState();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _specialStoriesBloc.close();
    _refreshController.dispose();
    super.dispose();
  }

  void _onRefresh() async {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _specialStoriesBloc
              .add(const GetSpecialStoriesList(false, isPrevious: true));
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
            _specialStoriesBloc
                .add(const GetSpecialStoriesList(false, isPrevious: false));
          });
        });
      }
    }
    _refreshController.loadComplete();
  }

  late bool _isPrevious;
  late ScrollController _scrollController;
  late SpecialStoriesBloc _specialStoriesBloc;
  late RefreshController _refreshController;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: themeMode(context, ColorCode.modeColor.name),
      body: BlocProvider(
        create: (context) => _specialStoriesBloc,
        child: BlocListener<SpecialStoriesBloc, SpecialStoriesState>(
          listener: (context, state) {
            const Center(child: CircularProgressIndicator());
          },
          child: BlocBuilder<SpecialStoriesBloc, SpecialStoriesState>(
            builder: (context, state) {
              if (state is SpecialStoriesLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is SpecialStoriesNoDataState) {
                return getEmptyData(context);
              }
              if (state is SpecialStoriesLoadedState) {
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
                                isShowRank: false,
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
