import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/homes/settings/settings.dart';
import 'package:muonroi/features/stories/data/models/models.stories.story.dart';
import 'package:muonroi/features/stories/presentation/pages/widget.static.stories.detail.dart';

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
                                style: FontsDefault.h3(context).copyWith(
                                    color: themMode(
                                        context, ColorCode.mainColor.name))),
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
                                  child: netWorkImage(
                                      widget.storiesCommonInfo[index].imgUrl,
                                      true),
                                )),
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
                                      style: FontsDefault.h5(context),
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1),
                                  Text(
                                      widget.storiesCommonInfo[index]
                                          .nameCategory,
                                      overflow: TextOverflow.ellipsis,
                                      maxLines: 1,
                                      style: FontsDefault.h6(context)),
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
                            Icon(
                              Icons.remove_red_eye_rounded,
                              color:
                                  themMode(context, ColorCode.mainColor.name),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                formatValueNumber(
                                    widget.storiesCommonInfo[index].totalView *
                                        1.0),
                                style: FontsDefault.h6(context),
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
                                  builder: (context) => StoryDetail(
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
