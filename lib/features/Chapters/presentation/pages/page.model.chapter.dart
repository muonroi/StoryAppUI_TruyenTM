import 'dart:async';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muonroi/core/advertising/ads.admob.service.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/chapters/bloc/group_chapter/group_chapter_bloc.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.group.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.list.paging.dart';
import 'package:muonroi/features/chapters/presentation/pages/page.model.list.chapter.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.button.scroll.chapter.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.count.time.ads.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.current.battery.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.current.time.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.detail.chapter.bottom.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/features/story/settings/enums/enum.story.user.dart';
import 'package:muonroi/features/story/data/models/model.recent.story.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
import 'package:muonroi/features/story/presentation/pages/page.stories.detail.dart';
import 'package:muonroi/features/story/presentation/pages/page.stories.download.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chapter extends StatefulWidget {
  // #region Constructor
  final bool loadSingleChapter;
  final int storyId;
  final String storyName;
  final int chapterId;
  final int lastChapterId;
  final int firstChapterId;
  final bool isLoadHistory;
  final int pageIndex;
  final int totalChapter;
  final int chapterNumber;
  final String imageUrl;
  const Chapter(
      {super.key,
      required this.storyId,
      required this.storyName,
      required this.chapterId,
      required this.lastChapterId,
      required this.firstChapterId,
      required this.isLoadHistory,
      required this.loadSingleChapter,
      required this.pageIndex,
      required this.totalChapter,
      required this.chapterNumber,
      required this.imageUrl});
  // #endregion

  @override
  State<Chapter> createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> with WidgetsBindingObserver {
  @override
  void initState() {
    _fromToChapterList = "";
    _groupChapterItems = null;
    _second = 5;
    _isCountComplete = false;
    _userInfo = '';
    _isSubscription = false;
    _heightBottomContainer = 75.2;
    _heightAdsContainer = 49;
    _isContainerVisible = false;
    _isLookNextChapter = true;
    _maxScrollOffset = 0;
    _chapterName = "";
    _pageIndex = widget.pageIndex;
    _chapterIndex = 0;
    _initSharedPreferences();
    _bannerIsLoaded = false;
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
    _scrollAdsController = ScrollController(initialScrollOffset: 75.2);
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
      _isLoading = false;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _initSharedPreferences();
    final adState = Provider.of<AdMobService>(context);
    adState.initializations.then((status) {
      setState(() {
        _createBannerAds(adState);
        _bannerIsLoaded = true;
      });
    });
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
    _scrollController.removeListener(_saveScrollPosition);
    _groupChaptersBloc.close();
    _scrollController.dispose();
    _refreshController.dispose();
    _isLoad = false;
    _saveScrollPosition();
    _saveRecentStory();
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

// #region Methods

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _fromToChapterList = _sharedPreferences
        .getString("getGroupChaptersDataDetail-${widget.storyId}")!;
    _pageIndex = _sharedPreferences
                .getInt("story-${widget.storyId}-current-page-index") ==
            null
        ? 1
        : _sharedPreferences
            .getInt("story-${widget.storyId}-current-page-index")!;
    _chapterIndex = _chapterIndex = _sharedPreferences
            .getInt("story-${widget.storyId}-current-chapter-index") ??
        0;
    _storyRepository = StoryRepository();
    if (context.mounted) {
      _settingConfig = getCurrentTemplate(_sharedPreferences, context);
    }
    var groupData = _sharedPreferences
        .getString("story-${widget.storyId}-current-group-chapter");
    if (groupData != null) {
      _groupChapterItems = groupChaptersFromJson(groupData);
    }
    if (_groupChapterItems != null &&
        _groupChapterItems!.result.items.isEmpty &&
        groupData == null) {
      _sharedPreferences.setString(
          "story-${widget.storyId}-current-group-chapter",
          groupChaptersToJson(_groupChapterItems!));
    }

    _pageIndex = _sharedPreferences
                .getInt("story-${widget.storyId}-current-page-index") ==
            null
        ? 1
        : _sharedPreferences
            .getInt("story-${widget.storyId}-current-page-index")!;
    _chapterIndex = _chapterIndex = _sharedPreferences
            .getInt("story-${widget.storyId}-current-chapter-index") ??
        0;
    await _saveRecentStory();
  }

  Future<void> _saveRecentStory() async {
    var chapterId = _chapterIdOld == 0 ? widget.chapterId : _chapterIdOld;
    await _storyRepository.createStoryForUser(
        widget.storyId,
        StoryForUserType.recent.index,
        _chapterIndex,
        _pageIndex,
        widget.chapterNumber,
        0.0,
        chapterId);
  }

  void _createBannerAds(adState) {
    _bannerAd = BannerAd(
        adUnitId: adState.bannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: adState.adListener)
      ..load();
  }

  void _saveScrollPosition() {
    if (_scrollAdsController.hasClients) {
      if (_isFirstRefresh) {
        _maxScrollOffset = _scrollController.position.maxScrollExtent;
      }
      _sharedPreferences.setDouble(
          _scrollPositionKey, _scrollController.offset);
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

    _saveQuickChapterLocation();
  }

  void _loadSavedScrollPosition() async {
    SharedPreferences savedLocation = await SharedPreferences.getInstance();
    _userInfo = _sharedPreferences.getString('userLogin')!;
    if (_isLoad && widget.isLoadHistory && _isFirstRefresh) {
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
    var result = accountSignInFromJson(_userInfo);
    setState(() {
      _isSubscription = result.result!.isSubScription;
    });
  }

  void _onRefresh(int chapterId) async {
    if (widget.firstChapterId == chapterId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isDisablePreviousButton = true;
        });
      });
    } else if (mounted && widget.firstChapterId != chapterId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isVisible = false;
          _isCountComplete = false;
          _second = 1;
          _heightBottomContainer = 75.2;
          _heightAdsContainer = 49;
          _bannerAd!.load();
          _bannerIsLoaded = true;
          _isContainerVisible = false;
          _isLoading = false;
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
            _updateChapterCurrentIntoChapterList();
          } else {
            _chapterIndex = _chapterIndex > 0 ? --_chapterIndex : 0;
            _updateChapterCurrentIntoChapterList();
            if (_pageIndex == 1 && _chapterIndex == 0) {
              _isDisablePreviousButton = true;
            }
          }
          _chapterNumber--;
          _saveQuickChapterLocation();
        });
      });
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(0);
      }
    }
    _saveScrollPosition();
    _refreshController.refreshCompleted();
  }

  void _onLoading(int chapterId, bool isCheckShow) async {
    _isLoading = false;
    if (!isCheckShow) {
      _isLoading = true;
    }
    if (widget.lastChapterId == chapterId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isDisableNextButton = true;
        });
      });
    } else if (mounted && _isLoading ||
        widget.lastChapterId != chapterId &&
            _scrollController.offset > _maxScrollOffset + 30 &&
            !_isLookNextChapter) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _isVisible = false;
          _isCountComplete = false;
          _second = 1;
          _heightBottomContainer = 75.2;
          _heightAdsContainer = 49;
          _bannerAd!.load();
          _bannerIsLoaded = true;
          _isContainerVisible = false;
          _isLookNextChapter = true;
          _isLoading = false;
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
            _updateChapterCurrentIntoChapterList();
          } else {
            _updateChapterCurrentIntoChapterList();
            _scrollController.jumpTo(0);
          }
        });
        _chapterNumber++;
        _saveQuickChapterLocation();
      });
    } else if (!_isLoading) {
      _isLoading = true;
    }
    if (_isLookNextChapter) {
      _isLookNextChapter = false;
    }

    _saveScrollPosition();
    _refreshController.loadComplete();
  }

  void _updateChapterCurrentIntoChapterList([bool isAudio = false]) {
    var fromToChapterInfo = listPagingChaptersFromJson(_fromToChapterList);
    if (isAudio) {
      _sharedPreferences.setInt(
          "selected-chapter-chunk-${widget.storyId}-$isAudio-page-index", 0);
    }
    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-$isAudio-from-chapter-id",
        fromToChapterInfo
            .result[_pageIndex > 0 ? _pageIndex - 1 : _pageIndex].fromId);
    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-$isAudio-to-chapter-id",
        fromToChapterInfo
            .result[_pageIndex > 0 ? _pageIndex - 1 : _pageIndex].toId);

    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-$isAudio-item-index",
        _chapterIndex);

    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-$isAudio-page-index-ui",
        _pageIndex - 1);
    _sharedPreferences.setInt(
        "selected-chapter-${widget.storyId}-$isAudio-page-index", _pageIndex);
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

  void _setIsCountCompleteValue() {
    setState(() {
      _isCountComplete = true;
    });
  }

  void _saveQuickChapterLocation() {
    _sharedPreferences.setString(
        "recently-story",
        recentStoryModelToJson(StoryRecent(
            imageStory: widget.imageUrl,
            storyId: widget.storyId,
            storyName: widget.storyName,
            chapterId: _chapterIdOld,
            lastChapterId: widget.lastChapterId,
            firstChapterId: widget.firstChapterId,
            isLoadHistory: widget.isLoadHistory,
            loadSingleChapter: widget.loadSingleChapter,
            pageIndex: _pageIndex,
            totalChapter: widget.totalChapter,
            chapterNumber: _chapterNumber)));
    _sharedPreferences.setInt("recently-chapterId", _chapterIdOld);
    _sharedPreferences.setBool("is_saved_recent", true);
  }
// #endregion

// #region Variables
  late String _fromToChapterList;
  late int _second;
  late String _userInfo;
  late bool _isSubscription;
  late double _heightAdsContainer;
  late double _heightBottomContainer;
  late bool _isContainerVisible;
  late bool _bannerIsLoaded;
  late BannerAd? _bannerAd;
  late double _maxScrollOffset;
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
  late String _chapterName;
  late bool _isLookNextChapter;
  late ScrollController _scrollAdsController;
  late bool _isCountComplete;
  // #endregion

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky,
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
            // #region Setting template
            _loadSavedScrollPosition();
            _groupChapterItems = state.chapter;
            _settingConfig.backgroundColor = _settingConfig.backgroundColor ??
                themeMode(context, ColorCode.modeColor.name);
            _settingConfig.fontColor = _settingConfig.fontColor ??
                themeMode(context, ColorCode.textColor.name);
            _settingConfig.fontFamily =
                _settingConfig.fontFamily ?? CustomFonts.inter;
            _settingConfig.disableColor = _settingConfig.disableColor ??
                const Color.fromARGB(255, 179, 178, 178);
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
            _chapterName =
                "${L(context, LanguageCodes.chapterNumberTextInfo.toString())}: ${chapterInfo[_chapterIndex].numberOfChapter} - ${chapterInfo[_chapterIndex].chapterTitle} ";
            // #endregion
            return Consumer<TemplateSetting>(
              builder: (context, templateValue, child) {
                // #region Setting old template
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
                // #endregion
                return Scaffold(
                    // #region Appbar and menu
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
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              ChapterListPage(
                                                                chapterCallback:
                                                                    null,
                                                                isAudio: false,
                                                                storyImageUrl:
                                                                    widget
                                                                        .imageUrl,
                                                                totalChapter: widget
                                                                    .totalChapter,
                                                                storyId: chapterInfo[
                                                                        _chapterIndex]
                                                                    .storyId,
                                                                lastChapterId:
                                                                    widget
                                                                        .lastChapterId,
                                                                firstChapterId:
                                                                    widget
                                                                        .firstChapterId,
                                                                storyTitle: widget
                                                                    .storyName,
                                                              ))),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(
                                                                bottom: 4.0,
                                                                right: 4.0,
                                                                top: 4.0),
                                                        child: Icon(
                                                          Icons.list,
                                                          color: tempFontColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        L(
                                                            context,
                                                            LanguageCodes
                                                                .listChapterDetailConfigTextInfo
                                                                .toString()),
                                                        style: CustomFonts.h6(
                                                                context)
                                                            .copyWith(
                                                                color:
                                                                    tempFontColor),
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
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Icon(
                                                          Icons.book,
                                                          color: tempFontColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        L(
                                                            context,
                                                            LanguageCodes
                                                                .storyDetailConfigTextInfo
                                                                .toString()),
                                                        style: CustomFonts.h6(
                                                                context)
                                                            .copyWith(
                                                                color:
                                                                    tempFontColor),
                                                      )
                                                    ],
                                                  ),
                                                ),
                                                InkWell(
                                                  onTap: () => Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              StoriesDownloadPage(
                                                                storyId: chapterInfo[
                                                                        _chapterIndex]
                                                                    .storyId,
                                                                storyName: widget
                                                                    .storyName,
                                                                totalChapter: widget
                                                                    .totalChapter,
                                                              ))),
                                                  child: Row(
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(4.0),
                                                        child: Icon(
                                                          Icons.download,
                                                          color: tempFontColor,
                                                        ),
                                                      ),
                                                      Text(
                                                        L(
                                                            context,
                                                            LanguageCodes
                                                                .storyDownloadConfigTextInfo
                                                                .toString()),
                                                        style: CustomFonts.h6(
                                                                context)
                                                            .copyWith(
                                                                color:
                                                                    tempFontColor),
                                                      )
                                                    ],
                                                  ),
                                                )
                                              ],
                                            ),
                                          ),
                                          Container(
                                            margin: const EdgeInsets.symmetric(
                                                vertical: 8.0),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              bottom: 4.0,
                                                              right: 4.0,
                                                              top: 4.0),
                                                      child: Icon(
                                                          Icons.publish_sharp,
                                                          color: tempFontColor),
                                                    ),
                                                    Text(
                                                      L(
                                                          context,
                                                          LanguageCodes
                                                              .storyPushCoinConfigTextInfo
                                                              .toString()),
                                                      style: CustomFonts.h6(
                                                              context)
                                                          .copyWith(
                                                              color:
                                                                  tempFontColor),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Icon(Icons.share,
                                                          color: tempFontColor),
                                                    ),
                                                    Text(
                                                      L(
                                                          context,
                                                          LanguageCodes
                                                              .storyShareConfigTextInfo
                                                              .toString()),
                                                      style: CustomFonts.h6(
                                                              context)
                                                          .copyWith(
                                                              color:
                                                                  tempFontColor),
                                                    )
                                                  ],
                                                ),
                                                Row(
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.all(
                                                              4.0),
                                                      child: Icon(Icons.error,
                                                          color: tempFontColor),
                                                    ),
                                                    Text(
                                                      L(
                                                          context,
                                                          LanguageCodes
                                                              .storyReportConfigTextInfo
                                                              .toString()),
                                                      style: CustomFonts.h6(
                                                              context)
                                                          .copyWith(
                                                              color:
                                                                  tempFontColor),
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
                            title: Stack(children: [
                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(vertical: 8.0),
                                child: Title(
                                    color: tempFontColor!,
                                    child: Text(
                                      widget.storyName,
                                      style: CustomFonts.h5(context).copyWith(
                                          fontFamily: tempFontFamily,
                                          color: tempFontColor,
                                          fontSize: 14),
                                    )),
                              ),
                              showToolTip(_chapterName.isEmpty
                                  ? widget.storyName
                                  : _chapterName
                                      .replaceAll(RegExp(r'Chương \d+:'), '')
                                      .replaceAll("\n", "")
                                      .trim())
                            ]),
                          )
                        : PreferredSize(
                            preferredSize: Size.zero, child: Container()),
                    // #endregion
                    backgroundColor: tempBackground,
                    body: GestureDetector(
                      onTapDown: (_) => _saveScrollPosition(),
                      onTapUp: (_) => _saveScrollPosition(),
                      onTapCancel: () => _saveScrollPosition(),
                      onTap: () {
                        _saveScrollPosition();
                        setState(() {
                          if (!_isCountComplete) {
                            _isCountComplete = _isSubscription;
                          }
                          if (_isCountComplete) {
                            _isVisible = !_isVisible;
                            if (_isVisible == false) {
                              _heightBottomContainer =
                                  MainSetting.getPercentageOfDevice(context,
                                          expectHeight: 26.0)
                                      .height!;
                              _heightAdsContainer =
                                  MainSetting.getPercentageOfDevice(context,
                                          expectHeight: 0.0)
                                      .height!;
                            } else {
                              _heightBottomContainer =
                                  MainSetting.getPercentageOfDevice(context,
                                          expectHeight: 75.2)
                                      .height!;
                              _heightAdsContainer =
                                  MainSetting.getPercentageOfDevice(context,
                                          expectHeight: 49)
                                      .height!;
                            }
                            if (!_isContainerVisible && _isVisible == false) {
                              _heightBottomContainer =
                                  MainSetting.getPercentageOfDevice(context,
                                          expectHeight: 75.2)
                                      .height!;
                              _heightAdsContainer =
                                  MainSetting.getPercentageOfDevice(context,
                                          expectHeight: 49)
                                      .height!;
                            }

                            _isShowDetailAppbar = false;
                          }
                        });
                      },
                      child: Stack(children: [
                        tempIsHorizontal!
                            ?
                            // #region Horizontal
                            SmartRefresher(
                                enablePullDown: true,
                                enablePullUp: true,
                                header: ClassicHeader(
                                  releaseIcon: Icon(
                                    Icons.arrow_upward,
                                    color: tempFontColor,
                                  ),
                                  idleIcon: Icon(
                                    Icons.arrow_upward,
                                    color: tempFontColor,
                                  ),
                                  idleText: L(
                                      context,
                                      LanguageCodes.previousChapterTextInfo
                                          .toString()),
                                  refreshingText: L(context,
                                      LanguageCodes.loadingTextInfo.toString()),
                                  releaseText: L(context,
                                      LanguageCodes.loadingTextInfo.toString()),
                                ),
                                controller: _refreshController,
                                onRefresh: () =>
                                    _onRefresh(chapterInfo[_chapterIndex].id),
                                onLoading: () => _onLoading(
                                    chapterInfo[_chapterIndex].id, true),
                                footer: ClassicFooter(
                                  canLoadingIcon: Icon(
                                    Icons.arrow_downward,
                                    color: tempFontColor,
                                  ),
                                  idleText: L(
                                      context,
                                      LanguageCodes.loadingMoreTextInfo
                                          .toString()),
                                  canLoadingText: L(
                                      context,
                                      LanguageCodes.nextChapterTextInfo
                                          .toString()),
                                ),
                                child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    physics: const PageScrollPhysics(),
                                    controller: _scrollController,
                                    itemCount: chapterInfo[_chapterIndex]
                                        .bodyChunk
                                        .length,
                                    itemBuilder: (context, index) {
                                      var textString =
                                          convertTagHtmlFormatToString(
                                        chapterInfo[_chapterIndex]
                                            .bodyChunk[index],
                                      )
                                              .replaceAll(
                                                  RegExp(
                                                      r'(?:Chương|chương)[^\n]*'),
                                                  "")
                                              .replaceAll("\n", "")
                                              .trim();
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Expanded(
                                            child: Container(
                                              padding:
                                                  const EdgeInsets.all(12.0),
                                              width: MediaQuery.of(context)
                                                  .size
                                                  .width,
                                              child: AutoSizeText(
                                                textString,
                                                style: TextStyle(
                                                  fontSize: tempFontSize! > 30
                                                      ? 30
                                                      : tempFontSize,
                                                  color: tempFontColor,
                                                  backgroundColor:
                                                      tempBackground,
                                                ),
                                                textAlign: tempIsLeftAlign!
                                                    ? TextAlign.justify
                                                    : TextAlign.left,
                                              ),
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              )

                            // #endregion
                            :
                            // #region Vertical
                            SmartRefresher(
                                enablePullDown: true,
                                enablePullUp: true,
                                header: ClassicHeader(
                                  releaseIcon: Icon(
                                    Icons.arrow_upward,
                                    color: tempFontColor,
                                  ),
                                  idleIcon: Icon(
                                    Icons.arrow_upward,
                                    color: tempFontColor,
                                  ),
                                  idleText: L(
                                      context,
                                      LanguageCodes.previousChapterTextInfo
                                          .toString()),
                                  refreshingText: L(context,
                                      LanguageCodes.loadingTextInfo.toString()),
                                  releaseText: L(context,
                                      LanguageCodes.loadingTextInfo.toString()),
                                ),
                                controller: _refreshController,
                                onRefresh: () =>
                                    _onRefresh(chapterInfo[_chapterIndex].id),
                                onLoading: () => _onLoading(
                                    chapterInfo[_chapterIndex].id, true),
                                footer: ClassicFooter(
                                  canLoadingIcon: Icon(
                                    Icons.arrow_downward,
                                    color: tempFontColor,
                                  ),
                                  idleText: L(
                                      context,
                                      LanguageCodes.loadingMoreTextInfo
                                          .toString()),
                                  canLoadingText: L(
                                      context,
                                      LanguageCodes.nextChapterTextInfo
                                          .toString()),
                                ),
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    controller: _scrollController,
                                    itemCount: 1,
                                    itemBuilder: (context, index) {
                                      return Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MediaQuery.of(context)
                                                .size
                                                .width,
                                            child: Html(
                                              data: chapterInfo[_chapterIndex]
                                                  .body
                                                  .replaceAll(
                                                      RegExp(
                                                          r'(?:Chương|chương)[^\n]*'),
                                                      "")
                                                  .replaceAll("\n", "")
                                                  .trim(),
                                              style: {
                                                '#': Style(
                                                  padding: !_isVisible
                                                      ? HtmlPaddings.only(
                                                          top: 4.0)
                                                      : null,
                                                  textAlign: tempIsLeftAlign!
                                                      ? TextAlign.justify
                                                      : TextAlign.left,
                                                  fontFamily: tempFontFamily,
                                                  fontSize:
                                                      FontSize(tempFontSize!),
                                                  color: tempFontColor,
                                                  backgroundColor:
                                                      tempBackground,
                                                ),
                                              },
                                            ),
                                          ),
                                        ],
                                      );
                                    }),
                              ),

                        // #endregion

                        // #region Info chapter
                        !_isVisible
                            ? Positioned(
                                top: 0,
                                right: 0,
                                left: 0,
                                child: Container(
                                  height: MainSetting.getPercentageOfDevice(
                                          context,
                                          expectHeight: 35)
                                      .height,
                                  color: tempBackground,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Stack(children: [
                                        Container(
                                          width:
                                              MainSetting.getPercentageOfDevice(
                                                      context,
                                                      expectWidth: 300)
                                                  .width,
                                          padding: const EdgeInsets.all(4.0),
                                          child: Text(
                                            _chapterName
                                                .replaceAll(
                                                    RegExp(r'Chương \d+:'), '')
                                                .replaceAll("\n", "")
                                                .replaceAll('.', "")
                                                .trim(),
                                            style: CustomFonts.h6(context)
                                                .copyWith(
                                                    color: tempFontColor,
                                                    fontSize: 13),
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                        showToolTip(_chapterName
                                            .replaceAll(
                                                RegExp(r'Chương \d+:'), '')
                                            .replaceAll("\n", "")
                                            .replaceAll('.', "")
                                            .trim())
                                      ]),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.center,
                                        children: [
                                          Padding(
                                              padding:
                                                  const EdgeInsets.all(8.0),
                                              child: UpdateCurrentTime(
                                                tempColor: tempFontColor!,
                                              )),
                                          GetBatteryStatus(
                                              tempColor: tempFontColor)
                                        ],
                                      ),
                                    ],
                                  ),
                                ),
                              )
                            : const SizedBox()

                        // #endregion
                      ]),
                    ),
                    // #region dashboard bottom and ads banner
                    floatingActionButton: ButtonChapterScroll(
                        tempLocationScrollButton: tempLocationScrollButton,
                        tempFontColor: tempFontColor!,
                        tempBackground: tempBackground!,
                        scrollController: _scrollController),
                    bottomNavigationBar: SingleChildScrollView(
                      physics: const NeverScrollableScrollPhysics(),
                      controller: _scrollAdsController,
                      child: AnimatedContainer(
                        height: !_isSubscription
                            ? MainSetting.getPercentageOfDevice(context,
                                    expectHeight: _heightBottomContainer)
                                .height
                            : null,
                        duration: const Duration(milliseconds: 300),
                        child: Column(
                          children: [
                            !_isSubscription
                                ? Container(
                                    margin: const EdgeInsets.only(bottom: 5),
                                    child: Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        // Padding(
                                        //   padding: const EdgeInsets.symmetric(
                                        //       horizontal: 12.0),
                                        //   child: Container(
                                        //       padding:
                                        //           const EdgeInsets.all(4.0),
                                        //       decoration: BoxDecoration(
                                        //           borderRadius:
                                        //               BorderRadius.circular(
                                        //                   30.0),
                                        //           color: themeMode(
                                        //               context,
                                        //               ColorCode
                                        //                   .textColor.name)),
                                        //       child: const BuyPremium()),
                                        // ),
                                        Padding(
                                            padding: const EdgeInsets.only(
                                                right: 8.0),
                                            child: _isCountComplete
                                                ? SizedBox(
                                                    width: MainSetting
                                                            .getPercentageOfDevice(
                                                                context,
                                                                expectWidth: 20)
                                                        .width,
                                                    height: MainSetting
                                                            .getPercentageOfDevice(
                                                                context,
                                                                expectHeight:
                                                                    18)
                                                        .height,
                                                    child: GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            if (_scrollAdsController
                                                                    .hasClients &&
                                                                !_isContainerVisible) {
                                                              _heightBottomContainer =
                                                                  MainSetting.getPercentageOfDevice(
                                                                          context,
                                                                          expectHeight:
                                                                              26)
                                                                      .height!;
                                                              _heightAdsContainer =
                                                                  MainSetting.getPercentageOfDevice(
                                                                          context,
                                                                          expectHeight:
                                                                              0)
                                                                      .height!;
                                                              _scrollAdsController
                                                                  .animateTo(
                                                                0,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            300),
                                                                curve: Curves
                                                                    .easeInOut,
                                                              );
                                                              _isContainerVisible =
                                                                  true;
                                                            } else if (_scrollAdsController
                                                                    .hasClients &&
                                                                _isContainerVisible) {
                                                              _heightBottomContainer =
                                                                  MainSetting.getPercentageOfDevice(
                                                                          context,
                                                                          expectHeight:
                                                                              75.2)
                                                                      .height!;
                                                              _heightAdsContainer =
                                                                  MainSetting.getPercentageOfDevice(
                                                                          context,
                                                                          expectHeight:
                                                                              49)
                                                                      .height!;
                                                              _scrollAdsController
                                                                  .animateTo(
                                                                75.2,
                                                                duration:
                                                                    const Duration(
                                                                        milliseconds:
                                                                            300),
                                                                curve: Curves
                                                                    .easeInOut,
                                                              );
                                                              _isContainerVisible =
                                                                  false;
                                                            }
                                                          });
                                                        },
                                                        child: _isVisible
                                                            ? null
                                                            : Container(
                                                                decoration: BoxDecoration(
                                                                    borderRadius:
                                                                        BorderRadius.circular(
                                                                            30.0),
                                                                    color: themeMode(
                                                                        context,
                                                                        ColorCode
                                                                            .textColor
                                                                            .name)),
                                                                child:
                                                                    !_isContainerVisible
                                                                        ? Icon(
                                                                            size:
                                                                                MainSetting.getPercentageOfDevice(context, expectWidth: 18).width,
                                                                            Icons.keyboard_arrow_down_outlined,
                                                                            color:
                                                                                themeMode(context, ColorCode.modeColor.name),
                                                                          )
                                                                        : Icon(
                                                                            size:
                                                                                MainSetting.getPercentageOfDevice(context, expectWidth: 18).width,
                                                                            Icons.keyboard_arrow_up_outlined,
                                                                            color:
                                                                                themeMode(context, ColorCode.modeColor.name),
                                                                          ),
                                                              )),
                                                  )
                                                : CounterTimeAds(
                                                    second: _second,
                                                    onSuccess:
                                                        _setIsCountCompleteValue,
                                                  )),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                            // #region Menu setting
                            _isVisible
                                ? AnimatedContainer(
                                    duration: const Duration(milliseconds: 300),
                                    curve: Curves.linearToEaseOut,
                                    child: BottomChapterDetail(
                                        callback: (val) =>
                                            _updateChapterCurrentIntoChapterList(
                                                val),
                                        totalChapter: widget.totalChapter,
                                        firstChapterId: widget.firstChapterId,
                                        lastChapterId: widget.lastChapterId,
                                        storyImageUrl: widget.imageUrl,
                                        storyId: widget.storyId,
                                        title: widget.storyName,
                                        disableColor: _settingConfig
                                            .disableColor!,
                                        isDisablePreviousButton:
                                            _isDisablePreviousButton,
                                        isDisableNextButton:
                                            _isDisableNextButton ||
                                                chapterInfo[_chapterIndex].id ==
                                                    widget.lastChapterId,
                                        fontColor: tempFontColor,
                                        backgroundColor: tempBackground,
                                        chapterId:
                                            chapterInfo[_chapterIndex].id,
                                        onRefresh: (int chapterId) =>
                                            _onRefresh(
                                                chapterInfo[_chapterIndex].id),
                                        onLoading: (int chapterId,
                                                bool isCheckShow) =>
                                            _onLoading(
                                                chapterInfo[_chapterIndex].id,
                                                false)),
                                  )

                                // #endregion
                                : _bannerAd == null
                                    ? const SizedBox(
                                        height: 0,
                                      )
                                    :
                                    // #region Ads banner
                                    _bannerIsLoaded && !_isSubscription
                                        ? Stack(children: [
                                            AnimatedContainer(
                                              height: MainSetting
                                                      .getPercentageOfDevice(
                                                          context,
                                                          expectHeight:
                                                              _heightAdsContainer)
                                                  .height,
                                              duration: const Duration(
                                                  milliseconds: 300),
                                              child: AdWidget(ad: _bannerAd!),
                                            ),
                                          ])
                                        : const SizedBox(
                                            height: 0,
                                          )
                            // #endregion
                          ],
                        ),
                      ),
                      // #endregion
                    ));
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
