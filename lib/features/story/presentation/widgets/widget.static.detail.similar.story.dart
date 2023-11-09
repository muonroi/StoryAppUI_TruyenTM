import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/story/bloc/recommend/recommend_bloc.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.model.less.stories.dart';
import 'package:muonroi/features/story/settings/enums/enum.stories.special.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.categories.home.dart';
import 'package:muonroi/features/homes/presentation/widgets/widget.static.category.stories.home.dart';
import 'package:muonroi/features/story/data/models/models.single.story.dart';
import 'package:muonroi/features/story/presentation/pages/widget.static.stories.vertical.dart';

class SimilarStories extends StatefulWidget {
  final StorySingleResult infoStory;
  const SimilarStories({super.key, required this.infoStory});
  @override
  State<SimilarStories> createState() => _SimilarStoriesState();
}

class _SimilarStoriesState extends State<SimilarStories> {
  @override
  void initState() {
    controller = PageController(viewportFraction: 0.9);
    _recommendStoryPageBloc =
        RecommendStoryPageBloc(widget.infoStory.id, 1, 25);
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
                  var storyInfo = state.story.result.items;
                  return Column(
                    children: [
                      GroupCategoryTextInfo(
                          titleText: L(context,
                              LanguageCodes.similarStoriesTextInfo.toString()),
                          nextRoute: StoriesVerticalData(
                            isShowBack: true,
                            isShowLabel: false,
                            stories: storyInfo,
                          )),
                      SizedBox(
                        width: MainSetting.getPercentageOfDevice(context,
                                expectWidth: storyInfo.length * 120)
                            .width,
                        height: MainSetting.getPercentageOfDevice(context,
                                expectHeight: 190)
                            .height,
                        child: StoriesOfCategoriesData(
                          type: EnumStoriesSpecial.storiesSimilar,
                          pageEditorController: controller,
                          padding: 0,
                          isHaveData: true,
                          data: storyInfo
                              .map((e) => StoryLessModelWidget(
                                    networkImageUrl: e.imgUrl,
                                    storyName: e.storyTitle,
                                    storyId: e.id,
                                  ))
                              .toList(),
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
