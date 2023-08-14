import 'dart:async';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/resource/api_story_provider.dart';

class StoryRepository {
  final _provider = StoryProvider();

  Future<StoryModel> fetchStoriesData() => _provider.getStoriesDataList();
  Future<StoryModel> fetchRecommendStories(int storyId) =>
      _provider.getStoriesRecommendList(storyId);
}

class NetworkError extends Error {}
