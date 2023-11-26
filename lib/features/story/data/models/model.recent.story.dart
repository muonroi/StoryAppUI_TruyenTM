import 'dart:convert';

StoryRecent recentStoryModelFromJson(String str) =>
    StoryRecent.fromJson(json.decode(str));

String recentStoryModelToJson(StoryRecent data) => json.encode(data.toJson());

class StoryRecent {
  final bool loadSingleChapter;
  final int storyId;
  final String storyName;
  final int chapterId;
  final int lastChapterId;
  final int firstChapterId;
  final bool isLoadHistory;
  final int pageIndex;
  final int totalChapter;
  final int chapterNumber;
  final String imageStory;
  const StoryRecent({
    required this.storyId,
    required this.storyName,
    required this.chapterId,
    required this.lastChapterId,
    required this.firstChapterId,
    required this.isLoadHistory,
    required this.loadSingleChapter,
    required this.pageIndex,
    required this.totalChapter,
    required this.chapterNumber,
    required this.imageStory,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'loadSingleChapter': loadSingleChapter,
      'storyId': storyId,
      'storyName': storyName,
      'chapterId': chapterId,
      'lastChapterId': lastChapterId,
      'firstChapterId': firstChapterId,
      'isLoadHistory': isLoadHistory,
      'pageIndex': pageIndex,
      'totalChapter': totalChapter,
      'chapterNumber': chapterNumber,
      'imageStory': imageStory,
    };
  }

  factory StoryRecent.fromMap(Map<String, dynamic> map) {
    return StoryRecent(
      loadSingleChapter: map['loadSingleChapter'] as bool,
      storyId: map['storyId'] as int,
      storyName: map['storyName'] as String,
      chapterId: map['chapterId'] as int,
      lastChapterId: map['lastChapterId'] as int,
      firstChapterId: map['firstChapterId'] as int,
      isLoadHistory: map['isLoadHistory'] as bool,
      pageIndex: map['pageIndex'] as int,
      totalChapter: map['totalChapter'] as int,
      chapterNumber: map['chapterNumber'] as int,
      imageStory: map['imageStory'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory StoryRecent.fromJson(String source) =>
      StoryRecent.fromMap(json.decode(source) as Map<String, dynamic>);
}
