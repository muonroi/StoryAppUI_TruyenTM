import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.categories.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.category.stories.home.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.model.less.stories.dart';
import 'package:muonroi/Models/Stories/models.single.story.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Pages/Accounts/Logins/pages.logins.sign_in.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';
import 'package:muonroi/blocs/Stories/RecommendData/bloc/recommend_bloc.dart';

class SimilarStories extends StatefulWidget {
  final SingleResult infoStory;
  const SimilarStories({super.key, required this.infoStory});
  @override
  State<SimilarStories> createState() => _SimilarStoriesState();
}

class _SimilarStoriesState extends State<SimilarStories> {
  @override
  void initState() {
    controller = PageController(viewportFraction: 0.9);
    _recommendStoryPageBloc =
        RecommendStoryPageBloc(widget.infoStory.id, 1, 15);
    _recommendStoryPageBloc.add(GetRecommendStoriesList());
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    _recommendStoryPageBloc.close();
    super.dispose();
  }

  late PageController controller;
  late RecommendStoryPageBloc _recommendStoryPageBloc;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => _recommendStoryPageBloc,
        child: SizedBox(
          child: BlocListener<RecommendStoryPageBloc, RecommendStoryState>(
            listener: (context, state) {
              if (state is RecommendStoryErrorState) {
                SnackBar(
                  content: Text(state.error),
                );
              }
            },
            child: BlocBuilder<RecommendStoryPageBloc, RecommendStoryState>(
              builder: (context, state) {
                if (state is RecommendStoryLoadingState) {
                  return const CircularProgressIndicator();
                }
                if (state is RecommendStoryLoadedState) {
                  return Column(
                    children: [
                      GroupCategoryTextInfo(
                          titleText:
                              L(ViCode.similarStoriesTextInfo.toString()),
                          nextRoute: const SignInPage()),
                      SizedBox(
                        width: MainSetting.getPercentageOfDevice(context,
                                expectWidth:
                                    state.story.result.items.length * 120)
                            .width,
                        height: MainSetting.getPercentageOfDevice(context,
                                expectHeight: 190)
                            .height,
                        child: StoriesOfCategoriesData(
                          data: state.story.result.items
                              .map((e) => StoryLessModelWidget(
                                  networkImageUrl: e.imgUrl,
                                  storyName: e.storyTitle))
                              .toList(),
                          pageEditorController: controller,
                          padding: 0,
                        ),
                      )
                    ],
                  );
                }
                return const CircularProgressIndicator();
              },
            ),
          ),
        ));
  }
}
