import 'package:muonroi/Models/Users/widget.static.story.user.coin.dart';

import '../Users/widget.static.user.comment.dart';

class StoryModel {
  late String name;
  late String? category;
  late double? totalView;
  late String image;
  late String? authorName;
  late int? lastUpdated;
  late List<String>? tagsName;
  late double? numberOfChapter;
  late int? rankNumber;
  late double? vote;
  late int? totalVote;
  late String? notification;
  late String? introStory;
  late List<double>? newChapters;
  late List<String>? newChapterNames;
  late List<UserCommentModel>? userComments;
  late List<UserCoin>? userCoin;
  late List<StoryModel>? similarStories;
  StoryModel(
      {required this.image,
      required this.name,
      this.category,
      this.totalView,
      this.authorName,
      this.tagsName,
      this.numberOfChapter,
      this.lastUpdated,
      this.rankNumber,
      this.vote,
      this.totalVote,
      this.notification,
      this.introStory,
      this.newChapters,
      this.newChapterNames,
      this.userComments,
      this.userCoin,
      this.similarStories});
}
