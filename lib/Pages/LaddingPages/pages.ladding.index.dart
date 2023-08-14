import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/Controller/controller.main.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.list.stories.image.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/blocs/Stories/HomeData/bloc/story_bloc.dart';
import '../../Settings/settings.images.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final StoryDataHomePageBloc _storyBloc = StoryDataHomePageBloc();
  @override
  void initState() {
    _storyBloc.add(GetStoriesList());
    super.initState();
  }

  @override
  void dispose() {
    _storyBloc.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _storyBloc,
      child: Scaffold(
          body: BlocListener<StoryDataHomePageBloc, StoryState>(
        listener: (context, state) {
          if (state is StoryErrorState) {
            SnackBar(
              content: Text(state.error),
            );
          }
        },
        child: BlocBuilder<StoryDataHomePageBloc, StoryState>(
          builder: (context, state) {
            if (state is StoryLoadingState) {
              return _homeLoading();
            }
            if (state is StoryLoadedState) {
              return _homePage(context, state.story);
            }
            return _homeLoading();
          },
        ),
      )),
    );
  }
}

Widget _homePage(BuildContext context, StoryModel storyItems) {
  return MainPage(
    storiesInit: storyItems.result.items,
    storiesCommon: storyItems.result.items
        .map((e) => StoriesImageIncludeSizeBox(
              guid: e.guid,
              storyId: e.id.toString(),
              nameStory: e.storyTitle,
              introStory: e.storySynopsis,
              isShow: e.isShow,
              totalViews: e.totalView,
              totalVote: e.totalFavorite,
              vote: e.rating,
              slug: e.slug,
              categoryName: e.nameCategory,
              authorName: e.authorName,
              tagsName: e.nameTag.map((e) => e.toString()).toList(),
              totalChapters: e.totalChapters,
              imageLink: e.imgUrl,
              lastUpdated: e.updatedDateString,
              userCoin: const [],
              userComments: const [],
              numberOfChapter: e.totalChapters.toDouble(),
              rankNumber: 0,
              notification: "",
              newChapters: const [],
              newChapterNames: const [],
              similarStories: const [],
            ))
        .take(6)
        .toList(),
    storiesEditorChoice: storyItems.result.items
        .map((e) => StoriesImageIncludeSizeBox(
              guid: e.guid,
              storyId: e.id.toString(),
              nameStory: e.storyTitle,
              introStory: e.storySynopsis,
              isShow: e.isShow,
              totalViews: e.totalView,
              totalVote: e.totalFavorite,
              vote: e.rating,
              slug: e.slug,
              categoryName: e.nameCategory,
              authorName: e.authorName,
              tagsName: e.nameTag.map((e) => e.toString()).toList(),
              totalChapters: e.totalChapters,
              imageLink: e.imgUrl,
              lastUpdated: e.updatedDateString,
              userCoin: const [],
              userComments: const [],
              numberOfChapter: e.totalChapters.toDouble(),
              rankNumber: 0,
              notification: "",
              newChapters: const [],
              newChapterNames: const [],
              similarStories: const [],
            ))
        .take(15)
        .toList(),
  );
}

Widget _homeLoading() => Padding(
      padding: const EdgeInsets.symmetric(horizontal: 32),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(flex: 2, child: Image.asset(ImageDefault.laddingLogo))
        ],
      ),
    );
