import 'package:flutter/material.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import '../../../Settings/settings.colors.dart';

class StoriesVerticalData extends StatelessWidget {
  final List<StoryModel> storiesData;
  final bool isShowLabel;
  const StoriesVerticalData(
      {super.key, required this.storiesData, required this.isShowLabel});

  @override
  Widget build(BuildContext context) {
    return StoriesVerticalDataBody(
      storiesData: storiesData,
      isShowLabel: isShowLabel,
    );
  }
}

class StoriesVerticalDataBody extends StatelessWidget {
  final List<StoryModel> storiesData;
  final bool isShowLabel;

  const StoriesVerticalDataBody(
      {super.key, required this.storiesData, required this.isShowLabel});

  @override
  Widget build(BuildContext context) {
    if (isShowLabel) {
      storiesData.sort((a, b) => a.rankNumber!.compareTo(b.rankNumber!));
    }
    List<Widget> dataEachRow = storiesData
        .map((e) => StoriesFullModelWidget(
              nameStory: e.name,
              categoryName: e.category!,
              authorName: e.authorName!,
              imageLink: e.image,
              tagsName: e.tagsName!,
              lastUpdated: e.lastUpdated!,
              totalViews: e.totalView!,
              numberOfChapter: e.numberOfChapter!,
              isShowRank: isShowLabel,
              rankNumber: e.rankNumber,
            ))
        .toList();
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
          scrollDirection: Axis.vertical,
          itemBuilder: (context, index) {
            return Column(
              children: [dataEachRow[index]],
            );
          }),
    );
  }
}
