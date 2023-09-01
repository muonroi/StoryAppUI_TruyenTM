import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/shared/static/buttons/widget.static.button.dart';
import 'package:muonroi/features/chapters/presentation/pages/widget.static.model.chapter.dart';
import 'package:muonroi/features/chapters/presentation/pages/widget.static.model.list.chapter.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/core/localization/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/chapters/bloc/latest_bloc/latest_chapter_of_story_bloc.dart';
import 'package:muonroi/features/stories/data/models/models.single.story.dart';

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
    colorOfRow = List<Color>.filled(5, Colors.white);
    _latestChapterOfStoryBloc =
        LatestChapterOfStoryBloc(widget.storyId, true, 1, 5, 0);
    _latestChapterOfStoryBloc.add(GetLatestChapterOfStoryList());
    super.initState();
  }

  @override
  void dispose() {
    _latestChapterOfStoryBloc.close();
    super.dispose();
  }

  List<Color> colorOfRow = [];
  late LatestChapterOfStoryBloc _latestChapterOfStoryBloc;
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
                      L(ViCode.newChapterStoryTextInfo.toString()),
                      style: FontsDefault.h4,
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
                          return AnimatedContainer(
                            padding: const EdgeInsets.symmetric(vertical: 10.0),
                            color: colorOfRow[index],
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.linear,
                            child: Stack(children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Row(
                                    children: [
                                      Container(
                                        margin:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Text(
                                          "${L(ViCode.chapterNumberTextInfo.toString()).replaceRange(0, 1, L(ViCode.chapterNumberTextInfo.toString())[0].toUpperCase())} ${chapterItem.numberOfChapter.toString()}: ",
                                          style: FontsDefault.h5.copyWith(
                                              color: ColorDefaults.mainColor),
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
                                          style: FontsDefault.h5,
                                          overflow: TextOverflow.ellipsis,
                                          maxLines: 1,
                                          textAlign: TextAlign.start,
                                        ),
                                      ),
                                    ],
                                  ),
                                  const Icon(
                                    Icons.keyboard_arrow_right,
                                    color: ColorDefaults.thirdMainColor,
                                  ),
                                ],
                              ),
                              Positioned.fill(
                                child: Material(
                                  color: Colors.transparent,
                                  child: InkWell(
                                    onTap: () async {
                                      Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) => Chapter(
                                            isLoadHistory: true,
                                            storyId: widget.storyId,
                                            storyName:
                                                widget.storyInfo.storyTitle,
                                            chapterId: chapterItem.chapterId,
                                            lastChapterId:
                                                widget.storyInfo.lastChapterId,
                                            firstChapterId:
                                                widget.storyInfo.firstChapterId,
                                          ),
                                        ),
                                      );
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
                            ]),
                          );
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
                              storyId: widget.storyId,
                              storyTitle: widget.storyInfo.storyTitle,
                              lastChapterId: widget.storyInfo.lastChapterId,
                              firstChapterId: widget.storyInfo.firstChapterId,
                            ),
                            textStyle: FontsDefault.h5.copyWith(
                                color: ColorDefaults.mainColor,
                                fontWeight: FontWeight.w600),
                            color: ColorDefaults.lightAppColor,
                            borderColor: ColorDefaults.mainColor,
                            widthBorder: 1,
                            textDisplay:
                                L(ViCode.listChapterStoryTextInfo.toString())),
                      ),
                    ),
                  )
                ],
              );
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
