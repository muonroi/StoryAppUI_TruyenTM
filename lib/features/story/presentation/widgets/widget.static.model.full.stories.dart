import 'package:flutter/material.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/story/data/models/models.stories.story.dart';
import 'package:muonroi/features/story/presentation/pages/widget.static.stories.detail.dart';
import 'package:muonroi/features/story/settings/settings.dart';

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
                builder: (context) => StoryDetail(
                      storyId: widget.storiesItem.id,
                      storyTitle: widget.storiesItem.nameCategory,
                    )));
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: themeMode(context, ColorCode.disableColor.name),
            borderRadius: BorderRadius.circular(10),
            boxShadow: [
              BoxShadow(
                  color: themeMode(context, ColorCode.disableColor.name),
                  offset: const Offset(-3, 3),
                  blurRadius: 0.5)
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
            Container(
              padding: const EdgeInsets.all(8.0),
              child: SizedBox(
                width:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 100)
                        .width,
                height: MainSetting.getPercentageOfDevice(context,
                        expectHeight: 120)
                    .height,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: widget.isShowRank
                      ? Banner(
                          message:
                              '${L(context, LanguageCodes.rankTextInfo.toString())} ${widget.storiesItem.rankNumber}',
                          color: widget.storiesItem.rankNumber == 1
                              ? themeMode(context, ColorCode.mainColor.name)
                              : themeMode(context, ColorCode.modeColor.name),
                          textStyle: CustomFonts.h6(context)
                              .copyWith(fontWeight: FontWeight.w700),
                          location: BannerLocation.topEnd,
                          child: netWorkImage(
                              context, widget.storiesItem.imgUrl, true),
                        )
                      : netWorkImage(context, widget.storiesItem.imgUrl, true),
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
                      style: CustomFonts.h5(context).copyWith(
                          fontWeight: FontWeight.w600,
                          color: themeMode(context, ColorCode.mainColor.name)),
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
                      style: CustomFonts.h5(context)
                          .copyWith(fontWeight: FontWeight.w700),
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
                          style: CustomFonts.h5(context),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Text(
                          '${formatNumberThouSand(widget.storiesItem.totalChapter.toDouble())} ${L(context, LanguageCodes.chapterNumberTextInfo.toString())}',
                          style: CustomFonts.h5(context),
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
                                style: CustomFonts.h6(context).copyWith(
                                    fontSize: 12, fontStyle: FontStyle.italic),
                                overflow: TextOverflow.ellipsis,
                                maxLines: 2,
                              ),
                            ))
                        .toList(),
                  ),
                  Text(
                    widget.storiesItem.updatedDateString.toString(),
                    style: CustomFonts.h6(context)
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
