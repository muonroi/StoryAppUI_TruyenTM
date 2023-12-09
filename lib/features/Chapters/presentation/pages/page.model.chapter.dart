import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:muonroi/core/advertising/ads.admob.service.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/chapters/bloc/group_chapter/group_chapter_bloc.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.button.scroll.chapter.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.detail.chapter.bottom.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.body.chapter.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.chapter.ads.countdown.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.chapter.appbar.detail.dart';
import 'package:muonroi/features/chapters/provider/provider.chapter.template.settings.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:provider/provider.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.template.dart';

class ChapterContentOfStory extends StatefulWidget {
  final StreamController<bool> reloadChapterId;
  final String author;
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
  const ChapterContentOfStory(
      {super.key,
      required this.author,
      required this.loadSingleChapter,
      required this.storyId,
      required this.storyName,
      required this.chapterId,
      required this.lastChapterId,
      required this.firstChapterId,
      required this.isLoadHistory,
      required this.pageIndex,
      required this.totalChapter,
      required this.chapterNumber,
      required this.imageUrl,
      required this.reloadChapterId});

  @override
  State<ChapterContentOfStory> createState() => _ChapterContentOfStoryState();
}

class _ChapterContentOfStoryState extends State<ChapterContentOfStory> {
// #region state override
  @override
  void initState() {
    _second = 5;
    _userInfo = '';
    _isCountComplete = false;
    _bannerIsLoaded = false;
    _heightBottomContainer = 100;
    _heightAdsContainer = 70;
    _scrollAdsController = ScrollController();
    _maxHeightAppBar = 50.0;
    _isContainerVisible = false;
    _isShowDetailAppbar = false;
    _scrollChapterBodyController = ScrollController();
    _isLoadTemplate = true;
    _settingConfig = TemplateSetting();
    _pageIndex = widget.pageIndex;
    _groupChaptersBloc = GroupChapterBloc(widget.storyId, _pageIndex, 100);
    _groupChaptersBloc.add(GroupChapter(
        widget.storyId, _pageIndex, widget.loadSingleChapter ? true : false));
    _isDisplay = false;
    _isDisablePreviousButton = false;
    _isDisableNextButton = false;
    _isLoadedHistoryForOneChapter = true;
    _chapterIndex =
        chapterBox.get("story-${widget.storyId}-current-chapter-index") ?? 0;
    _putEventHideActionBottomButton = StreamController<bool>();
    _putEventToChildController = StreamController<Map<bool, int>>();
    _putEventChapterTemplate = StreamController<ChapterTemplate>();
    _putEventSaveCurrentChapterToChapterList = StreamController<bool>();
    _putEventIsScrollHorizontal = StreamController<bool>();
    super.initState();
    _initTemplate();
    widget.reloadChapterId.add(true);
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final adState = Provider.of<AdMobService>(context);
    adState.initializations.then((status) {
      setState(() {
        _createBannerAds(adState);
        _bannerIsLoaded = true;
      });
    });
    widget.reloadChapterId.add(true);
  }

  @override
  void dispose() {
    if (!widget.reloadChapterId.isClosed) {
      widget.reloadChapterId.add(true);
    }
    _putEventToChildController.close();
    _groupChaptersBloc.close();
    _putEventSaveCurrentChapterToChapterList.close();
    _putEventChapterTemplate.close();
    _scrollChapterBodyController.dispose();
    _scrollAdsController.dispose();
    super.dispose();
  }

  // #endregion

// #region function

  void _displayAppbar(isDisplay) {
    setState(() {
      _isDisplay = isDisplay;
      if (!_isCountComplete) {
        _isCountComplete = _isSubscription;
      }
      if (_isCountComplete) {
        if (_isDisplay == false) {
          _heightBottomContainer =
              MainSetting.getPercentageOfDevice(context, expectHeight: 26.0)
                  .height!;
          _heightAdsContainer =
              MainSetting.getPercentageOfDevice(context, expectHeight: 0.0)
                  .height!;
        } else {
          _heightBottomContainer =
              MainSetting.getPercentageOfDevice(context, expectHeight: 100)
                  .height!;
          _heightAdsContainer =
              MainSetting.getPercentageOfDevice(context, expectHeight: 70)
                  .height!;
        }
        if (!_isContainerVisible && _isDisplay == false) {
          _heightBottomContainer =
              MainSetting.getPercentageOfDevice(context, expectHeight: 100)
                  .height!;
          _heightAdsContainer =
              MainSetting.getPercentageOfDevice(context, expectHeight: 70)
                  .height!;
        }
      }
      if (_isShowDetailAppbar) {
        _isShowDetailAppbar = false;
        _maxHeightAppBar = 50.0;
      }
    });
  }

  void _disablePreviousButton(value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isDisablePreviousButton = value;
      });
    });
  }

  void _disableNextButton(value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isDisableNextButton = value;
      });
    });
  }

  void _putEventGroupChapter(pageIndex) {
    _groupChaptersBloc.add(GroupChapter(widget.storyId, pageIndex, false));
    _putEventHideActionBottomButton = StreamController<bool>();
    _putEventToChildController = StreamController<Map<bool, int>>();
    _putEventChapterTemplate = StreamController<ChapterTemplate>();
    _putEventSaveCurrentChapterToChapterList = StreamController<bool>();
  }

  void _updateChapterIndex(index) {
    setState(() {
      _chapterIndex = index;
    });
  }

  void _updatePageIndex(index) {
    setState(() {
      _pageIndex = index;
    });
  }

  void _updateStateLoadedHistoryPosition(value) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _isLoadedHistoryForOneChapter = value;
      });
    });
  }

  void _initTemplate() {
    if (context.mounted && _isLoadTemplate) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _userInfo = userBox.get('userLogin')!;
          _isLoadTemplate = false;
          _settingConfig = getCurrentTemplate(context);
          var result = accountSignInFromJson(_userInfo);
          _isSubscription = result.result!.isSubScription;
        });
      });
    }
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

  void _createBannerAds(adState) {
    _bannerAd = BannerAd(
        adUnitId: adState.bannerAdUnitId,
        size: AdSize.banner,
        request: const AdRequest(),
        listener: adState.adListener)
      ..load();
  }

  void _setIsCountCompleteValueFunction() {
    setState(() {
      _isCountComplete = true;
    });
  }

  void _resetCountAds(value) {
    setState(() {
      _isCountComplete = false;
      _isContainerVisible = false;
      _second = 3;
      _heightAdsContainer = 70;
      _isDisplay = true;
      _heightBottomContainer = 100;
      _putEventHideActionBottomButton.add(true);
    });
  }

  void isVisibleContainerFunction(value) {
    setState(() {
      _isContainerVisible = value;
    });
  }

  void heightBottomContainerFunction(value) {
    setState(() {
      _heightBottomContainer = value;
    });
  }

  void heightBottomAdsContainerFunction(value) {
    setState(() {
      _heightAdsContainer = value;
    });
  }

  void setNewScrollControllerFunction(value) {
    _scrollAdsController = value;
  }

// #endregion

// #region variable
  late GroupChapterBloc _groupChaptersBloc;
  late bool _isDisplay;
  late bool _isDisablePreviousButton;
  late bool _isDisableNextButton;
  late int _chapterIndex;
  late int _pageIndex;
  late bool _isLoadedHistoryForOneChapter;
  late bool _isLoadTemplate;
  late bool _isShowDetailAppbar;
  late double _maxHeightAppBar;
  late StreamController<Map<bool, int>> _putEventToChildController;
  late StreamController<bool> _putEventSaveCurrentChapterToChapterList;
  late StreamController<ChapterTemplate> _putEventChapterTemplate;
  late StreamController<bool> _putEventHideActionBottomButton;
  late StreamController<bool> _putEventIsScrollHorizontal;
  late TemplateSetting _settingConfig;
  late ChapterTemplate _chapterTemplate;
  late ScrollController _scrollChapterBodyController;
  late bool _bannerIsLoaded;
  late BannerAd? _bannerAd;
  late int _second;
  late bool _isSubscription;
  late String _userInfo;
  late double _heightAdsContainer;
  late bool _isContainerVisible;
  late double _heightBottomContainer;
  late bool _isCountComplete;
  late ScrollController _scrollAdsController;
  // #endregion
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _groupChaptersBloc,
      child: BlocListener<GroupChapterBloc, GroupChapterBlocState>(
        listener: (context, state) => const Center(
          child: CircularProgressIndicator(),
        ),
        child: BlocBuilder<GroupChapterBloc, GroupChapterBlocState>(
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
              _settingConfig.backgroundColor = _settingConfig.backgroundColor ??
                  themeMode(context, ColorCode.modeColor.name);
              _settingConfig.fontColor = _settingConfig.fontColor ??
                  themeMode(context, ColorCode.textColor.name);
              _settingConfig.fontFamily =
                  _settingConfig.fontFamily ?? CustomFonts.inter;
              _settingConfig.disableColor = _settingConfig.disableColor ??
                  const Color.fromARGB(255, 179, 1100, 1100);
              _settingConfig.fontSize = _settingConfig.fontSize ?? 15;
              _settingConfig.isLeftAlign = _settingConfig.isLeftAlign ?? true;
              _settingConfig.locationButton =
                  _settingConfig.locationButton ?? KeyChapterButtonScroll.none;
              _settingConfig.isHorizontal =
                  _settingConfig.isHorizontal ?? false;
              // #endregion
              var chapterInfo = state.chapter.result.items;
              return Consumer<TemplateSetting>(
                builder: (context, templateValue, child) {
                  // #region setting old template
                  _reNewValueInSettingTemplate(templateValue);
                  _chapterTemplate = ChapterTemplate(
                      background: templateValue.backgroundColor ??
                          _settingConfig.backgroundColor,
                      font: templateValue.fontColor ?? _settingConfig.fontColor,
                      fontFamily:
                          templateValue.fontFamily ?? _settingConfig.fontFamily,
                      fontSize:
                          templateValue.fontSize ?? _settingConfig.fontSize,
                      isLeftAlign: templateValue.isLeftAlign ??
                          _settingConfig.isLeftAlign,
                      locationScrollButton: templateValue.locationButton ??
                          _settingConfig.locationButton,
                      isHorizontal: templateValue.isHorizontal ??
                          _settingConfig.isHorizontal);
                  _putEventChapterTemplate.add(_chapterTemplate);
                  if (templateValue.isHorizontal ?? false) {
                    _putEventIsScrollHorizontal.add(true);
                  } else {
                    _putEventIsScrollHorizontal.add(false);
                  }
                  // #endregion
                  return Scaffold(
                    appBar: !_isDisplay
                        ? null
                        : PreferredSize(
                            preferredSize: Size.fromHeight(_maxHeightAppBar),
                            child: AppBar(
                              bottom: _isShowDetailAppbar
                                  ? PreferredSize(
                                      preferredSize: const Size.fromHeight(70),
                                      child: MenuDetailAppbar(
                                          author: widget.author,
                                          storyId: widget.storyId,
                                          storyName: widget.storyName,
                                          chapterId: widget.chapterId,
                                          lastChapterId: widget.lastChapterId,
                                          firstChapterId: widget.firstChapterId,
                                          isLoadHistory: widget.isLoadHistory,
                                          pageIndex: widget.pageIndex,
                                          totalChapter: widget.totalChapter,
                                          chapterNumber: widget.chapterNumber,
                                          imageUrl: widget.imageUrl,
                                          settingConfig: _chapterTemplate),
                                    )
                                  : null,
                              title: Title(
                                  color: _chapterTemplate.font!,
                                  child: Text(
                                    widget.storyName,
                                    style: CustomFonts.h6(context).copyWith(
                                        fontSize: 14,
                                        color: _chapterTemplate.font),
                                  )),
                              automaticallyImplyLeading: false,
                              elevation: 1,
                              backgroundColor: _chapterTemplate.background,
                              leading: IconButton(
                                  splashRadius: 25,
                                  color: _chapterTemplate.font,
                                  onPressed: () {
                                    Navigator.maybePop(context, true);
                                  },
                                  icon: Icon(
                                    Icons.arrow_back_ios_sharp,
                                    color: _chapterTemplate.font,
                                  )),
                              actions: [
                                IconButton(
                                  icon: Icon(
                                    Icons.more_horiz,
                                    color: _chapterTemplate.font,
                                  ),
                                  onPressed: () {
                                    setState(() {
                                      _isShowDetailAppbar =
                                          !_isShowDetailAppbar;
                                      if (_isShowDetailAppbar) {
                                        _maxHeightAppBar =
                                            MainSetting.getPercentageOfDevice(
                                                    context,
                                                    expectHeight: 150.0)
                                                .height!;
                                      } else {
                                        _maxHeightAppBar =
                                            MainSetting.getPercentageOfDevice(
                                                    context,
                                                    expectHeight: 50.0)
                                                .height!;
                                      }
                                    });
                                  },
                                  splashRadius: 25,
                                )
                              ],
                            ),
                          ),
                    body: Stack(children: [
                      ChapterBody(
                        resetCountTimeAds: _resetCountAds,
                        isLoadedHistoryForOneChapter:
                            _updateStateLoadedHistoryPosition,
                        currentPageIndex: _updatePageIndex,
                        currentChapterIndex: _updateChapterIndex,
                        putEvenToGroup: _putEventGroupChapter,
                        disableNextButton: _disableNextButton,
                        disablePreviousButton: _disablePreviousButton,
                        displayAction: _displayAppbar,
                        strScrollHorizontal: _putEventIsScrollHorizontal,
                        strHideActionBottomButton:
                            _putEventHideActionBottomButton,
                        strChapterTemplate: _putEventChapterTemplate,
                        scrollChapterBodyController:
                            _scrollChapterBodyController,
                        chapterTemplate: _chapterTemplate,
                        chapterIndex: _chapterIndex,
                        strUpdateDataChapterToList:
                            _putEventSaveCurrentChapterToChapterList,
                        isLoadHistoryFunction: widget.isLoadHistory,
                        strActionChapterStreamController:
                            _putEventToChildController,
                        firstChapterId: widget.firstChapterId,
                        lastChapterId: widget.lastChapterId,
                        pageIndex: _pageIndex,
                        chapterInfo: chapterInfo[_chapterIndex],
                        isLoadedHistory: _isLoadedHistoryForOneChapter,
                        authorName: widget.author,
                        storyTitle: widget.storyName,
                        imageUrl: widget.imageUrl,
                        totalChapter: widget.totalChapter,
                      ),
                      if (!_isDisplay)
                        Align(
                          alignment: Alignment.bottomCenter,
                          child: AnimatedContainer(
                            color: Colors.transparent,
                            height: !_isSubscription
                                ? MainSetting.getPercentageOfDevice(context,
                                        expectHeight: _heightBottomContainer)
                                    .height
                                : null,
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linearToEaseOut,
                            child: !_isSubscription
                                ? Column(
                                    children: [
                                      ButtonDisplayOrHideAds(
                                        setIsCountdownCompleteFunction:
                                            _setIsCountCompleteValueFunction,
                                        isVisibleContainerFunction:
                                            isVisibleContainerFunction,
                                        heightBottomContainerFunction:
                                            heightBottomContainerFunction,
                                        heightBottomAdsContainerFunction:
                                            heightBottomAdsContainerFunction,
                                        setNewScrollControllerFunction:
                                            setNewScrollControllerFunction,
                                        isCountDownComplete: _isCountComplete,
                                        scrollAdsController:
                                            _scrollAdsController,
                                        isContainerVisible: _isContainerVisible,
                                        heightBottomContainer:
                                            _heightBottomContainer,
                                        heightAdsContainer: _heightAdsContainer,
                                        isDisplay: _isDisplay,
                                        second: _second,
                                      ),
                                      _bannerAd == null
                                          ? const SizedBox()
                                          : _bannerIsLoaded && !_isSubscription
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
                                                    child: AdWidget(
                                                        ad: _bannerAd!),
                                                  ),
                                                ])
                                              : const SizedBox(),
                                    ],
                                  )
                                : const SizedBox(),
                          ),
                        )
                      else
                        const SizedBox()
                    ]),
                    floatingActionButton: ButtonChapterScroll(
                        tempLocationScrollButton:
                            _chapterTemplate.locationScrollButton,
                        tempFontColor: _chapterTemplate.font!,
                        tempBackground: _chapterTemplate.background!,
                        scrollController: _scrollChapterBodyController),
                    bottomNavigationBar: SingleChildScrollView(
                        physics: const NeverScrollableScrollPhysics(),
                        controller: _scrollAdsController,
                        child: _isDisplay
                            ? BottomChapterDetail(
                                author: widget.author,
                                callback: (isAudio) {
                                  _putEventSaveCurrentChapterToChapterList
                                      .add(isAudio);
                                },
                                totalChapter: widget.totalChapter,
                                firstChapterId: widget.firstChapterId,
                                lastChapterId: widget.lastChapterId,
                                storyImageUrl: widget.imageUrl,
                                storyId: widget.storyId,
                                title: widget.storyName,
                                disableColor: _settingConfig.disableColor!,
                                isDisablePreviousButton:
                                    _isDisablePreviousButton,
                                isDisableNextButton: _isDisableNextButton,
                                fontColor: _chapterTemplate.font!,
                                backgroundColor: _chapterTemplate.background!,
                                chapterId: chapterInfo[_chapterIndex].id,
                                onRefresh: (int chapterId) => {
                                      _putEventToChildController.add({
                                        false: chapterInfo[_chapterIndex].id
                                      })
                                    },
                                onLoading: (int chapterId, bool isCheckShow) =>
                                    {
                                      _putEventToChildController.add(
                                          {true: chapterInfo[_chapterIndex].id})
                                    })
                            : const SizedBox()),
                  );
                },
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    );
  }
}
