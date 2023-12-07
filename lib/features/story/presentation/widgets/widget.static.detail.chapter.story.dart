import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/chapters/presentation/pages/page.model.chapter.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/static/buttons/widget.static.button.dart';
import 'package:muonroi/features/chapters/presentation/pages/page.model.list.chapter.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/chapters/bloc/latest_bloc/latest_chapter_of_story_bloc.dart';
import 'package:muonroi/features/story/data/models/model.single.story.dart';

typedef LatestChapter = void Function(String val);

class ChapterOfStory extends StatefulWidget {
  final int storyId;
  final StorySingleResult storyInfo;

  const ChapterOfStory(
      {super.key, required this.storyId, required this.storyInfo});

  @override
  State<ChapterOfStory> createState() => _ChapterOfStoryState();
}

class _ChapterOfStoryState extends State<ChapterOfStory> {
  @override
  void initState() {
    _reloadChapterId = StreamController<bool>();
    super.initState();
    _latestChapterOfStoryBloc =
        LatestChapterOfStoryBloc(widget.storyId, true, 1, 5, 0);
    _latestChapterOfStoryBloc.add(GetLatestChapterOfStoryList());
    _reloadChapterId.stream.listen((event) {
      if (event) {}
    });
  }

  @override
  void dispose() {
    _reloadChapterId.close();
    _latestChapterOfStoryBloc.close();
    super.dispose();
  }

  late LatestChapterOfStoryBloc _latestChapterOfStoryBloc;
  late StreamController<bool> _reloadChapterId;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => _latestChapterOfStoryBloc,
      child: BlocListener<LatestChapterOfStoryBloc, LatestChapterOfStoryState>(
        listener: (context, state) {
          const CircularProgressIndicator();
        },
        child: BlocBuilder<LatestChapterOfStoryBloc, LatestChapterOfStoryState>(
          builder: (context, state) {
            if (state is LatestChapterOfStoryLoadingState) {
              return const CircularProgressIndicator();
            }
            if (state is LatestChapterOfStoryLoadedState) {
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    child: Text(
                      L(context,
                          LanguageCodes.newChapterStoryTextInfo.toString()),
                      style: CustomFonts.h4(context),
                      textAlign: TextAlign.left,
                    ),
                  ),
                  SizedBox(
                    height: MainSetting.getPercentageOfDevice(context,
                            expectHeight:
                                state.chapter.result.items.length * 50)
                        .height,
                    child: ListView.builder(
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: state.chapter.result.items.length,
                        itemBuilder: ((context, index) {
                          final chapterItem = state.chapter.result.items[index];
                          return Stack(children: [
                            Container(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          "${L(context, LanguageCodes.chapterNumberTextInfo.toString()).replaceRange(0, 1, L(context, LanguageCodes.chapterNumberTextInfo.toString())[0].toUpperCase())} ${chapterItem.numberOfChapter.toString()}: ",
                                          style: CustomFonts.h5(context)
                                              .copyWith(
                                                  color: themeMode(
                                                      context,
                                                      ColorCode
                                                          .mainColor.name)),
                                        ),
                                      ),
                                      Container(
                                        padding: const EdgeInsets.all(4.0),
                                        width:
                                            MainSetting.getPercentageOfDevice(
                                                    context,
                                                    expectWidth: 220)
                                                .width,
                                        child: Text(
                                          chapterItem.chapterName.trim(),
                                          style: CustomFonts.h5(context),
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                  Icon(
                                    Icons.keyboard_arrow_right,
                                    color: themeMode(
                                        context, ColorCode.textColor.name),
                                  ),
                                ],
                              ),
                            ),
                            Positioned.fill(
                              child: Material(
                                color: Colors.transparent,
                                child: InkWell(
                                  onTap: () async {
                                    chapterBox.put(
                                        "story-${widget.storyId}-current-chapter-index",
                                        state
                                                    .chapter
                                                    .result
                                                    .items[state.chapter.result
                                                            .items.length -
                                                        1]
                                                    .numberOfChapter >
                                                100
                                            ? chapterItem
                                                    .totalChapterAtLastChunk -
                                                (index + 1)
                                            : chapterItem.numberOfChapter - 1);
                                    chapterBox.put(
                                        "story-${widget.storyId}-current-chapter-id",
                                        chapterItem.chapterId);
                                    chapterBox.put(
                                        "story-${widget.storyId}-current-chapter",
                                        chapterItem.numberOfChapter);
                                    chapterBox.put(
                                        "story-${widget.storyId}-current-page-index",
                                        widget.storyInfo.totalPageIndex);
                                    if (context.mounted) {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => NewChapter(
                                            author: widget.storyInfo.authorName,
                                            imageUrl: widget.storyInfo.imgUrl,
                                            chapterNumber:
                                                chapterItem.numberOfChapter,
                                            totalChapter:
                                                widget.storyInfo.totalChapter,
                                            pageIndex:
                                                widget.storyInfo.totalPageIndex,
                                            loadSingleChapter: true,
                                            isLoadHistory: true,
                                            storyId: widget.storyId,
                                            storyName:
                                                widget.storyInfo.storyTitle,
                                            chapterId: chapterItem.chapterId,
                                            lastChapterId:
                                                widget.storyInfo.lastChapterId,
                                            firstChapterId:
                                                widget.storyInfo.firstChapterId,
                                            reloadChapterId: _reloadChapterId,
                                          ),
                                        ),
                                      );
                                    }
                                  },
                                  child: Tooltip(
                                    onTriggered: () =>
                                        TooltipTriggerMode.longPress,
                                    message: chapterItem.chapterName,
                                    showDuration:
                                        const Duration(milliseconds: 1000),
                                  ),
                                ),
                              ),
                            )
                          ]);
                        })),
                  ),
                  Align(
                    alignment: Alignment.center,
                    child: SizedBox(
                      child: SizedBox(
                        width: MainSetting.getPercentageOfDevice(context,
                                expectWidth: 319)
                            .width,
                        height: MainSetting.getPercentageOfDevice(context,
                                expectHeight: 40)
                            .height,
                        child: ButtonWidget.buttonNavigatorNextPreviewLanding(
                            context,
                            ChapterListPage(
                              author: widget.storyInfo.authorName,
                              chapterCallback: null,
                              isAudio: false,
                              storyImageUrl: widget.storyInfo.imgUrl,
                              totalChapter: widget.storyInfo.totalChapter,
                              storyId: widget.storyId,
                              storyTitle: widget.storyInfo.storyTitle,
                              lastChapterId: widget.storyInfo.lastChapterId,
                              firstChapterId: widget.storyInfo.firstChapterId,
                            ),
                            textStyle: CustomFonts.h5(context).copyWith(
                                color: themeMode(
                                    context, ColorCode.mainColor.name),
                                fontWeight: FontWeight.w600),
                            color: themeMode(context, ColorCode.modeColor.name),
                            borderColor:
                                themeMode(context, ColorCode.mainColor.name),
                            widthBorder: 1,
                            textDisplay: L(
                                context,
                                LanguageCodes.listChapterStoryTextInfo
                                    .toString())),
                      ),
                    ),
                  )
                ],
              );
            }
            if (state is LatestChapterOfStoryNoDataState) {
              return Container();
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
