import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.fonts.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';
import 'package:muonroi/blocs/Chapters/group_bloc/group_chapters_of_story_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Chapter extends StatefulWidget {
  final int storyId;
  final String storyName;
  final int chapterId;
  const Chapter(
      {super.key,
      required this.storyId,
      required this.storyName,
      required this.chapterId});

  @override
  State<Chapter> createState() => _ChapterState();
}

class _ChapterState extends State<Chapter> {
  @override
  void initState() {
    initSharedPreferences();
    _scrollPositionKey = "scrollPosition-${widget.storyId}";
    _groupChapterOfStoryBloc = GroupChapterOfStoryBloc(
        widget.storyId, pageIndex, 20, false, widget.chapterId - 1);
    _groupChapterOfStoryBloc.add(GroupChapterOfStoryList());
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(_saveScrollPosition);
  }

  @override
  void dispose() {
    _groupChapterOfStoryBloc.close();
    _scrollController.removeListener(_saveScrollPosition);
    _scrollController.dispose();
    maxCallLoad = 0;
    super.dispose();
  }

  Future<void> initSharedPreferences() async {
    _sharedPreferences = await SharedPreferences.getInstance();
  }

  void loadMore() {
    if (context.mounted) {
      if (_scrollController.position.atEdge &&
          _scrollController.position.pixels ==
              _scrollController.position.maxScrollExtent &&
          currentPage == pageSize - 1 &&
          nextPageCount == 1) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          setState(() {
            _groupChapterOfStoryBloc.add(GroupMoreChapterOfStoryList());
            currentPage = 0;
            _scrollController.jumpTo(0);
            nextPageCount = 0;
          });
        });
      } else if (currentPage == pageSize - 1 && nextPageCount < 1) {
        const Center(child: CircularProgressIndicator());
        nextPageCount++;
      }
    }
  }

  void _saveScrollPosition() async {
    await _sharedPreferences.setDouble(
        _scrollPositionKey, _scrollController.offset);
    await _sharedPreferences.setInt("story-${widget.storyId}", maxCallLoad);
    if (context.mounted) {
      if (_scrollController.hasClients && _scrollController.position.atEdge) {
        if (_scrollController.position.pixels != 0) {
          setState(() {
            const Center(child: CircularProgressIndicator());
            if (currentPage < pageSize - 1 &&
                _scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent &&
                nextPageCount == 1) {
              currentPage++;
              _scrollController.jumpTo(0);
              nextPageCount = 0;
            } else if (currentPage < pageSize - 1 &&
                _scrollController.position.pixels ==
                    _scrollController.position.maxScrollExtent &&
                nextPageCount < 1) {
              nextPageCount++;
            }
          });
        }
      }
    }
  }

  void loadSavedScrollPosition() async {
    SharedPreferences savedLocation = await SharedPreferences.getInstance();
    _savedScrollPosition = savedLocation.getDouble(_scrollPositionKey) ?? 0.0;
    if (_scrollController.hasClients) {
      _scrollController.jumpTo(_savedScrollPosition);
    }
  }

  int maxCallLoad = 0;
  late SharedPreferences _sharedPreferences;
  late GroupChapterOfStoryBloc _groupChapterOfStoryBloc;
  late ScrollController _scrollController;
  double _savedScrollPosition = 0.0;
  int nextPageCount = 0;
  int pageIndex = 1;
  late int pageSize = 2;
  int currentPage = 0;
  bool isVisible = true;
  late String _scrollPositionKey;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _groupChapterOfStoryBloc,
      child: BlocListener<GroupChapterOfStoryBloc, GroupChapterOfStoryState>(
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
            child:
                BlocBuilder<GroupChapterOfStoryBloc, GroupChapterOfStoryState>(
              builder: (context, state) {
                if (state is GroupChapterOfStoryLoadingState) {}
                if (state is GroupChapterOfStoryLoadedState) {
                  loadSavedScrollPosition();
                  return Stack(children: [
                    ListView.builder(
                      controller: _scrollController,
                      itemCount: 1,
                      itemBuilder: (context, index) {
                        if (currentPage == pageSize - 1) {
                          loadMore();
                        }
                        var chaptersInfo = state.chapter.result.items;
                        if (chaptersInfo.isNotEmpty) {
                          maxCallLoad = chaptersInfo[currentPage].id;
                        }
                        pageSize = chaptersInfo.length;
                        return chaptersInfo.isNotEmpty
                            ? Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: Column(
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
                                                "${L(ViCode.chapterNumberTextInfo.toString())} ${chaptersInfo[currentPage].numberOfChapter}: ",
                                                style: FontsDefault.h5.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
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
                                                chaptersInfo[currentPage]
                                                    .chapterTitle
                                                    .replaceAll("\n", "")
                                                    .trim(),
                                                style: FontsDefault.h5.copyWith(
                                                    fontWeight:
                                                        FontWeight.w600),
                                                maxLines: 2,
                                                overflow: TextOverflow.ellipsis,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    Html(
                                        data: chaptersInfo[currentPage]
                                            .body
                                            .replaceAll("\n", "")
                                            .trim())
                                  ],
                                ))
                            : SizedBox(
                                height: MediaQuery.of(context).size.height,
                                child: Align(
                                  alignment: Alignment.center,
                                  child: Text(
                                      L(ViCode.chapterEndTextInfo.toString()),
                                      style: FontsDefault.h4),
                                ),
                              );
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
