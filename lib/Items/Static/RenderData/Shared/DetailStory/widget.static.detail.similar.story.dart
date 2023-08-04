import 'package:flutter/material.dart';
import 'package:muonroi/Controller/controller.main.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.categories.home.dart';
import 'package:muonroi/Items/Static/RenderData/PrimaryPages/Home/widget.static.category.stories.home.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.model.less.stories.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';

class SimilarStories extends StatefulWidget {
  final StoryModel widget;
  const SimilarStories({super.key, required this.widget});

  @override
  State<SimilarStories> createState() => _SimilarStoriesState();
}

class _SimilarStoriesState extends State<SimilarStories> {
  late PageController controller;
  @override
  void initState() {
    controller = PageController();
    super.initState();
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    late List<Widget>? dataEachRow;
    for (int i = 0; i < widget.widget.similarStories!.length; i++) {
      dataEachRow = widget.widget.similarStories
          ?.map((e) => StoryLessModelWidget(
                networkImageUrl: widget.widget.similarStories![i].image,
                storyName: widget.widget.similarStories![i].name,
              ))
          .toList();
    }
    return SizedBox(
      child: Column(
        children: [
          GroupCategoryTextInfo(
              titleText: L(ViCode.similarStoriesTextInfo.toString()),
              nextRoute: const HomePage()),
          SizedBox(
            width: MainSetting.getPercentageOfDevice(context,
                    expectWidth: widget.widget.similarStories!.length * 120)
                .width,
            height:
                MainSetting.getPercentageOfDevice(context, expectHeight: 190)
                    .height,
            child: StoriesOfCategoriesData(
              data: dataEachRow ?? [],
              pageEditorController: controller,
            ),
          )
        ],
      ),
    );
  }
}
