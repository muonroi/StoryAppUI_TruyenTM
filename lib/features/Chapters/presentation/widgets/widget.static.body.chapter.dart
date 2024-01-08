import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/chapters/bloc/split_chapter_bloc/page.control.chapter.split.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.group.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.list.paging.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.template.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.body.horizontal.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.body.vertical.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.current.battery.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.current.time.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.body.title.chapter.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/features/story/data/models/model.recent.story.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
import 'package:muonroi/features/story/settings/enums/enum.story.user.dart';
import 'package:muonroi/features/story/settings/settings.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart' as pull;

class ChapterBody extends StatefulWidget {
  final StreamController<Map<bool, int>> strActionChapterStreamController;
  final StreamController<ChapterTemplate> strChapterTemplate;
  final StreamController<bool> strUpdateDataChapterToList;
  final StreamController<bool> strHideActionBottomButton;
  final StreamController<bool> strScrollHorizontal;
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
      required this.strHideActionBottomButton,
      required this.strScrollHorizontal});

  @override
  State<ChapterBody> createState() => _ChapterBodyState();
}

class _ChapterBodyState extends State<ChapterBody> with WidgetsBindingObserver {
// #region override function
  @override
  void initState() {
    _pageKey = GlobalKey();
    _pageController = PageController();
    _templateSetting = widget.chapterTemplate;
    _storyRepository = StoryRepository();
    _refreshHorizontalController =
        pull.RefreshController(initialRefresh: false);
    _refreshController = pull.RefreshController(initialRefresh: false);
    _groupChapterItems = null;
    _fromToChapterList = "";
    _isDisplay = false;
    _pageSize = 99;
    _pageIndex = widget.pageIndex;
    _chapterIndex = widget.chapterIndex;
    _savedScrollPosition = 0.0;
    _pageController = PageController();
    super.initState();
    _controlBloc = BlocProvider.of<PageControlBloc>(context);
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controlBloc.getSizeFromBloc(_pageKey);
      _controlBloc.setContentFromBloc(parseHtmlString(widget.chapterInfo.body));
      _controlBloc.getSplittedTextFromBloc(TextStyle(
        fontFamily: _templateSetting.fontFamily,
        color: _templateSetting.font,
        fontSize: _templateSetting.fontSize,
      ));
      setState(() {});
    });
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
      _saveScrollPosition(_templateSetting.isHorizontal ?? false);
      _saveRecentStory();
    } else if (state == AppLifecycleState.resumed) {
      _saveScrollPosition(_templateSetting.isHorizontal ?? false);
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
    _saveScrollPosition(_templateSetting.isHorizontal ?? false);
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

  Future _onRefresh(chapterId, isHorizontal) async {
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
        widget.currentChapterIndex(_chapterIndex);
        widget.currentPageIndex(_pageIndex);
      } else {
        _chapterIndex = _chapterIndex > 0 ? --_chapterIndex : 0;
        if (!isHorizontal
            ? _scrollChapterBodyController.hasClients
            : _pageController.hasClients) {
          widget.currentChapterIndex(_chapterIndex);
          widget.currentPageIndex(_pageIndex);
          !isHorizontal
              ? _scrollChapterBodyController.jumpTo(0)
              : _pageController.jumpTo(0);
        }
        if (_pageIndex == 1 && _chapterIndex == 0) {
          widget.disablePreviousButton(true);
        }
        _updateChapterCurrentIntoChapterList();
      }
      _saveQuickChapterLocation();
    }

    //Update page index and chapter index (index at list chunk 100 chapter)
    widget.resetCountTimeAds(true);
    !isHorizontal
        ? _refreshController.refreshCompleted()
        : _refreshHorizontalController.refreshCompleted();
  }

  Future _onLoading(chapterId, useButtonNext, isHorizontal) async {
    if (widget.lastChapterId == chapterId) {
      widget.disableNextButton(true);
    } else if (mounted && useButtonNext ||
        (!isHorizontal
            ? (_scrollChapterBodyController.offset >
                _scrollChapterBodyController.position.maxScrollExtent + 70)
            : (_pageController.offset >
                _pageController.position.maxScrollExtent + 70))) {
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
        widget.currentChapterIndex(_chapterIndex);
        widget.currentPageIndex(_pageIndex);
      } else {
        widget.currentChapterIndex(_chapterIndex);
        widget.currentPageIndex(_pageIndex);
        !isHorizontal
            ? _scrollChapterBodyController.jumpTo(0)
            : _pageController.jumpTo(0);
        _updateChapterCurrentIntoChapterList();
      }
      _saveQuickChapterLocation();
    }
    //Update page index and chapter index (index at list chunk 100 chapter)
    !isHorizontal
        ? _refreshController.loadComplete()
        : _refreshHorizontalController.loadComplete();
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

  void _saveScrollPosition(isHorizontal) {
    if (!isHorizontal
        ? _scrollChapterBodyController.hasClients
        : _pageController.hasClients) {
      chapterBox.put(
          "scrollPosition-${widget.chapterInfo.storyId}-$isHorizontal",
          !isHorizontal
              ? _scrollChapterBodyController.offset
              : _pageController.offset);
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

  void _loadSavedScrollPosition(isHorizontal) {
    if (widget.isLoadHistoryFunction) {
      _savedScrollPosition = chapterBox.get(
              "scrollPosition-${widget.chapterInfo.storyId}-$isHorizontal") ??
          0.0;
      _pageIndex = chapterBox.get(
                  "story-${widget.chapterInfo.storyId}-current-page-index") ==
              null
          ? 1
          : chapterBox
              .get("story-${widget.chapterInfo.storyId}-current-page-index")!;

      if (!isHorizontal
          ? _scrollChapterBodyController.hasClients
          : _pageController.hasClients) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _chapterIndex = chapterBox.get(
                    "story-${widget.chapterInfo.storyId}-current-chapter-index") ??
                0;
            !isHorizontal
                ? _scrollChapterBodyController.jumpTo(_savedScrollPosition)
                : _pageController.jumpTo(_savedScrollPosition);
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
        _onLoading(
            data.values.first, true, _templateSetting.isHorizontal ?? false);
      } else {
        _onRefresh(
            widget.chapterInfo.id, _templateSetting.isHorizontal ?? false);
      }
    });
    widget.strUpdateDataChapterToList.stream.listen((event) {
      _updateChapterCurrentIntoChapterList(event);
    });
    widget.strChapterTemplate.stream.listen((event) {
      setState(() {
        _templateSetting = event;
        _controlBloc.getSizeFromBloc(_pageKey);
        _controlBloc
            .setContentFromBloc(parseHtmlString(widget.chapterInfo.body));
        _controlBloc.getSplittedTextFromBloc(TextStyle(
          fontFamily: _templateSetting.fontFamily,
          color: _templateSetting.font,
          fontSize: _templateSetting.fontSize,
        ));
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
    if (!widget.strScrollHorizontal.hasListener) {
      widget.strScrollHorizontal.stream.listen((event) {
        if (event) {
          _pageController.addListener(_onListenHorizontalScreen);
        } else {
          _pageController.removeListener(_onListenHorizontalScreen);
        }
      });
    }
  }

  void _onListenHorizontalScreen() {
    if (_pageController.offset <
        _pageController.position.minScrollExtent - 100) {
      _isDisplay = !_isDisplay;
      _onRefresh(widget.chapterInfo.id, true);
    }
    if (_pageController.offset >
        _pageController.position.maxScrollExtent + 100) {
      _isDisplay = !_isDisplay;
      _onLoading(widget.chapterInfo.id, false, true);
    }
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

  void _disPlayAction(value) {
    widget.displayAction(value);
    setState(() {
      _isDisplay = value;
    });
  }
// #endregion

// #region variable
  late GroupChapters? _groupChapterItems;
  late String _fromToChapterList;
  late pull.RefreshController _refreshController;
  late pull.RefreshController _refreshHorizontalController;
  late StoryRepository _storyRepository;
  late bool _isDisplay;
  late int _pageIndex;
  late int _pageSize;
  late int _chapterIndex;
  late double _savedScrollPosition;
  late ChapterTemplate _templateSetting;
  late ScrollController _scrollChapterBodyController;
  late GlobalKey _pageKey;
  late PageControlBloc _controlBloc;
  late PageController _pageController;
  // #endregion

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      (_templateSetting.isHorizontal ?? false)
          ? ScreenHorizontalChapter(
              storyId: widget.chapterInfo.storyId,
              refreshController: _refreshHorizontalController,
              isLoadedHistory: widget.isLoadedHistory,
              isLoadedHistoryForOneChapter: widget.isLoadedHistoryForOneChapter,
              templateSetting: _templateSetting,
              pageKey: _pageKey,
              pageController: _pageController,
              controlBloc: _controlBloc,
              isDisplay: _isDisplay,
              textStyle: TextStyle(
                fontFamily: _templateSetting.fontFamily,
                color: _templateSetting.font,
                fontSize: _templateSetting.fontSize,
              ),
              displayAction: _disPlayAction,
              loadSavedScrollPosition: _loadSavedScrollPosition,
              saveScrollPosition: _saveScrollPosition,
              changeModeSystem: _changeModeSystem,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
            )
          : ScreenVerticalChapter(
              storyId: widget.chapterInfo.storyId,
              refreshController: _refreshController,
              scrollChapterBodyController: _scrollChapterBodyController,
              isLoadedHistory: widget.isLoadedHistory,
              content: widget.chapterInfo.body,
              isLoadedHistoryForOneChapter: widget.isLoadedHistoryForOneChapter,
              displayAction: _disPlayAction,
              templateSetting: _templateSetting,
              isDisplay: _isDisplay,
              onRefresh: _onRefresh,
              onLoading: _onLoading,
              saveScrollPosition: _saveScrollPosition,
              loadSavedScrollPosition: _loadSavedScrollPosition,
              changeModeSystem: _changeModeSystem),
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
