import 'package:flutter/material.dart';
import 'package:muonroi/features/story/presentation/pages/page.audio.story.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'widget.static.custom.dashboard.chapter.bottom.dart';

class BottomChapterDetail extends StatefulWidget {
  final String author;
  final Function(bool) callback;
  final int chapterId;
  final String title;
  final int storyId;
  final void Function(int chapterId, bool isCheckShow) onLoading;
  final void Function(int chapterId) onRefresh;
  final Color backgroundColor;
  final Color fontColor;
  final bool isDisableNextButton;
  final bool isDisablePreviousButton;
  final Color disableColor;
  final String storyImageUrl;
  final int firstChapterId;
  final int lastChapterId;
  final int totalChapter;
  const BottomChapterDetail({
    super.key,
    required this.chapterId,
    required this.onLoading,
    required this.onRefresh,
    required this.backgroundColor,
    required this.fontColor,
    required this.isDisableNextButton,
    required this.isDisablePreviousButton,
    required this.disableColor,
    required this.title,
    required this.storyId,
    required this.storyImageUrl,
    required this.firstChapterId,
    required this.lastChapterId,
    required this.totalChapter,
    required this.callback,
    required this.author,
  });

  @override
  State<BottomChapterDetail> createState() => _BottomChapterDetailState();
}

class _BottomChapterDetailState extends State<BottomChapterDetail> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      padding: const EdgeInsets.only(bottom: 4.0),
      height:
          MainSetting.getPercentageOfDevice(context, expectHeight: 50).height,
      color: widget.backgroundColor,
      child: SizedBox(
        width: MediaQuery.of(context).size.width,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: !widget.isDisablePreviousButton
                  ? () => widget.onRefresh(widget.chapterId)
                  : null,
              icon: Icon(
                Icons.arrow_circle_left_outlined,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
                color: !widget.isDisablePreviousButton
                    ? widget.fontColor
                    : widget.disableColor,
              ),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: !widget.isDisableNextButton
                  ? () => widget.onLoading(widget.chapterId, false)
                  : null,
              icon: Icon(
                Icons.arrow_circle_right_outlined,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
                color: !widget.isDisableNextButton
                    ? themeMode(context, ColorCode.mainColor.name)
                    : widget.disableColor,
              ),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: () {},
              icon: Icon(Icons.favorite_outline,
                  size: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 30)
                      .width,
                  color: widget.fontColor),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              onPressed: () {
                widget.callback(true);
                Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (builder) => StoryAudio(
                              author: widget.author,
                              lastChapterId: widget.lastChapterId,
                              firstChapterId: widget.firstChapterId,
                              totalChapter: widget.totalChapter,
                              imageUrl: widget.storyImageUrl,
                              title: widget.title,
                              storyId: widget.storyId,
                              chapterId: widget.chapterId,
                            )));
              },
              icon: Icon(Icons.headphones_outlined,
                  size: MainSetting.getPercentageOfDevice(context,
                          expectWidth: 30)
                      .width,
                  color: widget.fontColor),
            ),
            IconButton(
              splashRadius:
                  MainSetting.getPercentageOfDevice(context, expectWidth: 25)
                      .width,
              color: widget.fontColor,
              onPressed: () => showModalBottomSheet(
                shape: const RoundedRectangleBorder(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20),
                  ),
                ),
                clipBehavior: Clip.antiAliasWithSaveLayer,
                context: context,
                builder: (BuildContext context) {
                  return const CustomDashboard();
                },
              ),
              icon: Icon(
                Icons.dashboard_customize_outlined,
                size:
                    MainSetting.getPercentageOfDevice(context, expectWidth: 30)
                        .width,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
