import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.model.full.stories.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/blocs/Stories/FreeData/bloc/free_bloc.dart';
import '../../../../Settings/settings.colors.dart';

class StoriesVerticalData extends StatelessWidget {
  final List<StoryItems> storiesData;
  final bool isShowLabel;
  final bool isShowBack;
  const StoriesVerticalData(
      {super.key,
      required this.storiesData,
      required this.isShowLabel,
      required this.isShowBack});

  @override
  Widget build(BuildContext context) {
    return StoriesVerticalDataBody(
      storiesData: storiesData,
      isShowLabel: isShowLabel,
      isShowIconBack: isShowBack,
    );
  }
}

class StoriesVerticalDataBody extends StatefulWidget {
  final List<StoryItems> storiesData;
  final bool isShowLabel;
  final bool isShowIconBack;

  const StoriesVerticalDataBody(
      {super.key,
      required this.storiesData,
      required this.isShowLabel,
      required this.isShowIconBack});

  @override
  State<StoriesVerticalDataBody> createState() =>
      _StoriesVerticalDataBodyState();
}

class _StoriesVerticalDataBodyState extends State<StoriesVerticalDataBody> {
  @override
  void initState() {
    _freeStoryPageBloc = FreeStoryPageBloc(1, 15);
    _freeStoryPageBloc.add(GetFreeStoriesList());
    _scrollController = ScrollController();
    _scrollController.addListener(loadMore);
    super.initState();
  }

  @override
  void dispose() {
    _freeStoryPageBloc.close();
    _scrollController.dispose();
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
            _freeStoryPageBloc.add(GroupMoreFreeStoryList());
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

  late ScrollController _scrollController;
  late FreeStoryPageBloc _freeStoryPageBloc;
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
                    color: ColorDefaults.thirdMainColor,
                    onPressed: () {
                      Navigator.maybePop(context, true);
                    },
                    icon: const Icon(
                      Icons.arrow_back_ios_sharp,
                      color: ColorDefaults.thirdMainColor,
                    )),
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
                return SizedBox(
                  child: ListView.builder(
                      controller: _scrollController,
                      itemCount: state.story.result.items.length,
                      scrollDirection: Axis.vertical,
                      itemBuilder: (context, index) {
                        var storySingleInfo = state.story.result.items[index];
                        return Column(
                          children: [
                            StoriesFullModelWidget(
                              nameStory: storySingleInfo.storyTitle,
                              categoryName: storySingleInfo.nameCategory,
                              authorName: storySingleInfo.authorName,
                              imageLink: storySingleInfo.imgUrl,
                              tagsName: storySingleInfo.nameTag
                                  .map((e) => e.toString())
                                  .toList(),
                              lastUpdated: 0,
                              totalViews: storySingleInfo.totalView.toDouble(),
                              numberOfChapter:
                                  storySingleInfo.totalChapter.toDouble(),
                              isShowRank: widget.isShowLabel,
                              rankNumber: storySingleInfo.rankNumber,
                              storyId: storySingleInfo.id,
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
