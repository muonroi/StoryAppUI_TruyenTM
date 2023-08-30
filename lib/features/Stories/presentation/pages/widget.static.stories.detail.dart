import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/stories/presentation/widgets/widget.static.detail.more.info.story.dart';
import 'package:muonroi/features/stories/presentation/widgets/widget.static.detail.similar.story.dart';
import 'package:muonroi/shared/static/buttons/widget.static.button.dart';
import 'package:muonroi/features/chapters/presentation/pages/widget.static.model.chapter.dart';
import 'package:muonroi/shared/settings/settings.colors.dart';
import 'package:muonroi/shared/settings/settings.fonts.dart';
import 'package:muonroi/shared/settings/settings.language_code.vi..dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/stories/bloc/DetailData/detail_bloc.dart';
import 'package:muonroi/features/stories/presentation/widgets/widget.static..detail.chapter.story.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/widget.static.detail.header.story.dart';
import '../widgets/widget.static.detail.intro.notify.story.dart';

class StoriesDetail extends StatefulWidget {
  final int storyId;
  final String storyTitle;
  const StoriesDetail({
    Key? key,
    required this.storyId,
    required this.storyTitle,
  }) : super(key: key);
  @override
  State<StoriesDetail> createState() => _StoriesDetailState();
}

class _StoriesDetailState extends State<StoriesDetail> {
  @override
  void initState() {
    detailStory = DetailStoryPageBloc(widget.storyId);
    detailStory.add(GetDetailStory());
    super.initState();
  }

  @override
  void dispose() {
    detailStory.close();
    super.dispose();
  }

  late DetailStoryPageBloc detailStory;
  final Future<SharedPreferences> sharedPreferences =
      SharedPreferences.getInstance();

  Future<void> getChapterId() async {
    final SharedPreferences chapterTemp = await sharedPreferences;
    setState(() {
      chapterId =
          (chapterTemp.getInt("story-${widget.storyId}-current-chapter-id") ??
              0);
      chapterNumber =
          (chapterTemp.getInt("story-${widget.storyId}-current-chapter") ?? 0);
    });
  }

  late int chapterId = 0;
  late int chapterNumber = 0;
  @override
  Widget build(BuildContext context) {
    getChapterId();
    // #region not use now
    // List<Widget> componentOfDetailStory = [
    //   Header(infoStory: widget.storyInfo),
    //   MoreInfoStory(infoStory: widget.storyInfo),
    //   IntroAndNotificationStory(
    //     name: L(ViCode.introStoryTextInfo.toString()),
    //     value: widget.storyInfo.storySynopsis,
    //   ),
    //   // IntroAndNotificationStory(
    //   //   name: L(ViCode.notifyStoryTextInfo.toString()),
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
      create: (context) => detailStory,
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
                  backgroundColor: ColorDefaults.lightAppColor,
                  leading: const BackButton(
                    color: ColorDefaults.thirdMainColor,
                  ),
                ),
                backgroundColor: ColorDefaults.lightAppColor,
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
                              name: L(ViCode.introStoryTextInfo.toString()),
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
                  child: SizedBox(
                      child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        width: MainSetting.getPercentageOfDevice(context,
                                expectWidth: 200)
                            .width,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            SizedBox(
                                child: IconButton(
                                    onPressed: () {},
                                    icon:
                                        const Icon(Icons.headphones_outlined))),
                            SizedBox(
                              child: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(Icons.download_outlined)),
                            ),
                            SizedBox(
                              child: IconButton(
                                  onPressed: () {},
                                  icon:
                                      const Icon(Icons.bookmark_add_outlined)),
                            ),
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12.0),
                        child: SizedBox(
                          width: MainSetting.getPercentageOfDevice(context,
                                  expectWidth: 150)
                              .width,
                          child: ButtonWidget.buttonNavigatorNextPreviewLanding(
                              context,
                              Chapter(
                                isLoadHistory: true,
                                storyId: widget.storyId,
                                storyName: widget.storyTitle,
                                chapterId: chapterId == 0
                                    ? storyInfo.firstChapterId
                                    : chapterId,
                                lastChapterId: storyInfo.lastChapterId,
                                firstChapterId: storyInfo.firstChapterId,
                              ),
                              textStyle: FontsDefault.h5.copyWith(
                                  color: ColorDefaults.thirdMainColor,
                                  fontWeight: FontWeight.w500),
                              color: ColorDefaults.mainColor,
                              borderColor: ColorDefaults.mainColor,
                              widthBorder: 2,
                              textDisplay:
                                  '${L(ViCode.chapterNumberTextInfo.toString())} ${chapterNumber == 0 ? 1 : chapterNumber}'),
                        ),
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
