import 'dart:async';
import 'package:muonroi/Models/Stories/models.single.story.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/Enums/enum.search.story.dart';
import 'package:muonroi/resource/api_story_provider.dart';

class StoryRepository {
  final _provider = StoryProvider();
  StoryRepository();
  Future<StoriesModel> fetchStoriesData(int pageIndex, int pageSize) =>
      _provider.getStoriesDataList(pageIndex, pageSize);
  Future<StoriesModel> fetchRecommendStories(
          int storyId, int pageIndex, int pageSize) =>
      _provider.getStoriesRecommendList(storyId, pageIndex, pageSize);
  Future<SingleStoryModel> fetchDetailStory(int storyId) =>
      _provider.getDetailStoryList(storyId);
  Future<bool> voteStory(int storyId, double voteNumber) =>
      _provider.voteStory(storyId, voteNumber);
  Future<StoriesModel> searchStory(List<String> keySearch,
          List<SearchType> type, int pageIndex, int pageSize) =>
      _provider.searchStory(keySearch, type, pageIndex, pageSize);
}

class NetworkError extends Error {}
