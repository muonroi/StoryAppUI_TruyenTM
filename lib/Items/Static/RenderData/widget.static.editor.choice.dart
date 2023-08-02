import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/RenderData/widget.static.categories.home.dart';
import 'package:muonroi/Items/Static/RenderData/widgets.static.model.less.stories.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import '../../../Models/Stories/models.stories.story.dart';
import '../../../Settings/settings.language_code.vi..dart';
import '../../../Settings/settings.main.dart';

class EditorStories extends StatelessWidget {
  final List<List<StoryModel>> storiesData;
  const EditorStories({super.key, required this.storiesData});

  @override
  Widget build(BuildContext context) {
    return EditorStoriesBody(
      storiesData: storiesData,
    );
  }
}

class EditorStoriesBody extends StatelessWidget {
  final List<List<StoryModel>> storiesData;
  const EditorStoriesBody({super.key, required this.storiesData});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorDefaults.lightAppColor,
      appBar: AppBar(
        backgroundColor: ColorDefaults.lightAppColor,
        elevation: 0,
        leading: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
              onPressed: () {
                Navigator.pop(context);
              },
              icon: const Icon(
                Icons.arrow_back_ios_sharp,
                color: ColorDefaults.thirdMainColor,
              )),
        ),
      ),
      body: ListView.builder(
          itemCount: storiesData.length,
          itemBuilder: (context, index) {
            List<Widget> dataEachRow = storiesData[index]
                .map((e) => StoryLessModelWidget(
                      networkImageUrl: e.image,
                      storyName: e.name,
                    ))
                .toList();

            return Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      '->',
                      style: FontsDefault.h4
                          .copyWith(color: ColorDefaults.mainColor),
                    ),
                    OnlyTitleTextInfo(
                      textInfo: L(ViCode.newChapterUpdatedTextInfo.toString()),
                    ),
                  ],
                ),
                SizedBox(
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 180)
                      .height,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: 4,
                    itemBuilder: (context, index) {
                      return Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [dataEachRow[index]],
                      );
                    },
                  ),
                )
              ],
            );
          }),
    );
  }
}
