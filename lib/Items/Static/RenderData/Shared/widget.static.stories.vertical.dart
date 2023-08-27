import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.model.full.stories.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';
import 'package:muonroi/blocs/Stories/FreeData/bloc/free_bloc.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import '../../../../Settings/settings.colors.dart';

class StoriesVerticalData extends StatelessWidget {
  final bool isShowLabel;
  final bool isShowBack;
  final int? categoryId;
  final List<StoryItems>? stories;
  const StoriesVerticalData(
      {super.key,
      required this.isShowLabel,
      required this.isShowBack,
      this.categoryId,
      this.stories});

  @override
  Widget build(BuildContext context) {
    return StoriesVerticalDataBody(
      isShowLabel: isShowLabel,
      isShowIconBack: isShowBack,
      idCategory: categoryId,
      stories: stories,
    );
  }
}

class StoriesVerticalDataBody extends StatefulWidget {
  final bool isShowLabel;
  final bool isShowIconBack;
  final int? idCategory;
  final List<StoryItems>? stories;
  const StoriesVerticalDataBody(
      {super.key,
      required this.isShowLabel,
      required this.isShowIconBack,
      this.idCategory,
      this.stories});

  @override
  State<StoriesVerticalDataBody> createState() =>
      _StoriesVerticalDataBodyState();
}

class _StoriesVerticalDataBodyState extends State<StoriesVerticalDataBody> {
  @override
  void initState() {
    _freeStoryPageBloc = FreeStoryPageBloc(1, 15);
    if (widget.idCategory == 0) {
      _freeStoryPageBloc.add(GetFreeStoriesList());
    } else {
      _freeStoryPageBloc.add(GroupMoreFreeStoryList(
          categoryId: widget.idCategory ?? 0, isPrevious: false));
    }
    _scrollController = ScrollController();
    _refreshController = RefreshController(initialRefresh: false);
    _scrollController.addListener(loadMore);
    tempData = widget.stories;
    super.initState();
  }

  @override
  void dispose() {
    _freeStoryPageBloc.close();
    _scrollController.dispose();
    _refreshController.dispose();
    _scrollController.removeListener(loadMore);
    super.dispose();
  }

  void loadMore() {
    if (context.mounted) {
      if (_scrollController.hasClients &&
          _scrollController.position.atEdge &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          countLoadMore == 1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _freeStoryPageBloc.add(GroupMoreFreeStoryList(
                categoryId: widget.idCategory ?? 0, isPrevious: false));
            countLoadMore = 0;
          });
        });
      } else if (_scrollController.position.atEdge &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          countLoadMore < 1) {
        countLoadMore++;
      }
    }
  }

  void _onRefresh() async {
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _freeStoryPageBloc.add(GroupMoreFreeStoryList(
              categoryId: widget.idCategory ?? 0, isPrevious: true));
        });
      });
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading() async {
    Future.delayed(const Duration(milliseconds: 1000));
    if (mounted) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {});
      });
    }
    _refreshController.loadComplete();
  }

  late List<StoryItems>? tempData;
  late ScrollController _scrollController;
  late FreeStoryPageBloc _freeStoryPageBloc;
  late RefreshController _refreshController;

  int countLoadMore = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorDefaults.lightAppColor,
      appBar: widget.isShowIconBack
          ? AppBar(
              backgroundColor: ColorDefaults.lightAppColor,
              elevation: 0,
              leading: Align(
                alignment: Alignment.centerLeft,
                child: IconButton(
                    splashRadius: 25,
                    color: ColorDefaults.thirdMainColor,
                    onPressed: () {
                      Navigator.maybePop(context, true);
                    },
                    icon: backButtonCommon()),
              ),
            )
          : null,
      body: BlocProvider(
        create: (context) => _freeStoryPageBloc,
        child: BlocListener<FreeStoryPageBloc, FreeStoryState>(
          listener: (context, state) {
            const Center(child: CircularProgressIndicator());
          },
          child: BlocBuilder<FreeStoryPageBloc, FreeStoryState>(
            builder: (context, state) {
              if (state is FreeStoryLoadingState) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state is FreeStoryLoadedState) {
                var storiesInfo = tempData ?? state.story.result.items;
                tempData = null;
                return SmartRefresher(
                  enablePullDown: true,
                  enablePullUp: true,
                  controller: _refreshController,
                  onRefresh: _onRefresh,
                  onLoading: _onLoading,
                  footer: ClassicFooter(
                    canLoadingIcon: const Icon(Icons.arrow_downward),
                    canLoadingText: L(ViCode.nextChapterTextInfo.toString()),
                    idleText: L(ViCode.loadingMoreTextInfo.toString()),
                  ),
                  header: ClassicHeader(
                    idleIcon: const Icon(Icons.arrow_upward),
                    refreshingText: L(ViCode.loadingTextInfo.toString()),
                    releaseText: L(ViCode.loadingTextInfo.toString()),
                    idleText: L(ViCode.loadingPreviousTextInfo.toString()),
                  ),
                  child: ListView.builder(
                      physics: const BouncingScrollPhysics(),
                      controller: _scrollController,
                      itemCount: storiesInfo.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var storySingleInfo = storiesInfo[index];
                        return Column(
                          children: [
                            StoriesFullModelWidget(
                              isShowRank: widget.isShowLabel,
                              storiesItem: storySingleInfo,
                            )
                          ],
                        );
                      }),
                );
              }
              return const Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
