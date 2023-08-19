import 'dart:async';
import 'package:muonroi/Models/Stories/models.single.story.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/resource/api_story_provider.dart';

class StoryRepository {
  final _provider = StoryProvider();
  final int pageIndex;
  final int pageSize;
  StoryRepository({required this.pageIndex, required this.pageSize});
  Future<StoriesModel> fetchStoriesData(pageIndex, pageSize) =>
      _provider.getStoriesDataList(pageIndex, pageSize);
  Future<StoriesModel> fetchRecommendStories(int storyId) =>
      _provider.getStoriesRecommendList(storyId, pageIndex, pageSize);
  Future<SingleStoryModel> fetchDetailStory(int storyId) =>
      _provider.getDetailStoryList(storyId);
  Future<bool> voteStory(int storyId, double voteNumber) =>
      _provider.voteStory(storyId, voteNumber);
  Future<StoriesModel> searchStory(String keySearch) =>
      _provider.searchStory(keySearch);
}

class NetworkError extends Error {}
