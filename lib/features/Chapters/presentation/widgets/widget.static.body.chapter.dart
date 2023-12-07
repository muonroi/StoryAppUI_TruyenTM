import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.group.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.list.paging.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.template.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.current.battery.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.current.time.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.body.title.chapter.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/features/story/data/models/model.recent.story.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
import 'package:muonroi/features/story/settings/enums/enum.story.user.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class ChapterBody extends StatefulWidget {
  final StreamController<Map<bool, int>> strActionChapterStreamController;
  final StreamController<ChapterTemplate> strChapterTemplate;
  final StreamController<bool> strUpdateDataChapterToList;
  final StreamController<bool> strHideActionBottomButton;
  final ScrollController scrollChapterBodyController;
  final GroupChapterItems chapterInfo;
  final ChapterTemplate chapterTemplate;
  final bool isLoadHistoryFunction;
  final bool isLoadedHistory;
  final int totalChapter;
  final int lastChapterId;
  final int firstChapterId;
  final int pageIndex;
  final int chapterIndex;
  final String authorName;
  final String storyTitle;
  final String imageUrl;
  final Function(bool) displayAction;
  final Function(bool) disablePreviousButton;
  final Function(bool) disableNextButton;
  final Function(bool) isLoadedHistoryForOneChapter;
  final Function(bool) resetCountTimeAds;
  final Function(int) putEvenToGroup;
  final Function(int) currentChapterIndex;
  final Function(int) currentPageIndex;
  const ChapterBody(
      {super.key,
      required this.chapterInfo,
      required this.displayAction,
      required this.pageIndex,
      required this.lastChapterId,
      required this.firstChapterId,
      required this.disablePreviousButton,
      required this.disableNextButton,
      required this.putEvenToGroup,
      required this.currentChapterIndex,
      required this.currentPageIndex,
      required this.strActionChapterStreamController,
      required this.isLoadHistoryFunction,
      required this.isLoadedHistoryForOneChapter,
      required this.isLoadedHistory,
      required this.strUpdateDataChapterToList,
      required this.chapterIndex,
      required this.chapterTemplate,
      required this.scrollChapterBodyController,
      required this.strChapterTemplate,
      required this.authorName,
      required this.storyTitle,
      required this.imageUrl,
      required this.totalChapter,
      required this.resetCountTimeAds,
      required this.strHideActionBottomButton});

  @override
  State<ChapterBody> createState() => _ChapterBodyState();
}

class _ChapterBodyState extends State<ChapterBody> with WidgetsBindingObserver {
// #region override function
  @override
  void initState() {
    _templateSetting = widget.chapterTemplate;
    _storyRepository = StoryRepository();
    _refreshController = RefreshController(initialRefresh: false);
    _groupChapterItems = null;
    _fromToChapterList = "";
    _isDisplay = false;
    _pageSize = 99;
    _pageIndex = widget.pageIndex;
    _chapterIndex = widget.chapterIndex;
    _savedScrollPosition = 0.0;
    super.initState();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
        overlays: SystemUiOverlay.values);
    if (widget.firstChapterId == widget.chapterInfo.id) {
      widget.disablePreviousButton(true);
    }
    if (widget.lastChapterId == widget.chapterInfo.id) {
      widget.disableNextButton(true);
    }
    _listenEvent();
    _scrollChapterBodyController = widget.scrollChapterBodyController;
    _initData();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initData();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.paused) {
      _saveScrollPosition();
      _saveRecentStory();
    } else if (state == AppLifecycleState.resumed) {
      _saveScrollPosition();
      _saveRecentStory();
    }
    super.didChangeAppLifecycleState(state);
  }

  @override
  void dispose() {
    widget.strActionChapterStreamController.close();
    widget.strChapterTemplate.close();
    widget.strHideActionBottomButton.close();
    widget.strUpdateDataChapterToList.close();
    _refreshController.dispose();
    _saveScrollPosition();
    _saveRecentStory();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant ChapterBody oldWidget) {
    super.didUpdateWidget(oldWidget);
    setState(() {
      _pageIndex = widget.pageIndex;
      _chapterIndex = widget.chapterIndex;
    });
  }
  // #endregion

// #region function

  Future _onRefresh(chapterId) async {
    if (widget.firstChapterId == chapterId) {
      widget.disablePreviousButton(true);
    } else if (mounted) {
      widget.disableNextButton(false);
      if (_pageIndex > 1 && _chapterIndex == 0) {
        await chapterBox.delete(
            "story-${widget.chapterInfo.storyId}-current-group-chapter");

        _pageIndex = --_pageIndex;

        chapterBox.put("story-${widget.chapterInfo.storyId}-current-page-index",
            _pageIndex == 0 ? 1 : _pageIndex);

        widget.putEvenToGroup(_pageIndex);

        _chapterIndex = _pageSize;

        chapterBox.put(
            "story-${widget.chapterInfo.storyId}-current-chapter-index",
            _chapterIndex);
        _updateChapterCurrentIntoChapterList();
        _chapterIndex = _pageSize;
      } else {
        _chapterIndex = _chapterIndex > 0 ? --_chapterIndex : 0;
        _updateChapterCurrentIntoChapterList();
        if (_pageIndex == 1 && _chapterIndex == 0) {
          widget.disablePreviousButton(true);
        }
      }
      _saveQuickChapterLocation();
    }
    if (_scrollChapterBodyController.hasClients) {
      _scrollChapterBodyController.jumpTo(0);
    }
    //Update page index and chapter index (index at list chunk 100 chapter)
    widget.currentChapterIndex(_chapterIndex);
    widget.currentPageIndex(_pageIndex);
    widget.resetCountTimeAds(true);
    _refreshController.refreshCompleted();
  }

  Future _onLoading(chapterId, useButtonNext) async {
    if (widget.lastChapterId == chapterId) {
      widget.disableNextButton(true);
    } else if (mounted && useButtonNext ||
        (_scrollChapterBodyController.offset >
            _scrollChapterBodyController.position.maxScrollExtent + 70)) {
      widget.disablePreviousButton(false);
      _chapterIndex = _chapterIndex < _pageSize
          ? ++_chapterIndex
          : _pageSize +
              1; // chapter index < pagesize (100) ? is up to chapter index else up to page index

      if (_chapterIndex > _pageSize) {
        //Each chunk (100 chapter) then save it to store, when reading it two times not call to api get chapter ==> performance
        await chapterBox.delete(
            "story-${widget.chapterInfo.storyId}-current-group-chapter");

        _pageIndex = ++_pageIndex;

        chapterBox.put("story-${widget.chapterInfo.storyId}-current-page-index",
            _pageIndex == 0 ? 1 : _pageIndex);

        widget.putEvenToGroup(_pageIndex);

        _chapterIndex = 0;

        _updateChapterCurrentIntoChapterList();
      } else {
        _scrollChapterBodyController.jumpTo(0);
        _updateChapterCurrentIntoChapterList();
      }
      _saveQuickChapterLocation();
    }
    //Update page index and chapter index (index at list chunk 100 chapter)
    widget.currentChapterIndex(_chapterIndex);
    widget.currentPageIndex(_pageIndex);
    widget.resetCountTimeAds(true);
    _refreshController.loadComplete();
  }

  Future _initData() async {
    _fromToChapterList = chapterBox
        .get("getGroupChaptersDataDetail-${widget.chapterInfo.storyId}")!;

    _pageIndex = chapterBox.get(
                "story-${widget.chapterInfo.storyId}-current-page-index") ==
            null
        ? 1
        : chapterBox
            .get("story-${widget.chapterInfo.storyId}-current-page-index")!;
    _chapterIndex = _chapterIndex = chapterBox
            .get("story-${widget.chapterInfo.storyId}-current-chapter-index") ??
        0;

    var groupData = chapterBox
        .get("story-${widget.chapterInfo.storyId}-current-group-chapter");

    if (groupData != null) {
      _groupChapterItems = groupChaptersFromJson(groupData);
    }
    if (_groupChapterItems != null &&
        _groupChapterItems!.result.items.isEmpty &&
        groupData == null) {
      chapterBox.put(
          "story-${widget.chapterInfo.storyId}-current-group-chapter",
          groupChaptersToJson(_groupChapterItems!));
    }

    _pageIndex = chapterBox.get(
                "story-${widget.chapterInfo.storyId}-current-page-index") ==
            null
        ? 1
        : chapterBox
            .get("story-${widget.chapterInfo.storyId}-current-page-index")!;
    _chapterIndex = _chapterIndex = chapterBox
            .get("story-${widget.chapterInfo.storyId}-current-chapter-index") ??
        0;
    await _saveRecentStory();
  }

  Future _saveRecentStory() async {
    await _storyRepository.createStoryForUser(
        widget.chapterInfo.storyId,
        StoryForUserType.recent.index,
        _chapterIndex,
        _pageIndex,
        widget.chapterInfo.numberOfChapter,
        0.0,
        widget.chapterInfo.id);
  }

  void _saveScrollPosition() {
    if (_scrollChapterBodyController.hasClients) {
      chapterBox.put("scrollPosition-${widget.chapterInfo.storyId}",
          _scrollChapterBodyController.offset);
      chapterBox.put(
          "story-${widget.chapterInfo.storyId}", widget.chapterInfo.storyId);
      chapterBox.put("story-${widget.chapterInfo.storyId}-current-chapter-id",
          widget.chapterInfo.id);
      chapterBox.put("story-${widget.chapterInfo.storyId}-current-chapter",
          widget.chapterInfo.numberOfChapter);
      chapterBox.put("story-${widget.chapterInfo.storyId}-current-page-index",
          _pageIndex == 0 ? 1 : _pageIndex);
      chapterBox.put(
          "story-${widget.chapterInfo.storyId}-current-chapter-index",
          _chapterIndex);
    }
    _saveQuickChapterLocation();
  }

  void _loadSavedScrollPosition() {
    if (widget.isLoadHistoryFunction) {
      _savedScrollPosition =
          chapterBox.get("scrollPosition-${widget.chapterInfo.storyId}") ?? 0.0;
      _pageIndex = chapterBox.get(
                  "story-${widget.chapterInfo.storyId}-current-page-index") ==
              null
          ? 1
          : chapterBox
              .get("story-${widget.chapterInfo.storyId}-current-page-index")!;

      if (_scrollChapterBodyController.hasClients) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _chapterIndex = chapterBox.get(
                    "story-${widget.chapterInfo.storyId}-current-chapter-index") ??
                0;
            _scrollChapterBodyController.jumpTo(_savedScrollPosition);
          });
        });
      }
    }
  }

  void _changeModeSystem() {
    if (!_isDisplay) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
          overlays: SystemUiOverlay.values);
    } else if (_isDisplay) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive,
          overlays: SystemUiOverlay.values);
    }
  }

  void _listenEvent() {
    widget.strActionChapterStreamController.stream.listen((data) {
      if (data.keys.first) {
        _onLoading(data.values.first, true);
      } else {
        _onRefresh(widget.chapterInfo.id);
      }
    });
    widget.strUpdateDataChapterToList.stream.listen((event) {
      _updateChapterCurrentIntoChapterList(event);
    });
    widget.strChapterTemplate.stream.listen((event) {
      setState(() {
        _templateSetting = event;
      });
    });
    widget.strHideActionBottomButton.stream.listen((event) {
      if (event) {
        setState(() {
          _isDisplay = !_isDisplay;
          widget.displayAction(_isDisplay);
        });
      }
    });
  }

  void _updateChapterCurrentIntoChapterList([bool isAudio = false]) {
    var fromToChapterInfo = listPagingChaptersFromJson(_fromToChapterList);
    if (isAudio) {
      chapterBox.put(
          "selected-chapter-chunk-${widget.chapterInfo.storyId}-$isAudio-page-index",
          0);
    }
    chapterBox.put("current-page-index", _pageIndex - 1);
    removeIndex(
        fromToChapterInfo.result.length, widget.chapterInfo.storyId, isAudio);
    chapterBox.put(
        "selected-chapter-${_pageIndex - 1}-${widget.chapterInfo.storyId}-$isAudio-item-index",
        _chapterIndex);

    chapterBox.put(
        "selected-chapter-${widget.chapterInfo.storyId}-$isAudio-from-chapter-id",
        fromToChapterInfo
            .result[_pageIndex > 0 ? _pageIndex - 1 : _pageIndex].fromId);

    chapterBox.put(
        "selected-chapter-${widget.chapterInfo.storyId}-$isAudio-to-chapter-id",
        fromToChapterInfo
            .result[_pageIndex > 0 ? _pageIndex - 1 : _pageIndex].toId);

    chapterBox.put(
        "selected-chapter-${widget.chapterInfo.storyId}-$isAudio-item-index",
        _chapterIndex);

    chapterBox.put(
        "selected-chapter-${widget.chapterInfo.storyId}-$isAudio-page-index-ui",
        _pageIndex - 1);
    chapterBox.put(
        "selected-chapter-${widget.chapterInfo.storyId}-$isAudio-page-index",
        _pageIndex);
  }

  void _saveQuickChapterLocation() {
    chapterBox.put(
        "recently-story",
        recentStoryModelToJson(StoryRecent(
            author: widget.authorName,
            imageStory: widget.imageUrl,
            storyId: widget.chapterInfo.storyId,
            storyName: widget.storyTitle,
            chapterId: widget.chapterInfo.id,
            lastChapterId: widget.lastChapterId,
            firstChapterId: widget.firstChapterId,
            isLoadHistory: widget.isLoadHistoryFunction,
            loadSingleChapter: false,
            pageIndex: _pageIndex,
            totalChapter: widget.totalChapter,
            chapterNumber: widget.chapterInfo.numberOfChapter)));
    chapterBox.put("recently-chapterId", widget.chapterInfo.id);
    chapterBox.put("is_saved_recent", true);
  }

// #endregion

// #region variable
  late GroupChapters? _groupChapterItems;
  late String _fromToChapterList;
  late RefreshController _refreshController;
  late StoryRepository _storyRepository;
  late bool _isDisplay;
  late int _pageIndex;
  late int _pageSize;
  late int _chapterIndex;
  late double _savedScrollPosition;
  late ChapterTemplate _templateSetting;
  late ScrollController _scrollChapterBodyController;

  // #endregion
  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      SmartRefresher(
        enablePullDown: true,
        enablePullUp: true,
        header: ClassicHeader(
          releaseIcon: Icon(
            Icons.arrow_upward,
            color: themeMode(context, ColorCode.textColor.name),
          ),
          idleIcon: Icon(
            Icons.arrow_upward,
            color: themeMode(context, ColorCode.textColor.name),
          ),
          idleText:
              L(context, LanguageCodes.previousChapterTextInfo.toString()),
          refreshingText: L(context, LanguageCodes.loadingTextInfo.toString()),
          releaseText: L(context, LanguageCodes.loadingTextInfo.toString()),
        ),
        controller: _refreshController,
        onRefresh: () => _onRefresh(widget.chapterInfo.storyId),
        onLoading: () => _onLoading(widget.chapterInfo.storyId, false),
        footer: ClassicFooter(
          canLoadingIcon: Icon(
            Icons.arrow_downward,
            color: themeMode(context, ColorCode.textColor.name),
          ),
          idleText: L(context, LanguageCodes.loadingMoreTextInfo.toString()),
          canLoadingText:
              L(context, LanguageCodes.nextChapterTextInfo.toString()),
        ),
        child: ListView.builder(
            physics: const BouncingScrollPhysics(),
            controller: _scrollChapterBodyController,
            itemCount: 1,
            itemBuilder: (context, index) {
              if (_scrollChapterBodyController.hasClients &&
                  widget.isLoadedHistory) {
                _loadSavedScrollPosition();
                widget.isLoadedHistoryForOneChapter(false);
              }
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTapUp: (_) => _saveScrollPosition(),
                    onTapDown: (_) => _saveScrollPosition(),
                    onTapCancel: () => _saveScrollPosition(),
                    onTap: () {
                      setState(() {
                        _isDisplay = !_isDisplay;
                        widget.displayAction(_isDisplay);
                        _changeModeSystem();
                      });
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: Html(
                        data: widget.chapterInfo.body
                            .replaceAll(RegExp(r'(?:Chương|chương)[^\n]*'), "")
                            .replaceAll("\n", "")
                            .trim(),
                        style: {
                          '#': Style(
                            textAlign: _templateSetting.isLeftAlign!
                                ? TextAlign.justify
                                : TextAlign.left,
                            fontFamily: _templateSetting.fontFamily,
                            fontSize: FontSize(_templateSetting.fontSize!),
                            color: _templateSetting.font,
                            backgroundColor: _templateSetting.background,
                          ),
                        },
                      ),
                    ),
                  ),
                ],
              );
            }),
      ),
      !_isDisplay
          ? Positioned(
              top: 0,
              right: 0,
              left: 0,
              child: Container(
                height:
                    MainSetting.getPercentageOfDevice(context, expectHeight: 35)
                        .height,
                color: _templateSetting.background,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ChapterTitleWidget(
                        chapterNumber: widget.chapterInfo.numberOfChapter,
                        chapterName: widget.chapterInfo.chapterTitle,
                        templateSetting: _templateSetting),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: UpdateCurrentTime(
                              tempColor: _templateSetting.font!,
                            )),
                        GetBatteryStatus(tempColor: _templateSetting.font!)
                      ],
                    ),
                  ],
                ),
              ),
            )
          : const SizedBox()
    ]);
  }
}
