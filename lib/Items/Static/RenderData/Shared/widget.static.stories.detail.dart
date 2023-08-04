import 'package:flutter/material.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.colors.dart';
import 'package:muonroi/Settings/settings.language_code.vi..dart';
import 'package:muonroi/Settings/settings.main.dart';
import 'DetailStory/widget.static..detail.chapter.story.dart';
import 'DetailStory/widget.static.detail.comment.story.dart';
import 'DetailStory/widget.static.detail.header.story.dart';
import 'DetailStory/widget.static.detail.intro.notify.story.dart';
import 'DetailStory/widget.static.detail.more.info.story.dart';
import 'DetailStory/widget.static.detail.recharge.story.dart';
import 'DetailStory/widget.static.detail.similar.story.dart';

class StoriesDetail extends StatefulWidget {
  final StoryModel storyInfo;
  const StoriesDetail({
    Key? key,
    required this.storyInfo,
  }) : super(key: key);

  @override
  State<StoriesDetail> createState() => _StoriesDetailState();
}

class _StoriesDetailState extends State<StoriesDetail> {
  @override
  Widget build(BuildContext context) {
    List<Widget> componentOfDetailStory = [
      Header(widget: widget.storyInfo),
      MoreInfoStory(widget: widget.storyInfo),
      IntroAndNotificationStory(
        name: L(ViCode.introStoryTextInfo.toString()),
        value: widget.storyInfo.introStory ?? "",
      ),
      IntroAndNotificationStory(
        name: L(ViCode.notifyStoryTextInfo.toString()),
        value: widget.storyInfo.notification ?? "",
      ),
      ChapterOfStory(
        widget: widget.storyInfo,
      ),
      CommentOfStory(
        widget: widget.storyInfo,
      ),
      RechargeStory(
        widget: widget.storyInfo,
      ),
      SimilarStories(
        widget: widget.storyInfo,
      )
    ];
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
          itemCount: componentOfDetailStory.length,
          itemBuilder: (context, index) {
            return Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [componentOfDetailStory[index]],
                ));
          },
        ),
      ),
    );
  }
}