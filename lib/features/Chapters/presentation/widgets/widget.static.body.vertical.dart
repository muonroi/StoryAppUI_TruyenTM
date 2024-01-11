import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;
import 'package:muonroi/features/chapters/data/models/models.chapter.template.dart';

class ScreenVerticalChapter extends StatefulWidget {
  final ScrollController scrollChapterBodyController;
  final pull.RefreshController refreshController;
  final bool isLoadedHistory;
  final String content;
  final int storyId;
  final Function() changeModeSystem;
  final Function(int, bool) onRefresh;
  final Function(bool) loadSavedScrollPosition;
  final Function(bool) saveScrollPosition;
  final Function(bool) displayAction;
  final Function(bool) isLoadedHistoryForOneChapter;
  final Function(int, bool, bool) onLoading;
  final ChapterTemplate templateSetting;
  final bool isDisplay;
  final int chapterId;
  const ScreenVerticalChapter(
      {super.key,
      required this.scrollChapterBodyController,
      required this.isLoadedHistory,
      required this.content,
      required this.loadSavedScrollPosition,
      required this.isLoadedHistoryForOneChapter,
      required this.saveScrollPosition,
      required this.displayAction,
      required this.templateSetting,
      required this.isDisplay,
      required this.changeModeSystem,
      required this.refreshController,
      required this.storyId,
      required this.onRefresh,
      required this.onLoading,
      required this.chapterId});

  @override
  State<ScreenVerticalChapter> createState() => _ScreenVerticalChapter();
}

class _ScreenVerticalChapter extends State<ScreenVerticalChapter> {
  @override
  void initState() {
    _isDisplay = widget.isDisplay;
    super.initState();
  }

  late bool _isDisplay;
  @override
  Widget build(BuildContext context) {
    return pull.SmartRefresher(
      enablePullDown: true,
      physics: BouncingScrollPhysics(),
      enablePullUp: true,
      header: pull.ClassicHeader(
        releaseIcon: Icon(
          Icons.arrow_upward,
          color: themeMode(context, ColorCode.textColor.name),
        ),
        idleIcon: Icon(
          Icons.arrow_upward,
          color: themeMode(context, ColorCode.textColor.name),
        ),
        idleText: L(context, LanguageCodes.previousChapterTextInfo.toString()),
        refreshingText: L(context, LanguageCodes.loadingTextInfo.toString()),
        releaseText: L(context, LanguageCodes.loadingTextInfo.toString()),
      ),
      controller: widget.refreshController,
      onRefresh: () => widget.onRefresh(widget.chapterId, false),
      onLoading: () => widget.onLoading(widget.chapterId, false, false),
      footer: pull.ClassicFooter(
        canLoadingIcon: Icon(
          Icons.arrow_downward,
          color: themeMode(context, ColorCode.textColor.name),
        ),
        idleText: L(context, LanguageCodes.loadingMoreTextInfo.toString()),
        canLoadingText:
            L(context, LanguageCodes.nextChapterTextInfo.toString()),
      ),
      child: ListView.builder(
          controller: widget.scrollChapterBodyController,
          itemCount: 1,
          itemBuilder: (context, index) {
            if (widget.scrollChapterBodyController.hasClients &&
                widget.isLoadedHistory) {
              widget.loadSavedScrollPosition(false);
              widget.isLoadedHistoryForOneChapter(false);
            }
            return GestureDetector(
              onTapUp: (_) => widget.saveScrollPosition(false),
              onTapDown: (_) => widget.saveScrollPosition(false),
              onTapCancel: () => widget.saveScrollPosition(false),
              onTap: () {
                setState(() {
                  _isDisplay = !_isDisplay;
                  widget.displayAction(_isDisplay);
                  widget.changeModeSystem();
                });
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: Html(
                  data: widget.content
                      .replaceAll(RegExp(r'(?:Chương|chương)[^\n]*'), "")
                      .replaceAll("\n", "")
                      .trim(),
                  style: {
                    '#': Style(
                      margin: widget.isDisplay
                          ? Margins(top: Margin(0))
                          : Margins(top: Margin(40)),
                      textAlign: widget.templateSetting.isLeftAlign!
                          ? TextAlign.justify
                          : TextAlign.left,
                      fontFamily: widget.templateSetting.fontFamily,
                      fontSize: FontSize(widget.templateSetting.fontSize!),
                      color: widget.templateSetting.font,
                      backgroundColor: widget.templateSetting.background,
                    ),
                  },
                ),
              ),
            );
          }),
    );
  }
}
