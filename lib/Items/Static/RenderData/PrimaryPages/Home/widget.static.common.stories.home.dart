import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.stories.detail.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import '../../../../../Models/Stories/models.stories.story.dart';
import '../../../../../Settings/settings.fonts.dart';
import '../../../../../Settings/settings.main.dart';

class CommonTopStoriesData extends StatefulWidget {
  final List<StoryItems> storiesCommonInfo;

  const CommonTopStoriesData({
    super.key,
    required this.storiesCommonInfo,
  });

  @override
  State<CommonTopStoriesData> createState() => _CommonTopStoriesDataState();
}

class _CommonTopStoriesDataState extends State<CommonTopStoriesData> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height:
          MainSetting.getPercentageOfDevice(context, expectHeight: 250).height,
      margin: const EdgeInsets.symmetric(vertical: 8.0),
      child: ListView.builder(
        itemCount: 4,
        itemExtent: 170,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Stack(children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Text((index + 1).toString(),
                                style: FontsDefault.h3
                                    .copyWith(color: ColorDefaults.mainColor)),
                            SizedBox(
                                width: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectWidth: 101.2)
                                    .width,
                                height: MainSetting.getPercentageOfDevice(
                                        context,
                                        expectHeight: 145)
                                    .height,
                                child: SizedBox(
                                    child: CachedNetworkImage(
                                  imageUrl:
                                      widget.storiesCommonInfo[index].imgUrl,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          CircularProgressIndicator(
                                              value: downloadProgress.progress),
                                  errorWidget: (context, url, error) =>
                                      const Icon(Icons.error),
                                  fit: BoxFit.cover,
                                ))),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                              width: MainSetting.getPercentageOfDevice(context,
                                      expectWidth: 140)
                                  .width,
                              child: Column(
                                children: [
                                  Text(
                                      widget
                                          .storiesCommonInfo[index].storyTitle,
                                      style: FontsDefault.h5,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1),
                                  Text(
                                      widget.storiesCommonInfo[index]
                                          .nameCategory,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: FontsDefault.h6),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MainSetting.getPercentageOfDevice(context,
                                expectWidth: 70)
                            .width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            const Icon(
                              Icons.remove_red_eye_rounded,
                              color: ColorDefaults.mainColor,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                formatValueNumber(
                                    widget.storiesCommonInfo[index].totalView *
                                        1.0),
                                style: FontsDefault.h6,
                                overflow: TextOverflow.ellipsis,
                                maxLines: 1,
                              ),
                            )
                          ],
                        ),
                      )
                    ],
                  ),
                  Positioned.fill(
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => StoriesDetail(
                                      storyId:
                                          widget.storiesCommonInfo[index].id,
                                      storyTitle: widget
                                          .storiesCommonInfo[index]
                                          .storyTitle)));
                        },
                        child: Tooltip(
                          onTriggered: () => TooltipTriggerMode.longPress,
                          message: widget.storiesCommonInfo[index].storyTitle,
                          showDuration: const Duration(milliseconds: 1000),
                        ),
                      ),
                    ),
                  )
                ])
              ],
            ),
          );
        },
      ),
    );
  }
}
