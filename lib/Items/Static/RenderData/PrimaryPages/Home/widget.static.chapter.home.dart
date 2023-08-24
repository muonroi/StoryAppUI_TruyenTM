import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:muonroi/Items/Static/RenderData/Shared/widget.static.model.chapter.dart';
import 'package:muonroi/blocs/Chapters/latest_bloc/latest_chapter_of_story_bloc.dart';
import '../../../../../Settings/settings.fonts.dart';
import '../../../../../Settings/settings.images.dart';
import '../../../../../Settings/settings.language_code.vi..dart';
import '../../../../../Settings/settings.main.dart';

class ListNewChapter extends StatefulWidget {
  const ListNewChapter({
    super.key,
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
                                                ImageDefault.bookBookmark2x,
                                                fit: BoxFit.cover),
                                          ),
                                          Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              TextButton(
                                                  onPressed: null,
                                                  child: RichText(
                                                      text: TextSpan(
                                                    text: chapterInfo
                                                        .chapterTitle,
                                                    style: FontsDefault.h5,
                                                    children: <InlineSpan>[
                                                      const TextSpan(
                                                          text:
                                                              '\n'), // Add a line break
                                                      WidgetSpan(
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                      .only(
                                                                  left: 8.0),
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
                                                            style: FontsDefault
                                                                .h6
                                                                .copyWith(
                                                                    fontSize:
                                                                        11,
                                                                    fontStyle:
                                                                        FontStyle
                                                                            .italic),
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ))),
                                            ],
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
                                                    '${L(ViCode.chapterNumberTextInfo.toString())} ${chapterInfo.numberOfChapter}',
                                                    style: FontsDefault.h5,
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
                                          var storyInfo = await getInfoStory(
                                            chapterInfo.storyId,
                                          );
                                          if (context.mounted) {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) => Chapter(
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
