import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/stories/data/models/models.stories.story.dart';
import 'package:muonroi/features/stories/presentation/pages/widget.static.stories.detail.dart';
import 'package:muonroi/features/stories/settings/settings.dart';

class StoriesFullModelWidget extends StatefulWidget {
  final StoryItems storiesItem;
  final bool isShowRank;
  const StoriesFullModelWidget(
      {super.key, required this.storiesItem, required this.isShowRank});

  @override
  State<StoriesFullModelWidget> createState() => _StoriesFullModelWidgetState();
}

class _StoriesFullModelWidgetState extends State<StoriesFullModelWidget> {
  double widgetScale = 1.0;
  @override
  void initState() {
    super.initState();
  }

  void _toggleItemState() {
    setState(() {
      widgetScale = 0.9;
    });
  }

  void _setDefaultItemState() {
    setState(() {
      widgetScale = 1.0;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _toggleItemState(),
      onTapUp: (_) => _setDefaultItemState(),
      onTapCancel: () => _setDefaultItemState(),
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StoriesDetail(
                      storyId: widget.storiesItem.id,
                      storyTitle: widget.storiesItem.nameCategory,
                    )));
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10),
            boxShadow: const [
              BoxShadow(
                  color: Color.fromARGB(255, 221, 219, 219),
                  offset: Offset(-3, 3),
                  blurRadius: 3.0)
            ]),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeOutSine,
        transform: Matrix4.diagonal3Values(
          widgetScale,
          widgetScale,
          1.0,
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 80)
                        .width,
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 120)
                    .height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: widget.isShowRank
                      ? Banner(
                          message:
                              '${L(ViCode.rankTextInfo.toString())} ${widget.storiesItem.rankNumber}',
                          color: widget.storiesItem.rankNumber == 1
                              ? ColorDefaults.mainColor
                              : ColorDefaults.secondMainColor,
                          textStyle: FontsDefault.h6
                              .copyWith(fontWeight: FontWeight.w700),
                          location: BannerLocation.topEnd,
                          child: netWorkImage(widget.storiesItem.imgUrl, true),
                        )
                      : netWorkImage(widget.storiesItem.imgUrl, true),
                ),
              ),
            ),
            SizedBox(
              height:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 120)
                      .height,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 200)
                        .width,
                    child: Text(
                      widget.storiesItem.authorName,
                      style: FontsDefault.h5.copyWith(
                          fontWeight: FontWeight.w600,
                          color: ColorDefaults.mainColor),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 250)
                        .width,
                    child: Text(
                      widget.storiesItem.storyTitle,
                      style:
                          FontsDefault.h5.copyWith(fontWeight: FontWeight.w700),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          widget.storiesItem.nameCategory,
                          style: FontsDefault.h5,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${formatNumberThouSand(widget.storiesItem.totalChapter.toDouble())} ${L(ViCode.chapterNumberTextInfo.toString())}',
                          style: FontsDefault.h5,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                  Row(
                    children: widget.storiesItem.nameTag
                        .map((item) => Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: Text(
                                '#$item',
                                style: FontsDefault.h6.copyWith(
                                    fontSize: 12, fontStyle: FontStyle.italic),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ))
                        .toList(),
                  ),
                  Text(
                    widget.storiesItem.updatedDateString.toString(),
                    style: FontsDefault.h6
                        .copyWith(fontStyle: FontStyle.italic, fontSize: 12),
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
