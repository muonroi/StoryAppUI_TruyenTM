import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';
import 'package:muonroi/blocs/Chapters/Detail_bloc/detail_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chapter extends StatefulWidget {
  final int storyId;
  final String storyName;
  final int chapterId;
  final int lastChapterId;
  const Chapter(
      {super.key,
      required this.storyId,
      required this.storyName,
      required this.chapterId,
      required this.lastChapterId});

  @override
  State<Chapter> createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  @override
  void initState() {
    isLoad = true;
    initSharedPreferences();
    scrollPositionKey = "scrollPosition-${widget.storyId}";
    _detailChapterOfStoryBloc =
        DetailChapterOfStoryBloc(chapterId: widget.chapterId);
    _detailChapterOfStoryBloc
        .add(const DetailChapterOfStory(null, null, chapterId: 0));
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_saveScrollPosition);
  }

  @override
  void dispose() {
    isLoad = false;
    _detailChapterOfStoryBloc.close();
    _scrollController.removeListener(_saveScrollPosition);
    _scrollController.dispose();
    maxPosition = false;
    minPosition = false;
    super.dispose();
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void _saveScrollPosition() async {
    await _sharedPreferences.setDouble(
        scrollPositionKey, _scrollController.offset);
    await _sharedPreferences.setInt("story-${widget.storyId}", widget.storyId);
    await _sharedPreferences.setInt(
        "story-${widget.storyId}-current-chapter-id", chapterIdOld);
    await _sharedPreferences.setInt(
        "story-${widget.storyId}-current-chapter", chapterNumber);

    if (_scrollController.hasClients &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        isNextPage) {
      setState(() {
        maxPosition = true;
        isNextPage = false;
      });
    } else if (_scrollController.hasClients &&
        _scrollController.position.pixels ==
            _scrollController.position.maxScrollExtent &&
        !isNextPage) {
      isNextPage = true;
    }
    if (_scrollController.hasClients &&
        _scrollController.position.pixels == 0.0 &&
        isPrePage) {
      setState(() {
        minPosition = true;
        isPrePage = false;
      });
    } else if (_scrollController.hasClients &&
        _scrollController.position.pixels == 0.0 &&
        !isPrePage) {
      isPrePage = true;
    }
  }

  void loadSavedScrollPosition() async {
    if (isLoad) {
      SharedPreferences savedLocation = await SharedPreferences.getInstance();
      savedScrollPosition = savedLocation.getDouble(scrollPositionKey) ?? 0.0;
      if (_scrollController.hasClients) {
        _scrollController.jumpTo(savedScrollPosition);
      }
    }
  }

  late bool maxPosition = false;
  late bool minPosition = false;
  late bool isLoad = false;
  var storyIdOld = 0;
  var chapterIdOld = 0;
  var chapterNumber = 0;
  var savedScrollPosition = 0.0;
  var isNextPage = false;
  var isPrePage = false;
  var isVisible = true;
  late SharedPreferences _sharedPreferences;
  late DetailChapterOfStoryBloc _detailChapterOfStoryBloc;
  late ScrollController _scrollController;
  late String scrollPositionKey;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _detailChapterOfStoryBloc,
      child: BlocListener<DetailChapterOfStoryBloc, DetailChapterOfStoryState>(
        listener: (context, state) {},
        child: Scaffold(
          appBar: isVisible
              ? AppBar(
                  elevation: 0,
                  backgroundColor: ColorDefaults.lightAppColor,
                  leading: const BackButton(
                    color: ColorDefaults.thirdMainColor,
                  ),
                  title: Title(
                      color: ColorDefaults.thirdMainColor,
                      child: Text(
                        widget.storyName,
                        style: FontsDefault.h5,
                      )),
                )
              : PreferredSize(preferredSize: Size.zero, child: Container()),
          backgroundColor: ColorDefaults.lightAppColor,
          body: GestureDetector(
            onTap: () {
              setState(() {
                isVisible = false;
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                    overlays: []);
              });
            },
            onDoubleTap: () {
              setState(() {
                isVisible = true;
                SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
                    overlays: SystemUiOverlay.values);
              });
            },
            child: BlocBuilder<DetailChapterOfStoryBloc,
                DetailChapterOfStoryState>(
              builder: (context, state) {
                if (state is DetailChapterOfStoryLoadingState) {}
                if (state is DetailChapterOfStoryLoadedState) {
                  loadSavedScrollPosition();
                  return Stack(children: [
                    ListView.builder(
                      controller: _scrollController,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        var chapterInfo = state.chapter.result;
                        chapterIdOld = chapterInfo.id;
                        chapterNumber = chapterInfo.numberOfChapter;
                        if (maxPosition) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _detailChapterOfStoryBloc.add(
                                  DetailChapterOfStory(true, widget.storyId,
                                      chapterId: chapterInfo.id));
                              maxPosition = false;
                              _scrollController.jumpTo(0.5);
                            });
                          });
                        }
                        if (minPosition) {
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              _detailChapterOfStoryBloc.add(
                                  DetailChapterOfStory(false, widget.storyId,
                                      chapterId: chapterInfo.id));
                              minPosition = false;
                              _scrollController.jumpTo(0.5);
                            });
                          });
                        }
                        return Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Align(
                                  alignment: Alignment.center,
                                  child: SizedBox(
                                    width: MainSetting.getPercentageOfDevice(
                                            context,
                                            expectWidth: 387)
                                        .width,
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        SizedBox(
                                          width:
                                              MainSetting.getPercentageOfDevice(
                                                      context,
                                                      expectWidth: 96.75)
                                                  .width,
                                          child: Text(
                                            "${L(ViCode.chapterNumberTextInfo.toString())} ${chapterInfo.numberOfChapter}: ",
                                            style: FontsDefault.h5.copyWith(
                                                fontWeight: FontWeight.w600),
                                            maxLines: 2,
                                            overflow: TextOverflow.visible,
                                            textAlign: TextAlign.center,
                                          ),
                                        ),
                                        SizedBox(
                                          width:
                                              MainSetting.getPercentageOfDevice(
                                                      context,
                                                      expectWidth: 290.25)
                                                  .width,
                                          child: Text(
                                            chapterInfo.chapterTitle
                                                .replaceAll("\n", "")
                                                .trim(),
                                            style: FontsDefault.h5.copyWith(
                                                fontWeight: FontWeight.w600),
                                            maxLines: 2,
                                            overflow: TextOverflow.ellipsis,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                Html(
                                    data: chapterInfo.body
                                        .replaceAll("\n", "")
                                        .trim())
                              ],
                            ));
                        // : SizedBox(
                        //     height: MediaQuery.of(context).size.height,
                        //     child: Align(
                        //       alignment: Alignment.center,
                        //       child: Text(
                        //           L(ViCode.chapterEndTextInfo.toString()),
                        //           style: FontsDefault.h4),
                        //     ),
                        //   );
                      },
                    ),
                  ]);
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ),
      ),
    );
  }
}
