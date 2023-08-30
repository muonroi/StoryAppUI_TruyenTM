import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/chapters/presentation/pages/widget.static.model.chapter.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/chapters/bloc/group_bloc/group_chapters_of_story_bloc.dart';
import 'package:muonroi/features/chapters/bloc/latest_bloc/latest_chapter_of_story_bloc.dart';

class ChapterListPage extends StatefulWidget {
  final int storyId;
  final String storyTitle;
  final int lastChapterId;
  final int firstChapterId;
  const ChapterListPage(
      {super.key,
      required this.storyId,
      required this.storyTitle,
      required this.lastChapterId,
      required this.firstChapterId});

  @override
  State<ChapterListPage> createState() => _ChapterListPageState();
}

class _ChapterListPageState extends State<ChapterListPage>
    with SingleTickerProviderStateMixin {
  @override
  void initState() {
    _animationSortController = AnimationController(
        vsync: this,
        duration: const Duration(milliseconds: 300),
        upperBound: .5);
    _groupChapterOfStoryBloc =
        GroupChapterOfStoryBloc(widget.storyId, 1, 15, false, 0);
    _groupChapterOfStoryBloc.add(GroupChapterOfStoryList());
    _latestChapterOfStoryBloc =
        LatestChapterOfStoryBloc(widget.storyId, false, 1, 100, 0);
    _latestChapterOfStoryBloc.add(GetFromToChapterOfStoryList(
        fromChapterId: fromChapterId, toChapterId: toChapterId));
    super.initState();
  }

  @override
  void dispose() {
    _groupChapterOfStoryBloc.close();
    _latestChapterOfStoryBloc.close();
    super.dispose();
  }

  late AnimationController _animationSortController;
  late GroupChapterOfStoryBloc _groupChapterOfStoryBloc;
  late LatestChapterOfStoryBloc _latestChapterOfStoryBloc;
  final ScrollController _controller = ScrollController();
  List<GlobalKey> chapterPagingKeys = [];
  late bool isShort = false;
  late int fromChapterId = 1;
  late int toChapterId = 100;
  int selectedItemIndex = 0;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: ColorDefaults.lightAppColor,
          elevation: 0,
          leading: IconButton(
            onPressed: () => Navigator.pop(context),
            icon: const Icon(Icons.arrow_back_ios),
            color: ColorDefaults.thirdMainColor,
          ),
          title: Title(
              color: ColorDefaults.lightAppColor,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    L(ViCode.listChapterStoryTextInfo.toString()),
                    style:
                        FontsDefault.h5.copyWith(fontWeight: FontWeight.w600),
                  ),
                  Stack(children: [
                    Text(
                      widget.storyTitle,
                      style: FontsDefault.h6.copyWith(fontSize: 13),
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                    showToolTip(widget.storyTitle)
                  ]),
                ],
              )),
        ),
        body: Column(
          children: [
            SizedBox(
              height:
                  MainSetting.getPercentageOfDevice(context, expectHeight: 50)
                      .height,
              child:
                  Row(crossAxisAlignment: CrossAxisAlignment.start, children: [
                Expanded(
                    flex: 1,
                    child: RotationTransition(
                      turns: Tween(
                        begin: 0.0,
                        end: 1.0,
                      ).animate(_animationSortController),
                      child: IconButton(
                          onPressed: () {
                            if (isShort) {
                              _animationSortController.reverse(from: 0.5);
                            } else {
                              _animationSortController.forward(from: 0.0);
                            }
                            isShort = !isShort;
                          },
                          icon: const Icon(
                            Icons.sort,
                            color: ColorDefaults.thirdMainColor,
                          )),
                    )),
                BlocProvider(
                  create: (context) => _groupChapterOfStoryBloc,
                  child: BlocListener<GroupChapterOfStoryBloc,
                      GroupChapterOfStoryState>(
                    listener: (context, state) {
                      const Center(child: CircularProgressIndicator());
                    },
                    child: BlocBuilder<GroupChapterOfStoryBloc,
                        GroupChapterOfStoryState>(
                      builder: (context, state) {
                        if (state is GroupChapterOfStoryLoadingState) {
                          return const Center(
                              child: CircularProgressIndicator());
                        }
                        if (state is GroupChapterOfStoryLoadedState) {
                          for (int i = 0;
                              i < state.chapter.result.length;
                              i++) {
                            chapterPagingKeys.add(GlobalKey());
                          }
                          WidgetsBinding.instance.addPostFrameCallback((_) {
                            setState(() {
                              fromChapterId = state.chapter.result[0].fromId;
                              toChapterId = state.chapter.result[0].toId;
                            });
                          });
                          return Expanded(
                              flex: 4,
                              child: ListView.builder(
                                  controller: _controller,
                                  scrollDirection: Axis.horizontal,
                                  itemCount: state.chapter.result.length,
                                  itemBuilder: ((context, index) {
                                    var chapterPagingInfo =
                                        state.chapter.result[index];
                                    return InkWell(
                                      splashColor: ColorDefaults.mainColor
                                          .withOpacity(0.5),
                                      onTap: () async {
                                        WidgetsBinding.instance
                                            .addPostFrameCallback((_) {
                                          setState(() {
                                            selectedItemIndex = index;
                                            _latestChapterOfStoryBloc.add(
                                                GetFromToChapterOfStoryList(
                                                    fromChapterId:
                                                        chapterPagingInfo
                                                            .fromId,
                                                    toChapterId:
                                                        chapterPagingInfo
                                                            .toId));
                                          });
                                        });
                                        await scrollItem(index);
                                      },
                                      borderRadius: BorderRadius.circular(16.0),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Container(
                                              key: chapterPagingKeys[index],
                                              margin:
                                                  const EdgeInsets.all(16.0),
                                              child: selectedItemIndex == index
                                                  ? Text(
                                                      '${chapterPagingInfo.from}-${chapterPagingInfo.to}',
                                                      style: const TextStyle(
                                                          color: ColorDefaults
                                                              .mainColor),
                                                      textAlign:
                                                          TextAlign.center,
                                                    )
                                                  : Text(
                                                      '${chapterPagingInfo.from}-${chapterPagingInfo.to}',
                                                      textAlign:
                                                          TextAlign.center,
                                                    ))
                                        ],
                                      ),
                                    );
                                  })));
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ),
              ]),
            ),
            BlocProvider(
              create: (context) => _latestChapterOfStoryBloc,
              child: BlocListener<LatestChapterOfStoryBloc,
                  LatestChapterOfStoryState>(
                listener: (context, state) {
                  const Center(
                    child: CircularProgressIndicator(),
                  );
                },
                child: BlocBuilder<LatestChapterOfStoryBloc,
                    LatestChapterOfStoryState>(
                  builder: (context, state) {
                    if (state is FromToChapterOfStoryLoadingState) {
                      return const Center(
                        child: CircularProgressIndicator(),
                      );
                    }
                    if (state is FromToChapterOfStoryLoadedState) {
                      return Expanded(
                          child: ListView.builder(
                        itemCount: state.chapter.result.length,
                        itemBuilder: ((context, index) {
                          if (!isShort) {
                            state.chapter.result.sort((a, b) =>
                                a.numberOfChapter.compareTo(b.numberOfChapter));
                          }
                          if (isShort) {
                            state.chapter.result.sort((a, b) =>
                                b.numberOfChapter.compareTo(a.numberOfChapter));
                          }
                          var chapterInfo = state.chapter.result[index];

                          return Container(
                            margin:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Column(
                              children: [
                                InkWell(
                                  onTap: () => Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => Chapter(
                                            isLoadHistory: false,
                                            storyId: chapterInfo.storyId,
                                            storyName: widget.storyTitle,
                                            chapterId: chapterInfo.id,
                                            lastChapterId: widget.lastChapterId,
                                            firstChapterId:
                                                widget.firstChapterId),
                                      )),
                                  child: Container(
                                    margin: const EdgeInsets.symmetric(
                                        vertical: 8.0),
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                          vertical: 8.0),
                                      decoration: const BoxDecoration(
                                          border: Border(
                                              bottom: BorderSide(
                                                  style: BorderStyle.solid,
                                                  width: 0.2))),
                                      child: Row(
                                        children: [
                                          SizedBox(
                                            width: MainSetting
                                                    .getPercentageOfDevice(
                                                        context,
                                                        expectWidth: 40)
                                                .width,
                                            child: Text(
                                                '${chapterInfo.numberOfChapter}'),
                                          ),
                                          SizedBox(
                                            width: MainSetting
                                                    .getPercentageOfDevice(
                                                        context,
                                                        expectWidth: 300)
                                                .width,
                                            child: Text(
                                              chapterInfo.chapterTitle
                                                  .trim()
                                                  .replaceAll('\n', '')
                                                  .replaceAll(
                                                      RegExp(r'Chương \d+: '),
                                                      '')
                                                  .replaceAll(
                                                      RegExp(r'chương \d+: '),
                                                      ''),
                                              style: FontsDefault.h5,
                                              overflow: TextOverflow.ellipsis,
                                              maxLines: 1,
                                              textAlign: TextAlign.left,
                                            ),
                                          ),
                                          const SizedBox(
                                            child: Icon(
                                              size: 15,
                                              Icons.arrow_forward_ios,
                                              color:
                                                  ColorDefaults.thirdMainColor,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                )
                              ],
                            ),
                          );
                        }),
                      ));
                    }
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  },
                ),
              ),
            )
          ],
        ));
  }

  Future scrollItem(int index) async {
    await Scrollable.ensureVisible(chapterPagingKeys[index].currentContext!,
        alignment: 0.5, duration: const Duration(milliseconds: 300));
  }
}
