import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/presentation/pages/page.model.chapter.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/story/data/models/model.stories.story.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
import 'package:muonroi/features/story/presentation/pages/page.stories.detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoriesBookCaseModelWidget extends StatefulWidget {
  final StoryItems storyInfo;
  final bool isSelected;
  const StoriesBookCaseModelWidget({
    super.key,
    required this.storyInfo,
    required this.isSelected,
  });

  @override
  State<StoriesBookCaseModelWidget> createState() =>
      _StoriesBookCaseModelWidget();
}

class _StoriesBookCaseModelWidget extends State<StoriesBookCaseModelWidget> {
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

  Future<void> getChapterId() async {
    final SharedPreferences chapterTemp = await sharedPreferences;
    if (mounted) {
      setState(() {
        chapterId = (chapterTemp
                .getInt("story-${widget.storyInfo.id}-current-chapter-id") ??
            0);
        chapterNumber = (chapterTemp
                .getInt("story-${widget.storyInfo.id}-current-chapter") ??
            0);
        pageIndex = (chapterTemp
                .getInt("story-${widget.storyInfo.id}-current-page-index") ??
            0);
      });
    }
  }

  late bool buttonState = true;
  late int chapterId = 0;
  late int chapterNumber = 0;
  late int pageIndex = 0;
  final Future<SharedPreferences> sharedPreferences =
      SharedPreferences.getInstance();
  final StoryRepository storyRepository = StoryRepository();

  @override
  Widget build(BuildContext context) {
    getChapterId();
    buttonState = true;
    return GestureDetector(
      onTapDown: (_) {
        _toggleItemState();
      },
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => StoryDetail(
                    storyId: widget.storyInfo.id,
                    storyTitle: widget.storyInfo.storyTitle)));
      },
      onTapUp: (_) => _setDefaultItemState(),
      onTapCancel: () => _setDefaultItemState(),
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
        child: Stack(children: [
          Container(
            color: themeMode(context, ColorCode.disableColor.name),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SizedBox(
                    width: MainSetting.getPercentageOfDevice(context,
                            expectWidth: 90)
                        .width,
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight: 120)
                        .height,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child:
                          netWorkImage(context, widget.storyInfo.imgUrl, true),
                    ),
                  ),
                ),
                SizedBox(
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 120)
                      .height,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        width: MainSetting.getPercentageOfDevice(context,
                                expectWidth: 250)
                            .width,
                        child: Stack(children: [
                          Text(
                            widget.storyInfo.storyTitle,
                            style: CustomFonts.h4(context).copyWith(
                                fontWeight: FontWeight.w700, fontSize: 18),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          showToolTip(widget.storyInfo.storyTitle)
                        ]),
                      ),
                      Text(
                        widget.storyInfo.authorName,
                        style: CustomFonts.h5(context),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          Padding(
                              padding: const EdgeInsets.only(right: 8.0),
                              child: SizedBox(
                                  width: MainSetting.getPercentageOfDevice(
                                          context,
                                          expectWidth: 170)
                                      .width,
                                  child: ElevatedButton(
                                    onPressed: buttonState
                                        ? () async {
                                            buttonState = false;
                                            var storyInfo =
                                                await storyRepository
                                                    .fetchDetailStory(
                                                        widget.storyInfo.id);
                                            if (context.mounted) {
                                              Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) => Chapter(
                                                        author: widget.storyInfo
                                                            .authorName,
                                                        imageUrl: storyInfo
                                                            .result.imgUrl,
                                                        chapterNumber:
                                                            chapterNumber == 0
                                                                ? 1
                                                                : chapterNumber,
                                                        totalChapter: storyInfo
                                                            .result
                                                            .totalChapter,
                                                        pageIndex: pageIndex,
                                                        loadSingleChapter:
                                                            false,
                                                        isLoadHistory: true,
                                                        storyId:
                                                            storyInfo.result.id,
                                                        storyName: storyInfo
                                                            .result.storyTitle,
                                                        chapterId: chapterId == 0
                                                            ? storyInfo.result
                                                                .firstChapterId
                                                            : chapterId,
                                                        lastChapterId: storyInfo
                                                            .result
                                                            .lastChapterId,
                                                        firstChapterId: storyInfo
                                                            .result
                                                            .firstChapterId)),
                                              );
                                            }
                                          }
                                        : null,
                                    style: ElevatedButton.styleFrom(
                                        backgroundColor: buttonState
                                            ? themeMode(context,
                                                ColorCode.mainColor.name)
                                            : themeMode(context,
                                                ColorCode.modeColor.name),
                                        shape: const StadiumBorder(),
                                        side: BorderSide(
                                            color: buttonState
                                                ? themeMode(context,
                                                    ColorCode.mainColor.name)
                                                : themeMode(context,
                                                    ColorCode.modeColor.name),
                                            width: 2)),
                                    child: Text(
                                      '${L(context, LanguageCodes.chapterNumberTextInfo.toString())} ${chapterNumber == 0 ? 1 : chapterNumber}',
                                      style: TextStyle(
                                          fontFamily: CustomFonts.inter,
                                          fontSize: 16,
                                          color: themeMode(context,
                                              ColorCode.textColor.name)),
                                    ),
                                  ))),
                          Padding(
                            padding: const EdgeInsets.only(right: 8.0),
                            child: SizedBox(
                              width: MainSetting.getPercentageOfDevice(context,
                                      expectWidth: 80)
                                  .width,
                              child: Stack(children: [
                                Text(
                                  widget.storyInfo.updatedDateString,
                                  style: CustomFonts.h5(context).copyWith(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                showToolTip(widget.storyInfo.updatedDateString)
                              ]),
                            ),
                          )
                        ],
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
          widget.isSelected
              ? Positioned(
                  right: 0,
                  child: ClipRect(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Icon(
                        Icons.check_box,
                        color: themeMode(context, ColorCode.mainColor.name),
                      ),
                    ),
                  ))
              : const SizedBox()
        ]),
      ),
    );
  }
}
