import 'package:muonroi/Models/Stories/models.stories.story.dart';
import 'package:muonroi/Settings/settings.main.dart';
import 'package:sprintf/sprintf.dart';
import '../Settings/settings.api.dart';

class StoryProvider {
  Future<StoryModel> getStoriesDataList() async {
    try {
      final response = await baseUrl()
          .get(sprintf(ApiNetwork.getStoriesPaging, ["1", "15"]));
      if (response.statusCode == 200) {
        return storyFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load story");
      }
    } catch (e) {
      throw Exception("Failed to load story");
    }
  }

  Future<StoryModel> getStoriesRecommendList(int storyId) async {
    try {
      final response = await baseUrl().get(sprintf(
          ApiNetwork.getRecommendStoriesPaging, ["$storyId", "1", "15"]));
      if (response.statusCode == 200) {
        return storyFromJson(response.data.toString());
      } else {
        return StoryModel(
          errorMessages: [],
          result: Result(
              items: [],
              pagingInfo: PagingInfo(pageSize: 0, page: 0, totalItems: 0)),
          isOk: false,
          statusCode: 400,
        );
      }
    } catch (e) {
      return StoryModel(
        errorMessages: [],
        result: Result(
            items: [],
            pagingInfo: PagingInfo(pageSize: 0, page: 0, totalItems: 0)),
        isOk: false,
        statusCode: 400,
      );
    }
  }
}
