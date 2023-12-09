import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/chapters/bloc/group_bloc/group_chapters_of_story_bloc.dart';
import 'package:muonroi/features/chapters/presentation/pages/page.model.chapter.dart';
import 'package:muonroi/features/story/bloc/detail/detail_bloc.dart';
import 'package:muonroi/features/story/presentation/pages/page.audio.story.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.detail.header.story.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.detail.intro.notify.story.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
import 'package:muonroi/features/story/presentation/pages/page.stories.download.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.detail.more.info.story.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.detail.similar.story.dart';
import 'package:muonroi/features/story/settings/enums/enum.story.user.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/static/buttons/widget.static.button.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/story/presentation/widgets/widget.static.detail.chapter.story.dart';

class StoryDetail extends StatefulWidget {
  final int storyId;
  final String storyTitle;
  const StoryDetail({
    Key? key,
    required this.storyId,
    required this.storyTitle,
  }) : super(key: key);
  @override
  State<StoryDetail> createState() => _StoryDetailState();
}

class _StoryDetailState extends State<StoryDetail> {
  @override
  void initState() {
    _isBookmark =
        storyBox.get("isBookmark-${widget.storyId}", defaultValue: false);
    _isGetChapterId = true;
    _chapterNumber = 0;
    _chapterId = 0;
    _pageIndex = 0;
    _storyRepository = StoryRepository();
    _detailStory = DetailStoryPageBloc(widget.storyId);
    _detailStory.add(GetDetailStory());
    _groupChapterOfStoryBloc =
        GroupChapterOfStoryBloc(widget.storyId, 1, 15, false, 0);
    _groupChapterOfStoryBloc.add(GroupChapterOfStoryList());
    _reloadChapterId = StreamController<bool>();
    _isBookmarkStream = StreamController<bool>();
    super.initState();
    _reloadChapterId.stream.listen((event) {
      if (event) {
        getChapterId();
      }
    });
    _listenEvent();
  }

  @override
  void dispose() {
    _groupChapterOfStoryBloc.close();
    _detailStory.close();
    _reloadChapterId.close();
    _isBookmarkStream.close();
    super.dispose();
  }

  void getChapterId() {
    setState(() {
      _chapterId =
          (chapterBox.get("story-${widget.storyId}-current-chapter-id") ?? 0);
      _chapterNumber =
          (chapterBox.get("story-${widget.storyId}-current-chapter") ?? 0);
      _pageIndex =
          (chapterBox.get("story-${widget.storyId}-current-page-index") ?? 1);
    });
  }

  void _listenEvent() {
    _isBookmarkStream.stream.listen((event) {
      setState(() {
        _isBookmark = event;
      });
      if (event) {
        _storyRepository.createStoryForUser(
            widget.storyId,
            StoryForUserType.bookmark.index,
            chapterBox.get("story-${widget.storyId}-current-chapter-index",
                defaultValue: 0),
            _pageIndex,
            _chapterNumber,
            0,
            _chapterId);
      } else {
        _storyRepository.deleteStoryForUser(widget.storyId);
      }
    });
  }

  late int _pageIndex;
  late DetailStoryPageBloc _detailStory;
  late int _chapterId;
  late int _chapterNumber;
  late StoryRepository _storyRepository;
  late GroupChapterOfStoryBloc _groupChapterOfStoryBloc;
  late bool _isGetChapterId;
  late bool _isBookmark;
  late StreamController<bool> _reloadChapterId;
  late StreamController<bool> _isBookmarkStream;
  @override
  Widget build(BuildContext context) {
    if (_isGetChapterId) {
      _isGetChapterId = false;
      getChapterId();
    }
    // #region not use now
    // List<Widget> componentOfDetailStory = [
    //   Header(infoStory: widget.storyInfo),
    //   MoreInfoStory(infoStory: widget.storyInfo),
    //   IntroAndNotificationStory(
    //     name:L(context,ViCode.introStoryTextInfo.toString()),
    //     value: widget.storyInfo.storySynopsis,
    //   ),
    //   // IntroAndNotificationStory(
    //   //   name:L(context,ViCode.notifyStoryTextInfo.toString()),
    //   //   value: "", //widget.storyInfo.notification ?? "",
    //   // ),
    //   ChapterOfStory(
    //     callback: (val) {
    //       WidgetsBinding.instance.addPostFrameCallback((_) {
    //         setState(() {
    //           latestChapter = double.parse(val);
    //         });
    //       });
    //     },
    //     storyId: widget.storyInfo.id,
    //   ),
    //   // CommentOfStory(
    //   //   widget: widget.storyInfo,
    //   // ),
    //   // RechargeStory(
    //   //   widget: widget.storyInfo,
    //   // ),
    //   SimilarStories(
    //     infoStory: widget.storyInfo,
    //   )
    // ];
    // #endregion

    return BlocProvider(
      create: (context) => _detailStory,
      child: BlocListener<DetailStoryPageBloc, DetailStoryState>(
        listener: (context, state) {
          const Center(child: CircularProgressIndicator());
        },
        child: BlocBuilder<DetailStoryPageBloc, DetailStoryState>(
          builder: (context, state) {
            if (state is DetailStoryLoadedState) {
              var storyInfo = state.story.result;
              return Scaffold(
                appBar: AppBar(
                  elevation: 0,
                  backgroundColor: themeMode(context, ColorCode.modeColor.name),
                  leading: BackButton(
                    color: themeMode(context, ColorCode.textColor.name),
                  ),
                ),
                backgroundColor: themeMode(context, ColorCode.modeColor.name),
                body: SizedBox(
                    child: ListView.builder(
                  itemCount: 1,
                  itemBuilder: (context, index) {
                    return Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Header(infoStory: storyInfo),
                            MoreInfoStory(infoStory: storyInfo),
                            IntroAndNotificationStory(
                              name: L(context,
                                  LanguageCodes.introStoryTextInfo.toString()),
                              value: storyInfo.storySynopsis,
                            ),
                            ChapterOfStory(
                              storyId: storyInfo.id,
                              storyInfo: storyInfo,
                            ),
                            SimilarStories(infoStory: storyInfo)
                          ],
                        ));
                  },
                )),
                bottomNavigationBar: BottomAppBar(
                  height: MainSetting.getPercentageOfDevice(context,
                          expectHeight: 70)
                      .height,
                  color: themeMode(context, ColorCode.modeColor.name),
                  child: SizedBox(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MainSetting.getPercentageOfDevice(context,
                                expectWidth: 150)
                            .width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            SizedBox(
                                child: IconButton(
                                    onPressed: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => StoryAudio(
                                                    author:
                                                        storyInfo.authorName,
                                                    totalChapter:
                                                        storyInfo.totalChapter,
                                                    lastChapterId:
                                                        storyInfo.lastChapterId,
                                                    firstChapterId: storyInfo
                                                        .firstChapterId,
                                                    imageUrl: storyInfo.imgUrl,
                                                    title: widget.storyTitle,
                                                    chapterId: _chapterId,
                                                    storyId: widget.storyId,
                                                  )));
                                    },
                                    icon: Icon(
                                      Icons.headphones_outlined,
                                      color: themeMode(
                                          context, ColorCode.textColor.name),
                                    ))),
                            SizedBox(
                              child: IconButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                StoriesDownloadPage(
                                                  storyName:
                                                      storyInfo.storyTitle,
                                                  storyId: storyInfo.id,
                                                  totalChapter:
                                                      storyInfo.totalChapter,
                                                  firstChapterId:
                                                      storyInfo.firstChapterId,
                                                )));
                                  },
                                  icon: Icon(
                                    Icons.download_outlined,
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                  )),
                            ),
                            SizedBox(
                              child: IconButton(
                                  onPressed: () {
                                    _isBookmark = !_isBookmark;
                                    _isBookmarkStream.add(_isBookmark);
                                    storyBox.put("isBookmark-${widget.storyId}",
                                        _isBookmark);
                                  },
                                  icon: Icon(
                                    Icons.bookmark_add_outlined,
                                    color: _isBookmark
                                        ? themeMode(
                                            context, ColorCode.mainColor.name)
                                        : themeMode(
                                            context, ColorCode.textColor.name),
                                  )),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        width: MainSetting.getPercentageOfDevice(context,
                                expectWidth: 200)
                            .width,
                        child: ButtonWidget.buttonNavigatorNextPreviewLanding(
                            context,
                            ChapterContentOfStory(
                              reloadChapterId: _reloadChapterId,
                              author: storyInfo.authorName,
                              imageUrl: storyInfo.imgUrl,
                              chapterNumber:
                                  _chapterNumber == 0 ? 1 : _chapterNumber,
                              totalChapter: storyInfo.totalChapter,
                              pageIndex: _pageIndex,
                              loadSingleChapter: false,
                              isLoadHistory: true,
                              storyId: widget.storyId,
                              storyName: widget.storyTitle,
                              chapterId: _chapterId == 0
                                  ? storyInfo.firstChapterId
                                  : _chapterId,
                              lastChapterId: storyInfo.lastChapterId,
                              firstChapterId: storyInfo.firstChapterId,
                            ),
                            // Chapter(
                            //   author: storyInfo.authorName,
                            //   imageUrl: storyInfo.imgUrl,
                            //   chapterNumber:
                            //       _chapterNumber == 0 ? 1 : _chapterNumber,
                            //   totalChapter: storyInfo.totalChapter,
                            //   pageIndex: _pageIndex,
                            //   loadSingleChapter: false,
                            //   isLoadHistory: true,
                            //   storyId: widget.storyId,
                            //   storyName: widget.storyTitle,
                            //   chapterId: _chapterId == 0
                            //       ? storyInfo.firstChapterId
                            //       : _chapterId,
                            //   lastChapterId: storyInfo.lastChapterId,
                            //   firstChapterId: storyInfo.firstChapterId,
                            // ),
                            textStyle: CustomFonts.h5(context).copyWith(
                                color: themeMode(
                                    context, ColorCode.textColor.name),
                                fontWeight: FontWeight.w500),
                            color: themeMode(context, ColorCode.mainColor.name),
                            borderColor:
                                themeMode(context, ColorCode.mainColor.name),
                            widthBorder: 2,
                            isDisable: storyInfo.totalChapter == 0,
                            textDisplay: !(storyInfo.totalChapter == 0)
                                ? '${L(context, LanguageCodes.chapterNumberTextInfo.toString())} ${_chapterNumber == 0 ? 1 : _chapterNumber}'
                                : L(
                                    context,
                                    LanguageCodes.emptyChapterTextInfo
                                        .toString())),
                      )
                    ],
                  )),
                ),
              );
            }
            return const Center(child: CircularProgressIndicator());
          },
        ),
      ),
    );
  }
}
