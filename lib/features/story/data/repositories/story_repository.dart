import 'dart:async';
import 'package:muonroi/shared/settings/enums/enum.search.story.dart';
import 'package:muonroi/features/story/data/services/api.story.service.dart';
import 'package:muonroi/features/story/data/models/models.single.story.dart';
import 'package:muonroi/features/story/data/models/models.stories.story.dart';

class StoryRepository {
  final _provider = StoryService();
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

  Future<bool> bookmarkStory(int storyId) =>
      _provider.createBookmarkStory(storyId);

  Future<bool> deleteBookmarkStory(int bookmarkId) =>
      _provider.deleteBookmarkStory(bookmarkId);

  Future<bool> createStoryForUser(int storyId, int type, int currentIndex,
          int pageIndex, int numberChapter, double locationChapter) =>
      _provider.createStoryForUser(storyId, type, currentIndex, pageIndex,
          numberChapter, locationChapter);

  Future<bool> deleteStoryForUser(int storyId) =>
      _provider.deleteStoryForUser(storyId);

  Future<StoriesModel> getStoryForUser(int type, int pageIndex, int pageSize) =>
      _provider.getStoriesForUser(pageIndex, pageSize, type);

  Future<StoriesModel> getStoryCommon(int type, int pageIndex, int pageSize) =>
      _provider.getStoriesCommon(pageIndex, pageSize, type);

  Future<StoriesModel> getStoriesByType(
          int type, int pageIndex, int pageSize) =>
      _provider.getStoriesByType(pageIndex, pageSize, type);
}

class NetworkError extends Error {}
