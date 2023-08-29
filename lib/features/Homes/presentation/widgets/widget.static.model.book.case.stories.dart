import 'package:flutter/material.dart';
import 'package:muonroi/features/Chapters/presentation/pages/widget.static.model.chapter.dart';
import 'package:muonroi/shared/Settings/settings.colors.dart';
import 'package:muonroi/shared/Settings/settings.fonts.dart';
import 'package:muonroi/shared/Settings/settings.language_code.vi..dart';
import 'package:muonroi/shared/Settings/settings.main.dart';
import 'package:muonroi/features/Stories/data/models/models.stories.story.dart';
import 'package:muonroi/features/Stories/data/repositories/story_repository.dart';
import 'package:muonroi/features/Stories/presentation/pages/widget.static.stories.detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StoriesBookCaseModelWidget extends StatefulWidget {
  final StoryItems storyInfo;
  const StoriesBookCaseModelWidget({
    super.key,
    required this.storyInfo,
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
      });
    }
  }

  late bool buttonState = true;
  late int chapterId = 0;
  late int chapterNumber = 0;
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
                builder: (context) => StoriesDetail(
                    storyId: widget.storyInfo.id,
                    storyTitle: widget.storyInfo.storyTitle)));
      },
      onTapUp: (_) => _setDefaultItemState(),
      onTapCancel: () => _setDefaultItemState(),
      child: AnimatedContainer(
        margin: const EdgeInsets.all(8.0),
        decoration: BoxDecoration(
            color: ColorDefaults.lightAppColor,
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
        child: Container(
          color: ColorDefaults.secondMainColor,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SizedBox(
                  width: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 80)
                      .width,
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 120)
                      .height,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: netWorkImage(widget.storyInfo.imgUrl, true),
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
                          style: FontsDefault.h4.copyWith(
                              fontWeight: FontWeight.w700, fontSize: 18),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                        showToolTip(widget.storyInfo.storyTitle)
                      ]),
                    ),
                    Text(
                      widget.storyInfo.authorName,
                      style: FontsDefault.h5,
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
                                          var storyInfo = await storyRepository
                                              .fetchDetailStory(
                                                  widget.storyInfo.id);
                                          if (context.mounted) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => Chapter(
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
                                                          .result.lastChapterId,
                                                      firstChapterId: storyInfo
                                                          .result
                                                          .firstChapterId)),
                                            );
                                          }
                                        }
                                      : null,
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor: buttonState
                                          ? ColorDefaults.mainColor
                                          : ColorDefaults.secondMainColor,
                                      shape: const StadiumBorder(),
                                      side: BorderSide(
                                          color: buttonState
                                              ? ColorDefaults.mainColor
                                              : ColorDefaults.secondMainColor,
                                          width: 2)),
                                  child: Text(
                                    '${L(ViCode.chapterNumberTextInfo.toString())} ${chapterNumber == 0 ? 1 : chapterNumber}',
                                    style: const TextStyle(
                                        fontFamily: FontsDefault.inter,
                                        fontSize: 16,
                                        color: ColorDefaults.defaultTextColor),
                                  ),
                                ))),
                        Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: SizedBox(
                            width: MainSetting.getPercentageOfDevice(context,
                                    expectWidth: 100)
                                .width,
                            child: Stack(children: [
                              Text(
                                widget.storyInfo.updatedDateString,
                                style: FontsDefault.h5.copyWith(
                                    fontSize: 12, fontStyle: FontStyle.italic),
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
      ),
    );
  }
}
