import 'package:muonroi/Models/Stories/models.single.story.dart';
import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.main.dart';
import 'package:sprintf/sprintf.dart';
import '../Settings/settings.api.dart';

class StoryProvider {
  Future<StoriesModel> getStoriesDataList(
      [int pageIndex = 1, int pageSize = 15]) async {
    try {
      final response = await baseUrl().get(
          sprintf(ApiNetwork.getStoriesPaging, ["$pageIndex", "$pageSize"]));
      if (response.statusCode == 200) {
        return storyFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load story");
      }
    } catch (e) {
      throw Exception("Failed to load story");
    }
  }

  Future<StoriesModel> getStoriesRecommendList(int storyId,
      [int pageIndex = 1, int pageSize = 15]) async {
    try {
      final response = await baseUrl().get(sprintf(
          ApiNetwork.getRecommendStoriesPaging,
          ["$storyId", "$pageIndex", "$pageSize"]));
      if (response.statusCode == 200) {
        return storyFromJson(response.data.toString());
      } else {
        return StoriesModel(
          errorMessages: [],
          result: Result(
              items: [],
              pagingInfo: PagingInfo(pageSize: 0, page: 0, totalItems: 0)),
          isOk: false,
          statusCode: 400,
        );
      }
    } catch (e) {
      return StoriesModel(
        errorMessages: [],
        result: Result(
            items: [],
            pagingInfo: PagingInfo(pageSize: 0, page: 0, totalItems: 0)),
        isOk: false,
        statusCode: 400,
      );
    }
  }

  Future<SingleStoryModel> getDetailStoryList(int storyId) async {
    try {
      final response =
          await baseUrl().get(sprintf(ApiNetwork.getDetailStory, ["$storyId"]));
      if (response.statusCode == 200) {
        return singleStoryModelFromJson(response.data.toString());
      } else {
        return SingleStoryModel(
          errorMessages: [],
          result: StorySingleDefaultData(),
          isOk: false,
          statusCode: 400,
        );
      }
    } catch (e) {
      return SingleStoryModel(
        errorMessages: [],
        result: StorySingleDefaultData(),
        isOk: false,
        statusCode: 400,
      );
    }
  }
}
