import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.button.scroll.chapter.dart';
import 'package:muonroi/features/chapters/provider/models.chapter.template.settings.dart';
import 'package:muonroi/features/chapters/bloc/detail_bloc/detail_bloc.dart';
import 'package:muonroi/features/chapters/presentation/widgets/widget.static.detail.chapter.bottom.dart';
import 'package:muonroi/features/chapters/settings/settings.dart';
import 'package:muonroi/features/stories/presentation/pages/widget.static.stories.detail.dart';
import 'package:muonroi/shared/settings/enums/emum.key.local.storage.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chapter extends StatefulWidget {
  final int storyId;
  final String storyName;
  final int chapterId;
  final int lastChapterId;
  final int firstChapterId;
  final bool isLoadHistory;
  const Chapter(
      {super.key,
      required this.storyId,
      required this.storyName,
      required this.chapterId,
      required this.lastChapterId,
      required this.firstChapterId,
      required this.isLoadHistory});

  @override
  State<Chapter> createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  @override
  void initState() {
    _initSharedPreferences();
    _settingConfig = TemplateSetting();
    _scrollPositionKey = "scrollPosition-${widget.storyId}";
    _detailChapterOfStoryBloc =
        DetailChapterOfStoryBloc(chapterId: widget.chapterId);
    _detailChapterOfStoryBloc
        .add(const DetailChapterOfStory(null, null, chapterId: 0));
    super.initState();
    _scrollController = ScrollController();
    _refreshController = RefreshController(initialRefresh: false);
    _scrollController.addListener(_saveScrollPosition);
    _isVisible = false;
    _isLoad = true;

    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  }

  @override
  void dispose() {
    _detailChapterOfStoryBloc.close();
    _scrollController.removeListener(_saveScrollPosition);
    _scrollController.dispose();
    _refreshController.dispose();
    _isLoad = false;
    super.dispose();
  }

// #region Methods

  Future<void> _initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
    _settingConfig = getCurrentTemplate(_sharedPreferences);
  }

  void _saveScrollPosition() async {
    await _sharedPreferences.setDouble(
        _scrollPositionKey, _scrollController.offset);
    await _sharedPreferences.setInt("story-${widget.storyId}", widget.storyId);
    await _sharedPreferences.setInt(
        "story-${widget.storyId}-current-chapter-id", _chapterIdOld);
    await _sharedPreferences.setInt(
        "story-${widget.storyId}-current-chapter", _chapterNumber);
  }

  void _loadSavedScrollPosition() async {
    if (_isLoad && widget.isLoadHistory) {
      SharedPreferences savedLocation = await SharedPreferences.getInstance();
      _savedScrollPosition = savedLocation.getDouble(_scrollPositionKey) ?? 0.0;
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(_savedScrollPosition);
      }
    }
  }

  void _onRefresh(int chapterId) async {
    if (mounted && widget.firstChapterId != chapterId) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        setState(() {
          _detailChapterOfStoryBloc.add(DetailChapterOfStory(
              false, widget.storyId,
              chapterId: chapterId));
        });
      });
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
          _detailChapterOfStoryBloc.add(
              DetailChapterOfStory(true, widget.storyId, chapterId: chapterId));
          _scrollController.jumpTo(0.0);
          _isLoading = false;
        });
      });
    } else if (!_isLoading) {
      _isLoading = true;
    }
    _refreshController.loadComplete();
  }

  void _reNewValueInSettingTemplate(TemplateSetting newValue) {
    _settingConfig.backgroundColor = newValue.backgroundColor == null
        ? _settingConfig.backgroundColor
        : newValue.backgroundColor;
    _settingConfig.fontColor = newValue.fontColor == null
        ? _settingConfig.fontColor
        : newValue.backgroundColor;
    _settingConfig.fontSize =
        newValue.fontSize == null ? _settingConfig.fontSize : newValue.fontSize;
    _settingConfig.fontFamily = newValue.fontFamily == null
        ? _settingConfig.fontFamily
        : newValue.fontFamily;
    _settingConfig.isLeftAlign = newValue.isLeftAlign == null
        ? _settingConfig.isLeftAlign
        : newValue.isLeftAlign;
    _settingConfig.locationButton = newValue.locationButton == null
        ? _settingConfig.locationButton
        : newValue.locationButton;
    _settingConfig.isHorizontal = newValue.isHorizontal == null
        ? _settingConfig.isHorizontal
        : newValue.isHorizontal;
  }
// #endregion

// #region Variables
  late bool _isLoad;
  var _chapterIdOld = 0;
  var _chapterNumber = 0;
  var _savedScrollPosition = 0.0;
  var _isLoading = false;
  var _isVisible = false;
  late SharedPreferences _sharedPreferences;
  late DetailChapterOfStoryBloc _detailChapterOfStoryBloc;
  late ScrollController _scrollController;
  late RefreshController _refreshController;
  late String _scrollPositionKey;
  late TemplateSetting _settingConfig;

  // #endregion

  @override
  Widget build(BuildContext context) {
    if (!_isVisible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }
    return BlocProvider(
      create: (context) => _detailChapterOfStoryBloc,
      child: BlocListener<DetailChapterOfStoryBloc, DetailChapterOfStoryState>(
          listener: (context, state) {
        const Center(
          child: CircularProgressIndicator(),
        );
      }, child:
              BlocBuilder<DetailChapterOfStoryBloc, DetailChapterOfStoryState>(
        builder: (context, state) {
          if (state is DetailChapterOfStoryLoadingState) {
            const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is DetailChapterOfStoryLoadedState) {
            _loadSavedScrollPosition();

            _settingConfig.backgroundColor =
                _settingConfig.backgroundColor ?? ColorDefaults.lightAppColor;
            _settingConfig.fontColor =
                _settingConfig.fontColor ?? ColorDefaults.thirdMainColor;
            _settingConfig.fontFamily =
                _settingConfig.fontFamily ?? FontsDefault.inter;
            _settingConfig.fontSize = _settingConfig.fontSize ?? 15;
            _settingConfig.isLeftAlign = _settingConfig.isLeftAlign ?? true;
            _settingConfig.locationButton =
                _settingConfig.locationButton ?? KeyChapterButtonScroll.none;
            _settingConfig.isHorizontal = _settingConfig.isHorizontal ?? false;
            var chapterInfo = state.chapter.result;
            _chapterIdOld = chapterInfo.id;
            _chapterNumber = chapterInfo.numberOfChapter;
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
                          title: GestureDetector(
                            onDoubleTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => StoriesDetail(
                                            storyId: widget.storyId,
                                            storyTitle: widget.storyName,
                                          )));
                            },
                            child: Title(
                                color: tempFontColor!,
                                child: Text(
                                  widget.storyName,
                                  style: FontsDefault.h5.copyWith(
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
                        idleText: L(ViCode.previousChapterTextInfo.toString()),
                        refreshingText: L(ViCode.loadingTextInfo.toString()),
                        releaseText: L(ViCode.loadingTextInfo.toString()),
                      ),
                      controller: _refreshController,
                      onRefresh: () => _onRefresh(chapterInfo.id),
                      onLoading: () => _onLoading(chapterInfo.id, true),
                      footer: ClassicFooter(
                        canLoadingIcon: Icon(
                          Icons.arrow_downward,
                          color: tempFontColor,
                        ),
                        idleText: L(ViCode.loadingMoreTextInfo.toString()),
                        canLoadingText:
                            L(ViCode.nextChapterTextInfo.toString()),
                      ),
                      child: tempIsHorizontal!
                          ? ListView.builder(
                              scrollDirection: Axis.horizontal,
                              physics: const PageScrollPhysics(),
                              controller: _scrollController,
                              itemCount: chapterInfo.bodyChunk.length,
                              itemBuilder: (context, index) {
                                var textString = convertTagHtmlFormatToString(
                                        chapterInfo.bodyChunk[index])
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
                                                        "${L(ViCode.chapterNumberTextInfo.toString())} ${chapterInfo.numberOfChapter}",
                                                        style: FontsDefault.h5
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
                                                        chapterInfo.chapterTitle
                                                            .replaceAll(
                                                                RegExp(
                                                                    r'Chương \d+:'),
                                                                '')
                                                            .replaceAll(
                                                                "\n", "")
                                                            .trim(),
                                                        style: FontsDefault.h5
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
                                                "${L(ViCode.chapterNumberTextInfo.toString())} ${chapterInfo.numberOfChapter}",
                                                style: FontsDefault.h5.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: tempFontFamily,
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
                                                chapterInfo.chapterTitle
                                                    .replaceAll(
                                                        RegExp(r'Chương \d+:'),
                                                        '')
                                                    .replaceAll("\n", "")
                                                    .trim(),
                                                style: FontsDefault.h5.copyWith(
                                                    fontWeight: FontWeight.w600,
                                                    fontFamily: tempFontFamily,
                                                    color: tempFontColor),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      child: Html(
                                        data: chapterInfo.body
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
                              fontColor: tempFontColor,
                              backgroundColor: tempBackground,
                              chapterId: chapterInfo.id,
                              onRefresh: (int chapterId) =>
                                  _onRefresh(chapterInfo.id),
                              onLoading: (int chapterId, bool isCheckShow) =>
                                  _onLoading(chapterInfo.id, false)),
                        )
                      : null,
                );
              },
            );
          }
          return const Center(child: CircularProgressIndicator());
        },
      )),
    );
  }
}
