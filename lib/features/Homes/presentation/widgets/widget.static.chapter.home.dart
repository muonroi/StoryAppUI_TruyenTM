import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:muonroi/features/chapters/presentation/pages/page.model.chapter.dart';
import 'package:muonroi/features/story/data/repositories/story.repository.dart';
import 'package:muonroi/shared/settings/enums/theme/enum.code.color.theme.dart';
import 'package:muonroi/shared/settings/setting.fonts.dart';
import 'package:muonroi/shared/settings/setting.images.dart';
import 'package:muonroi/core/localization/settings.language.code.dart';
import 'package:muonroi/shared/settings/setting.main.dart';
import 'package:muonroi/features/chapters/bloc/latest_bloc/latest_chapter_of_story_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ListNewChapter extends StatefulWidget {
  final String author;
  const ListNewChapter({
    super.key,
    required this.author,
  });

  @override
  State<ListNewChapter> createState() => _ListNewChapterState();
}

class _ListNewChapterState extends State<ListNewChapter> {
  @override
  void initState() {
    latestChapterOfStoryBloc = LatestChapterOfStoryBloc(0, true, 1, 7, 0);
    latestChapterOfStoryBloc.add(GetAnyLatestChapterList());
    super.initState();
  }

  @override
  void dispose() {
    latestChapterOfStoryBloc.close();
    super.dispose();
  }

  late LatestChapterOfStoryBloc latestChapterOfStoryBloc;
  final StoryRepository storyRepository = StoryRepository();
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: BlocProvider(
          create: (context) => latestChapterOfStoryBloc,
          child:
              BlocListener<LatestChapterOfStoryBloc, LatestChapterOfStoryState>(
            listener: (context, state) {
              const Center(child: CircularProgressIndicator());
            },
            child: BlocBuilder<LatestChapterOfStoryBloc,
                LatestChapterOfStoryState>(
              builder: (context, state) {
                if (state is AnyLatestChapterOfStoryLoadingState) {
                  return const Center(child: CircularProgressIndicator());
                }
                if (state is AnyLatestChapterOfStoryLoadedState) {
                  return SizedBox(
                      height: MainSetting.getPercentageOfDevice(context,
                              expectHeight:
                                  state.chapter.result.items.length * 63.2)
                          .height,
                      child: ListView.builder(
                          primary: false,
                          physics: const NeverScrollableScrollPhysics(),
                          itemExtent: 60,
                          itemCount: state.chapter.result.items.length,
                          itemBuilder: (context, index) {
                            var chapterInfo = state.chapter.result.items[index];
                            return Column(
                              children: [
                                Stack(children: [
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            width: MainSetting
                                                    .getPercentageOfDevice(
                                                        context,
                                                        expectHeight: 20,
                                                        expectWidth: 20)
                                                .width,
                                            height: MainSetting
                                                    .getPercentageOfDevice(
                                                        context,
                                                        expectHeight: 20,
                                                        expectWidth: 20)
                                                .height,
                                            child: Image.asset(
                                              CustomImages.bookBookmark2x,
                                              fit: BoxFit.cover,
                                              color: themeMode(context,
                                                  ColorCode.textColor.name),
                                            ),
                                          ),
                                          SizedBox(
                                            width: MainSetting
                                                    .getPercentageOfDevice(
                                                        context,
                                                        expectWidth: 180)
                                                .width,
                                            child: Column(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                TextButton(
                                                    onPressed: null,
                                                    child: RichText(
                                                        overflow: TextOverflow
                                                            .ellipsis,
                                                        text: TextSpan(
                                                          text: chapterInfo
                                                              .chapterTitle
                                                              .capitalize(),
                                                          style: CustomFonts.h5(
                                                              context),
                                                          children: <InlineSpan>[
                                                            const TextSpan(
                                                                text:
                                                                    '\n'), // Add a line break
                                                            WidgetSpan(
                                                              child: Padding(
                                                                padding:
                                                                    const EdgeInsets
                                                                        .only(
                                                                        left:
                                                                            8.0),
                                                                child: Text(
                                                                  DateFormat(
                                                                          'dd/MM - HH:mm')
                                                                      .format(
                                                                    DateTime
                                                                        .fromMillisecondsSinceEpoch(
                                                                      chapterInfo
                                                                              .updatedDateTs *
                                                                          1000,
                                                                    ).toLocal(),
                                                                  ),
                                                                  style: CustomFonts.h6(
                                                                          context)
                                                                      .copyWith(
                                                                          fontSize:
                                                                              11,
                                                                          fontStyle:
                                                                              FontStyle.italic),
                                                                ),
                                                              ),
                                                            ),
                                                          ],
                                                        ))),
                                              ],
                                            ),
                                          )
                                        ],
                                      ),
                                      SizedBox(
                                        width:
                                            MainSetting.getPercentageOfDevice(
                                                    context,
                                                    expectWidth: 130)
                                                .width,
                                        child: Align(
                                          alignment: Alignment.centerLeft,
                                          child: Row(
                                            children: [
                                              TextButton(
                                                  onPressed: null,
                                                  child: Text(
                                                    '${L(context, LanguageCodes.chapterNumberTextInfo.toString())} ${chapterInfo.numberOfChapter}',
                                                    style:
                                                        CustomFonts.h5(context),
                                                    textAlign: TextAlign.left,
                                                  )),
                                            ],
                                          ),
                                        ),
                                      )
                                    ],
                                  ),
                                  Positioned.fill(
                                    child: Material(
                                      color: Colors.transparent,
                                      child: InkWell(
                                        onTap: () async {
                                          var storyInfo = await storyRepository
                                              .fetchDetailStory(
                                            chapterInfo.storyId,
                                          );
                                          var sharePreferences =
                                              await SharedPreferences
                                                  .getInstance();
                                          sharePreferences.setInt(
                                              "story-${storyInfo.result.id}-current-page-index",
                                              storyInfo.result.totalPageIndex ==
                                                      0
                                                  ? 1
                                                  : storyInfo
                                                      .result.totalPageIndex);
                                          sharePreferences.setInt(
                                              "story-${storyInfo.result.id}-current-chapter-index",
                                              index);
                                          sharePreferences.setInt(
                                              "story-${storyInfo.result.id}-current-chapter-id",
                                              chapterInfo.id);
                                          sharePreferences.setInt(
                                              "story-${storyInfo.result.id}-current-chapter",
                                              chapterInfo.numberOfChapter);
                                          if (context.mounted) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Chapter(
                                                  author: widget.author,
                                                  imageUrl: '',
                                                  totalChapter: storyInfo
                                                      .result.totalChapter,
                                                  chapterNumber: chapterInfo
                                                      .numberOfChapter,
                                                  pageIndex: 1,
                                                  loadSingleChapter: false,
                                                  isLoadHistory: true,
                                                  storyId: chapterInfo.storyId,
                                                  storyName: storyInfo
                                                      .result.storyTitle,
                                                  chapterId: chapterInfo.id,
                                                  lastChapterId: storyInfo
                                                      .result.lastChapterId,
                                                  firstChapterId: storyInfo
                                                      .result.firstChapterId,
                                                ),
                                              ),
                                            );
                                          }
                                        },
                                        child: Tooltip(
                                          onTriggered: () =>
                                              TooltipTriggerMode.longPress,
                                          message: chapterInfo.chapterTitle,
                                          showDuration: const Duration(
                                              milliseconds: 1000),
                                        ),
                                      ),
                                    ),
                                  )
                                ]),
                              ],
                            );
                          }));
                }
                return const Center(child: CircularProgressIndicator());
              },
            ),
          ),
        ));
  }
}
