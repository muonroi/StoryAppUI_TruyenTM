import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.model.full.stories.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
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

class StoriesVerticalDataBody extends StatelessWidget {
  final List<StoryItems> storiesData;
  final bool isShowLabel;
  final bool isShowIconBack;

  const StoriesVerticalDataBody(
      {super.key,
      required this.storiesData,
      required this.isShowLabel,
      required this.isShowIconBack});

  @override
  Widget build(BuildContext context) {
    // if (isShowLabel) {
    //   storiesData.sort((a, b) => a.rankNumber!.compareTo(b.rankNumber!));
    // }
    List<Widget> dataEachRow = storiesData
        .map((e) => StoriesFullModelWidget(
              nameStory: e.storyTitle,
              categoryName: e.nameCategory,
              authorName: e.authorName,
              imageLink: e.imgUrl,
              tagsName: e.nameTag.map((e) => e.toString()).toList(),
              lastUpdated: 0,
              totalViews: e.totalView * 1.0,
              numberOfChapter: e.totalChapters * 1.0,
              isShowRank: isShowLabel,
              rankNumber: 0,
              dataStory: StoryItems(
                  id: e.id,
                  guid: e.guid,
                  storySynopsis: e.storySynopsis,
                  authorName: e.authorName,
                  nameCategory: e.nameCategory,
                  imgUrl: e.imgUrl,
                  storyTitle: e.storyTitle,
                  totalChapters: int.parse(e.totalChapters.toString()),
                  nameTag: e.nameTag,
                  totalView: e.totalView,
                  isShow: e.isShow,
                  rating: e.rating,
                  slug: e.slug,
                  totalFavorite: e.totalFavorite,
                  updatedDateString: e.updatedDateString,
                  updatedDateTs: 0),
            ))
        .toList();
    return Scaffold(
      backgroundColor: ColorDefaults.lightAppColor,
      appBar: isShowIconBack
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
