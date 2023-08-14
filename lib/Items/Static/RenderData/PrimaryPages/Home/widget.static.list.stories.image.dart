import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Models/Users/widget.static.story.user.coin.dart';
import 'package:muonroi/Models/Users/widget.static.user.comment.dart';

class StoriesImageIncludeSizeBox extends StatelessWidget {
  final String storyId;
  final String nameStory;
  final String authorName;
  final String imageLink;
  final List<String> tagsName;
  final String categoryName;
  final double numberOfChapter;
  final String lastUpdated;
  final int totalViews;
  final int rankNumber;
  final double vote;
  final int totalVote;
  final String notification;
  final String introStory;
  final List<double> newChapters;
  final List<String> newChapterNames;
  final List<UserCommentModel> userComments;
  final List<UserCoin> userCoin;
  final List<StoryItems> similarStories;
  final String guid;
  final bool isShow;
  final String slug;
  final int totalChapters;
  const StoriesImageIncludeSizeBox(
      {super.key,
      required this.imageLink,
      required this.storyId,
      required this.nameStory,
      required this.authorName,
      required this.tagsName,
      required this.categoryName,
      required this.numberOfChapter,
      required this.lastUpdated,
      required this.totalViews,
      required this.rankNumber,
      required this.vote,
      required this.totalVote,
      required this.notification,
      required this.introStory,
      required this.newChapters,
      required this.newChapterNames,
      required this.userComments,
      required this.userCoin,
      required this.similarStories,
      required this.guid,
      required this.isShow,
      required this.slug,
      required this.totalChapters});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        child: CachedNetworkImage(
      imageUrl: imageLink,
      progressIndicatorBuilder: (context, url, downloadProgress) =>
          CircularProgressIndicator(value: downloadProgress.progress),
      errorWidget: (context, url, error) => const Icon(Icons.error),
      fit: BoxFit.cover,
    ));
  }
}
