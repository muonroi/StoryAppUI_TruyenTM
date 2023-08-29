import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/Homes/bloc/homeData/story_bloc.dart';
import 'package:muonroi/features/Homes/presentation/pages/controller.main.dart';
import 'package:muonroi/shared/Settings/settings.images.dart';
import 'package:muonroi/features/Homes/presentation/widgets/widget.static.list.stories.image.dart';
import 'package:muonroi/features/Stories/data/models/models.stories.story.dart';

class IndexPage extends StatefulWidget {
  const IndexPage({super.key});

  @override
  State<IndexPage> createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> {
  final StoryDataHomePageBloc _storyBloc = StoryDataHomePageBloc(1, 30);
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

Widget _homePage(BuildContext context, StoriesModel storyItems) {
  return MainPage(
    storiesInit: storyItems.result.items,
    storiesCommon: storyItems.result.items
        .map((e) => StoriesImageIncludeSizeBox(
              storyId: e.id,
              nameStory: e.storyTitle,
              imageLink: e.imgUrl,
            ))
        .take(6)
        .toList(),
    storiesEditorChoice: storyItems.result.items
        .map((e) => StoriesImageIncludeSizeBox(
              storyId: e.id,
              nameStory: e.storyTitle,
              imageLink: e.imgUrl,
            ))
        .take(25)
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
