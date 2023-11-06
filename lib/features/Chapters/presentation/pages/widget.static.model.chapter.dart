import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:muonroi/features/chapters/bloc/group_chapter/group_chapter_bloc.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.group.dart';
import 'package:muonroi/features/chapters/presentation/pages/widget.static.model.list.chapter.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.button.scroll.chapter.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.detail.chapter.bottom.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/features/story/data/models/enum/enum.story.user.dart';
import 'package:muonroi/features/story/data/repositories/story_repository.dart';
import 'package:muonroi/features/story/presentation/pages/widget.static.stories.detail.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chapter extends StatefulWidget {
  final bool loadSingleChapter;
  final int storyId;
  final String storyName;
  final int chapterId;
  final int lastChapterId;
  final int firstChapterId;
  final bool isLoadHistory;
  final int pageIndex;
  const Chapter(
      {super.key,
      required this.storyId,
      required this.storyName,
      required this.chapterId,
      required this.lastChapterId,
      required this.firstChapterId,
      required this.isLoadHistory,
      required this.loadSingleChapter,
      required this.pageIndex});

  @override
  State<Chapter> createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  @override
  void initState() {
    _pageIndex = widget.pageIndex;
    _chapterIndex = 0;
    _initSharedPreferences().then((value) async {
      _pageIndex = _sharedPreferences
                  .getInt("story-${widget.storyId}-current-page-index") ==
              null
          ? 1
          : _sharedPreferences
              .getInt("story-${widget.storyId}-current-page-index")!;
      _chapterIndex = _chapterIndex = _sharedPreferences
              .getInt("story-${widget.storyId}-current-chapter-index") ??
          0;
    });

    _isFirstRefresh = true;
    _chapterIdOld = 0;
    _chapterNumber = 0;
    _savedScrollPosition = 0.0;
    _isLoading = false;
    _isVisible = false;
    _isDisableNextButton = false;
    _isDisablePreviousButton = false;
    _pageSize = 99;
    _isShowDetailAppbar = false;
    _settingConfig = TemplateSetting();
    _scrollPositionKey = "scrollPosition-${widget.storyId}";
    _groupChaptersBloc = GroupChapterBloc(widget.storyId, _pageIndex, 100);
    _groupChaptersBloc.add(GroupChapter(widget.storyId, _pageIndex));
    super.initState();
    _scrollController = ScrollController();
    _refreshController = RefreshController(initialRefresh: false);
    _scrollController.addListener(_saveScrollPosition);
    _isVisible = false;
    _isLoad = true;
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    if (widget.firstChapterId == widget.chapterId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isDisablePreviousButton = true;
        });
      });
    } else if (!_isLoading) {
      _isLoading = true;
    }
    if (widget.lastChapterId == widget.chapterId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isDisableNextButton = true;
        });
      });
    } else if (!_isLoading) {
      _isLoading = true;
    }
  }

  @override
  void dispose() {
    _groupChaptersBloc.close();
    _scrollController.removeListener(_saveScrollPosition);
    _scrollController.dispose();
    _refreshController.dispose();
    _isLoad = false;
    super.dispose();
  }
// #region Methods

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _storyRepository = StoryRepository();
    await _storyRepository.createStoryForUser(
        widget.storyId, StoryForUserType.recent.index);
    if (context.mounted) {
      _settingConfig = getCurrentTemplate(_sharedPreferences, context);
    }
  }

  void _saveScrollPosition() {
    var groupData = _sharedPreferences
        .getString("story-${widget.storyId}-current-group-chapter");
    if (_groupChapterItems == null && groupData == null) {
      _sharedPreferences.setString(
          "story-${widget.storyId}-current-group-chapter",
          groupChaptersToJson(_groupChapterItems!));
    }
    _sharedPreferences.setDouble(_scrollPositionKey, _scrollController.offset);
    _sharedPreferences.setInt("story-${widget.storyId}", widget.storyId);
    _sharedPreferences.setInt(
        "story-${widget.storyId}-current-chapter-id", _chapterIdOld);
    _sharedPreferences.setInt(
        "story-${widget.storyId}-current-chapter", _chapterNumber);
    _sharedPreferences.setInt("story-${widget.storyId}-current-page-index",
        _pageIndex == 0 ? 1 : _pageIndex);
    _sharedPreferences.setInt(
        "story-${widget.storyId}-current-chapter-index", _chapterIndex);
  }

  void _loadSavedScrollPosition() async {
    if (_isLoad && widget.isLoadHistory && _isFirstRefresh) {
      SharedPreferences savedLocation = await SharedPreferences.getInstance();
      _savedScrollPosition = savedLocation.getDouble(_scrollPositionKey) ?? 0.0;
      _pageIndex = savedLocation
                  .getInt("story-${widget.storyId}-current-page-index") ==
              null
          ? 1
          : savedLocation.getInt("story-${widget.storyId}-current-page-index")!;

      if (_scrollController.hasClients) {
        setState(() {
          _chapterIndex = savedLocation
                  .getInt("story-${widget.storyId}-current-chapter-index") ??
              0;
          _scrollController.jumpTo(_savedScrollPosition);
          _isFirstRefresh = false;
        });
      }
    }
  }

  void _onRefresh(int chapterId) async {
    if (mounted && widget.firstChapterId != chapterId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isDisableNextButton = false;
          if (_pageIndex > 1 && _chapterIndex == 0) {
            _sharedPreferences
                .remove("story-${widget.storyId}-current-group-chapter");
            _pageIndex = --_pageIndex;
            _sharedPreferences.setInt(
                "story-${widget.storyId}-current-page-index",
                _pageIndex == 0 ? 1 : _pageIndex);
            _groupChaptersBloc.add(GroupChapter(widget.storyId, _pageIndex));
            _chapterIndex = _pageSize;
            _sharedPreferences.setInt(
                "story-${widget.storyId}-current-chapter-index", _chapterIndex);
          } else {
            _chapterIndex = _chapterIndex > 0 ? --_chapterIndex : 0;
            if (_pageIndex == 1 && _chapterIndex == 0) {
              _isDisablePreviousButton = true;
            }
          }
        });
      });
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    } else if (widget.firstChapterId == chapterId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isDisablePreviousButton = true;
        });
      });
    } else if (!_isLoading) {
      _isLoading = true;
    }
    _refreshController.refreshCompleted();
  }

  void _onLoading(int chapterId, bool isCheckShow) async {
    if (!isCheckShow) {
      _isLoading = true;
    }
    if (mounted && widget.lastChapterId != chapterId && _isLoading) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isDisablePreviousButton = false;
          _chapterIndex =
              _chapterIndex < _pageSize ? ++_chapterIndex : _pageSize + 1;
          if (_chapterIndex > _pageSize) {
            _sharedPreferences
                .remove("story-${widget.storyId}-current-group-chapter");
            _pageIndex = ++_pageIndex;
            _sharedPreferences.setInt(
                "story-${widget.storyId}-current-page-index",
                _pageIndex == 0 ? 1 : _pageIndex);
            _groupChaptersBloc.add(GroupChapter(widget.storyId, _pageIndex));
            _chapterIndex = 0;
          }
          _isLoading = false;
          if (_scrollController.hasClients) {
            _scrollController.jumpTo(0);
          }
        });
      });
    } else if (widget.lastChapterId == chapterId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isDisableNextButton = true;
        });
      });
    } else if (!_isLoading) {
      _isLoading = true;
    }
    _refreshController.loadComplete();
  }

  void _reNewValueInSettingTemplate(TemplateSetting newValue) {
    _settingConfig.backgroundColor =
        newValue.backgroundColor ?? _settingConfig.backgroundColor;
    _settingConfig.fontColor = newValue.fontColor == null
        ? _settingConfig.fontColor
        : newValue.backgroundColor;
    _settingConfig.fontSize = newValue.fontSize ?? _settingConfig.fontSize;
    _settingConfig.fontFamily =
        newValue.fontFamily ?? _settingConfig.fontFamily;
    _settingConfig.isLeftAlign =
        newValue.isLeftAlign ?? _settingConfig.isLeftAlign;
    _settingConfig.locationButton =
        newValue.locationButton ?? _settingConfig.locationButton;
    _settingConfig.isHorizontal =
        newValue.isHorizontal ?? _settingConfig.isHorizontal;
  }
// #endregion

// #region Variables
  late int _chapterIndex;
  late int _pageIndex;
  late int _pageSize;
  late bool _isLoad;
  late bool _isFirstRefresh;
  late int _chapterIdOld;
  late int _chapterNumber;
  late double _savedScrollPosition;
  late bool _isLoading;
  late bool _isVisible;
  late bool _isShowDetailAppbar;
  late bool _isDisableNextButton;
  late bool _isDisablePreviousButton;
  late GroupChapters? _groupChapterItems;
  late SharedPreferences _sharedPreferences;
  late GroupChapterBloc _groupChaptersBloc;
  late ScrollController _scrollController;
  late RefreshController _refreshController;
  late String _scrollPositionKey;
  late TemplateSetting _settingConfig;
  late StoryRepository _storyRepository;
  // #endregion

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
    return BlocProvider(
      create: (context) => _groupChaptersBloc,
      child: BlocListener<GroupChapterBloc, GroupChapterBlocState>(
          listener: (context, state) {
        const Center(
          child: CircularProgressIndicator(),
        );
      }, child: BlocBuilder<GroupChapterBloc, GroupChapterBlocState>(
        builder: (context, state) {
          if (state is GroupChapterNoDataState) {
            Center(
              child: Text(
                L(context, LanguageCodes.chapterEndTextInfo.toString()),
                style: CustomFonts.h4(context),
              ),
            );
          }
          if (state is GroupChapterLoadingState) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is GroupChapterLoadedState) {
            _loadSavedScrollPosition();
            _groupChapterItems = state.chapter;
            _settingConfig.backgroundColor = _settingConfig.backgroundColor ??
                themeMode(context, ColorCode.modeColor.name);
            _settingConfig.fontColor = _settingConfig.fontColor ??
                themeMode(context, ColorCode.textColor.name);
            _settingConfig.fontFamily =
                _settingConfig.fontFamily ?? CustomFonts.inter;
            _settingConfig.fontSize = _settingConfig.fontSize ?? 15;
            _settingConfig.isLeftAlign = _settingConfig.isLeftAlign ?? true;
            _settingConfig.locationButton =
                _settingConfig.locationButton ?? KeyChapterButtonScroll.none;
            _settingConfig.isHorizontal = _settingConfig.isHorizontal ?? false;
            var chapterInfo = state.chapter.result.items;
            _chapterIdOld = chapterInfo[_chapterIndex].id;
            _chapterNumber = chapterInfo[_chapterIndex].numberOfChapter;
            _pageSize =
                chapterInfo.length < _pageSize ? chapterInfo.length : _pageSize;
            return Consumer<TemplateSetting>(
              builder: (context, templateValue, child) {
                _reNewValueInSettingTemplate(templateValue);
                var tempBackground = templateValue.backgroundColor ??
                    _settingConfig.backgroundColor;
                var tempFontColor =
                    templateValue.fontColor ?? _settingConfig.fontColor;
                var tempFontFamily =
                    templateValue.fontFamily ?? _settingConfig.fontFamily;
                var tempFontSize =
                    templateValue.fontSize ?? _settingConfig.fontSize;
                var tempIsLeftAlign =
                    templateValue.isLeftAlign ?? _settingConfig.isLeftAlign;
                var tempLocationScrollButton = templateValue.locationButton ??
                    _settingConfig.locationButton;
                var tempIsHorizontal =
                    templateValue.isHorizontal ?? _settingConfig.isHorizontal;
                return Scaffold(
                  resizeToAvoidBottomInset: false,
                  appBar: _isVisible
                      ? AppBar(
                          automaticallyImplyLeading: false,
                          elevation: 0,
                          backgroundColor: tempBackground,
                          leading: IconButton(
                              splashRadius: 25,
                              color: tempFontColor,
                              onPressed: () {
                                Navigator.maybePop(context, true);
                              },
                              icon: Icon(
                                Icons.arrow_back_ios_sharp,
                                color: tempFontColor,
                              )),
                          actions: [
                            IconButton(
                              icon: Icon(
                                Icons.more_horiz,
                                color: tempFontColor,
                              ),
                              onPressed: () {
                                setState(() {
                                  _isShowDetailAppbar = !_isShowDetailAppbar;
                                });
                              },
                              splashRadius: 25,
                            )
                          ],
                          bottom: _isShowDetailAppbar
                              ? PreferredSize(
                                  preferredSize: const Size.fromHeight(80),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              InkWell(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            ChapterListPage(
                                                              storyId: chapterInfo[
                                                                      _chapterIndex]
                                                                  .storyId,
                                                              lastChapterId: widget
                                                                  .lastChapterId,
                                                              firstChapterId: widget
                                                                  .firstChapterId,
                                                              storyTitle: widget
                                                                  .storyName,
                                                            ))),
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding: EdgeInsets.only(
                                                          bottom: 4.0,
                                                          right: 4.0,
                                                          top: 4.0),
                                                      child: Icon(Icons.list),
                                                    ),
                                                    Text(
                                                      L(
                                                          context,
                                                          LanguageCodes
                                                              .listChapterDetailConfigTextInfo
                                                              .toString()),
                                                      style: CustomFonts.h6(
                                                          context),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              InkWell(
                                                onTap: () => Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            StoryDetail(
                                                              storyId: chapterInfo[
                                                                      _chapterIndex]
                                                                  .storyId,
                                                              storyTitle: widget
                                                                  .storyName,
                                                            ))),
                                                child: Row(
                                                  children: [
                                                    const Padding(
                                                      padding:
                                                          EdgeInsets.all(4.0),
                                                      child: Icon(Icons.book),
                                                    ),
                                                    Text(
                                                      L(
                                                          context,
                                                          LanguageCodes
                                                              .storyDetailConfigTextInfo
                                                              .toString()),
                                                      style: CustomFonts.h6(
                                                          context),
                                                    )
                                                  ],
                                                ),
                                              ),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(Icons.download),
                                                  ),
                                                  Text(
                                                    L(
                                                        context,
                                                        LanguageCodes
                                                            .storyDownloadConfigTextInfo
                                                            .toString()),
                                                    style:
                                                        CustomFonts.h6(context),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                        Container(
                                          margin: const EdgeInsets.symmetric(
                                              vertical: 8.0),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding: EdgeInsets.only(
                                                        bottom: 4.0,
                                                        right: 4.0,
                                                        top: 4.0),
                                                    child: Icon(
                                                        Icons.publish_sharp),
                                                  ),
                                                  Text(
                                                    L(
                                                        context,
                                                        LanguageCodes
                                                            .storyPushCoinConfigTextInfo
                                                            .toString()),
                                                    style:
                                                        CustomFonts.h6(context),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(Icons.share),
                                                  ),
                                                  Text(
                                                    L(
                                                        context,
                                                        LanguageCodes
                                                            .storyShareConfigTextInfo
                                                            .toString()),
                                                    style:
                                                        CustomFonts.h6(context),
                                                  )
                                                ],
                                              ),
                                              Row(
                                                children: [
                                                  const Padding(
                                                    padding:
                                                        EdgeInsets.all(4.0),
                                                    child: Icon(Icons.error),
                                                  ),
                                                  Text(
                                                    L(
                                                        context,
                                                        LanguageCodes
                                                            .storyReportConfigTextInfo
                                                            .toString()),
                                                    style:
                                                        CustomFonts.h6(context),
                                                  )
                                                ],
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  ))
                              : null,
                          title: GestureDetector(
                            onDoubleTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoryDetail(
                                            storyId: widget.storyId,
                                            storyTitle: widget.storyName,
                                          )));
                            },
                            child: Title(
                                color: tempFontColor!,
                                child: Text(
                                  widget.storyName,
                                  style: CustomFonts.h5(context).copyWith(
                                      fontFamily: tempFontFamily,
                                      color: tempFontColor),
                                )),
                          ),
                        )
                      : PreferredSize(
                          preferredSize: Size.zero, child: Container()),
                  backgroundColor: tempBackground,
                  body: GestureDetector(
                    onTap: () {
                      setState(() {
                        _isVisible = !_isVisible;
                        _isShowDetailAppbar = false;
                      });
                    },
                    child: SmartRefresher(
                      enablePullDown: true,
                      enablePullUp: true,
                      header: ClassicHeader(
                        idleIcon: Icon(
                          Icons.arrow_upward,
                          color: tempFontColor,
                        ),
                        idleText: L(context,
                            LanguageCodes.previousChapterTextInfo.toString()),
                        refreshingText: L(
                            context, LanguageCodes.loadingTextInfo.toString()),
                        releaseText: L(
                            context, LanguageCodes.loadingTextInfo.toString()),
                      ),
                      controller: _refreshController,
                      onRefresh: () =>
                          _onRefresh(chapterInfo[_chapterIndex].id),
                      onLoading: () =>
                          _onLoading(chapterInfo[_chapterIndex].id, true),
                      footer: ClassicFooter(
                        canLoadingIcon: Icon(
                          Icons.arrow_downward,
                          color: tempFontColor,
                        ),
                        idleText: L(context,
                            LanguageCodes.loadingMoreTextInfo.toString()),
                        canLoadingText: L(context,
                            LanguageCodes.nextChapterTextInfo.toString()),
                      ),
                      child: tempIsHorizontal!
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const PageScrollPhysics(),
                              controller: _scrollController,
                              itemCount:
                                  chapterInfo[_chapterIndex].bodyChunk.length,
                              itemBuilder: (context, index) {
                                var textString = convertTagHtmlFormatToString(
                                        chapterInfo[_chapterIndex]
                                            .bodyChunk[index])
                                    .trim();
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    index == 0
                                        ? Padding(
                                            padding: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Align(
                                              alignment: Alignment.center,
                                              child: SizedBox(
                                                width: MainSetting
                                                        .getPercentageOfDevice(
                                                            context,
                                                            expectWidth: 387)
                                                    .width,
                                                child: Row(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  children: [
                                                    SizedBox(
                                                      width: MainSetting
                                                              .getPercentageOfDevice(
                                                                  context,
                                                                  expectWidth:
                                                                      96.75)
                                                          .width,
                                                      child: Text(
                                                        "${L(context, LanguageCodes.chapterNumberTextInfo.toString())} ${chapterInfo[_chapterIndex].numberOfChapter}",
                                                        style: CustomFonts.h5(
                                                                context)
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    tempFontFamily,
                                                                color:
                                                                    tempFontColor),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .visible,
                                                        textAlign:
                                                            TextAlign.center,
                                                      ),
                                                    ),
                                                    SizedBox(
                                                      width: MainSetting
                                                              .getPercentageOfDevice(
                                                                  context,
                                                                  expectWidth:
                                                                      290.25)
                                                          .width,
                                                      child: Text(
                                                        chapterInfo[
                                                                _chapterIndex]
                                                            .chapterTitle
                                                            .replaceAll(
                                                                RegExp(
                                                                    r'Chương \d+:'),
                                                                '')
                                                            .replaceAll(
                                                                "\n", "")
                                                            .trim(),
                                                        style: CustomFonts.h5(
                                                                context)
                                                            .copyWith(
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w600,
                                                                fontFamily:
                                                                    tempFontFamily,
                                                                color:
                                                                    tempFontColor),
                                                        maxLines: 2,
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          )
                                        : Container(),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(12.0),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        child: AutoSizeText(
                                          textString,
                                          style: TextStyle(
                                            fontSize: tempFontSize! > 30
                                                ? 30
                                                : tempFontSize,
                                            fontFamily: tempFontFamily,
                                            color: tempFontColor,
                                            backgroundColor: tempBackground,
                                          ),
                                          textAlign: tempIsLeftAlign!
                                              ? TextAlign.justify
                                              : TextAlign.left,
                                        ),
                                      ),
                                    ),
                                  ],
                                );
                              })
                          : ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              controller: _scrollController,
                              itemCount: 1,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Align(
                                      alignment: Alignment.center,
                                      child: SizedBox(
                                        width:
                                            MainSetting.getPercentageOfDevice(
                                                    context,
                                                    expectWidth: 387)
                                                .width,
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            SizedBox(
                                              width: MainSetting
                                                      .getPercentageOfDevice(
                                                          context,
                                                          expectWidth: 96.75)
                                                  .width,
                                              child: Text(
                                                "${L(context, LanguageCodes.chapterNumberTextInfo.toString())} ${chapterInfo[_chapterIndex].numberOfChapter}",
                                                style: CustomFonts.h5(context)
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            tempFontFamily,
                                                        color: tempFontColor),
                                                maxLines: 2,
                                                overflow: TextOverflow.visible,
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                            SizedBox(
                                              width: MainSetting
                                                      .getPercentageOfDevice(
                                                          context,
                                                          expectWidth: 290.25)
                                                  .width,
                                              child: Text(
                                                chapterInfo[_chapterIndex]
                                                    .chapterTitle
                                                    .replaceAll(
                                                        RegExp(r'Chương \d+:'),
                                                        '')
                                                    .replaceAll("\n", "")
                                                    .trim(),
                                                style: CustomFonts.h5(context)
                                                    .copyWith(
                                                        fontWeight:
                                                            FontWeight.w600,
                                                        fontFamily:
                                                            tempFontFamily,
                                                        color: tempFontColor),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width: MediaQuery.of(context).size.width,
                                      child: Html(
                                        data: chapterInfo[_chapterIndex]
                                            .body
                                            .replaceAll("\n", "")
                                            .trim(),
                                        style: {
                                          '#': Style(
                                            textAlign: tempIsLeftAlign!
                                                ? TextAlign.justify
                                                : TextAlign.left,
                                            fontFamily: tempFontFamily,
                                            fontSize: FontSize(tempFontSize!),
                                            color: tempFontColor,
                                            backgroundColor: tempBackground,
                                          ),
                                        },
                                      ),
                                    ),
                                  ],
                                );
                              }),
                    ),
                  ),
                  floatingActionButton: ButtonChapterScroll(
                      tempLocationScrollButton: tempLocationScrollButton,
                      tempFontColor: tempFontColor!,
                      tempBackground: tempBackground!,
                      scrollController: _scrollController),
                  bottomNavigationBar: _isVisible
                      ? AnimatedContainer(
                          duration: const Duration(milliseconds: 300),
                          curve: Curves.linearToEaseOut,
                          child: BottomChapterDetail(
                              isDisablePreviousButton: _isDisablePreviousButton,
                              isDisableNextButton: _isDisableNextButton,
                              fontColor: tempFontColor,
                              backgroundColor: tempBackground,
                              chapterId: chapterInfo[_chapterIndex].id,
                              onRefresh: (int chapterId) =>
                                  _onRefresh(chapterInfo[_chapterIndex].id),
                              onLoading: (int chapterId, bool isCheckShow) =>
                                  _onLoading(
                                      chapterInfo[_chapterIndex].id, false)),
                        )
                      : null,
                );
              },
            );
          }
          return const Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }
}
