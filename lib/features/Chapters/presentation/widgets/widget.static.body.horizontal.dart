import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/bloc/split_chapter_bloc/page.control.chapter.split.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;
import 'package:muonroi/features/chapters/data/models/models.chapter.template.dart';

class ScreenHorizontalChapter extends StatefulWidget {
  final pull.RefreshController refreshController;
  final PageController pageController;
  final PageControlBloc controlBloc;
  final ChapterTemplate templateSetting;
  final bool isLoadedHistory;
  final TextStyle textStyle;
  final GlobalKey pageKey;
  final int storyId;
  final bool isDisplay;
  final Function() changeModeSystem;
  final Function(int, bool) onRefresh;
  final Function(bool) loadSavedScrollPosition;
  final Function(bool) saveScrollPosition;
  final Function(bool) displayAction;
  final Function(bool) isLoadedHistoryForOneChapter;
  final Function(int, bool, bool) onLoading;
  const ScreenHorizontalChapter(
      {super.key,
      required this.pageKey,
      required this.pageController,
      required this.controlBloc,
      required this.textStyle,
      required this.templateSetting,
      required this.loadSavedScrollPosition,
      required this.saveScrollPosition,
      required this.changeModeSystem,
      required this.onRefresh,
      required this.onLoading,
      required this.displayAction,
      required this.isLoadedHistoryForOneChapter,
      required this.refreshController,
      required this.storyId,
      required this.isDisplay,
      required this.isLoadedHistory});

  @override
  State<ScreenHorizontalChapter> createState() =>
      _ScreenHorizontalChapterState();
}

class _ScreenHorizontalChapterState extends State<ScreenHorizontalChapter> {
  @override
  void initState() {
    _isDisplay = widget.isDisplay;
    super.initState();
  }

  late bool _isDisplay;
  @override
  Widget build(BuildContext context) {
    return Container(
      color: widget.templateSetting.background,
      key: widget.pageKey,
      child: GestureDetector(
          onTapUp: (_) => widget.saveScrollPosition(true),
          onTapDown: (_) => widget.saveScrollPosition(true),
          onTapCancel: () => widget.saveScrollPosition(true),
          onTap: () {
            setState(() {
              _isDisplay = !_isDisplay;
              widget.displayAction(_isDisplay);
              widget.changeModeSystem();
            });
          },
          child: PageView.builder(
              scrollDirection: Axis.horizontal,
              physics: BouncingScrollPhysics(),
              controller: widget.pageController,
              onPageChanged: (val) {
                widget.controlBloc.changeState(val);
              },
              itemCount: widget.controlBloc.splittedTextList.length,
              itemBuilder: (context, index) {
                return Text(widget.controlBloc.splittedTextList[index],
                    style: widget.textStyle.copyWith(fontSize: 22));
              })),
    );
  }
}
