import 'package:muonroi/core/Authorization/setting.api.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/shared/settings/enums/enum.search.story.dart';
import 'package:muonroi/features/story/data/models/models.single.story.dart';
import 'package:muonroi/features/story/data/models/models.stories.story.dart';
import 'package:muonroi/features/story/settings/settings.dart';
import 'package:sprintf/sprintf.dart';

class StoryService {
  Future<StoriesModel> getStoriesDataList(
      [int pageIndex = 1, int pageSize = 15]) async {
    try {
      var baseEndpoint = await endPoint();
      final response = await baseEndpoint.get(
          sprintf(ApiNetwork.getStoriesPaging, ["$pageIndex", "$pageSize"]));
      if (response.statusCode == 200) {
        return storiesFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load story");
      }
    } catch (e) {
      throw Exception("Failed to load story - $e");
    }
  }

  Future<StoriesModel> getStoriesRecommendList(int storyId,
      [int pageIndex = 1, int pageSize = 15]) async {
    try {
      var baseEndpoint = await endPoint();
      final response = await baseEndpoint.get(sprintf(
          ApiNetwork.getRecommendStoriesPaging,
          ["$storyId", "$pageIndex", "$pageSize"]));
      if (response.statusCode == 200) {
        return storiesFromJson(response.data.toString());
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
      var baseEndpoint = await endPoint();
      final response = await baseEndpoint
          .get(sprintf(ApiNetwork.getDetailStory, ["$storyId"]));
      if (response.statusCode == 200) {
        return singleStoryModelFromJson(response.data.toString());
      } else {
        return SingleStoryModel(
          errorMessages: [],
          result: storySingleDefaultData(),
          isOk: false,
          statusCode: 400,
        );
      }
    } catch (e) {
      return SingleStoryModel(
        errorMessages: [e],
        result: storySingleDefaultData(),
        isOk: false,
        statusCode: 400,
      );
    }
  }

  Future<bool> voteStory(int storyId, double voteNumber) async {
    try {
      Map<String, dynamic> data = {
        'storyId': '$storyId',
        'voteValue': '$voteNumber'
      };
      var baseEndpoint = await endPoint();
      final response =
          await baseEndpoint.patch(ApiNetwork.voteStory, data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return false;
    }
  }

  Future<StoriesModel> searchStory(List<String> keySearch,
      List<SearchType> type, int pageIndex, int pageSize) async {
    try {
      var baseEndpoint = await endPoint();
      String url = "";
      String paging = "PageIndex=$pageIndex&PageSize=$pageSize";
      for (int i = 0; i < type.length; i++) {
        switch (type[i]) {
          case SearchType.title:
            url += "SearchByTitle=${keySearch[i]}&";
            break;
          case SearchType.category:
            url += "SearchByCategory=${keySearch[i]}&";
            break;
          case SearchType.tag:
            url += "SearchByTagName=${keySearch[i]}&";
            break;
          case SearchType.chapter:
            url += "SearchByNumberChapter=${keySearch[i]}&";
            break;
        }
      }
      url += paging;
      final response =
          await baseEndpoint.get("${ApiNetwork.baseSearchStory}$url");
      if (response.statusCode == 200) {
        return storiesFromJson(response.data.toString());
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

  Future<bool> createBookmarkStory(int storyId) async {
    try {
      Map<String, dynamic> data = {'storyId': storyId};
      var baseEndpoint = await endPoint();
      final response =
          await baseEndpoint.post(ApiNetwork.bookmarkStory, data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Failed to bookmark story - $e");
    }
  }

  Future<bool> createStoryForUser(int storyId, int type) async {
    try {
      Map<String, dynamic> data = {'storyId': storyId, 'storyType': type};
      var baseEndpoint = await endPoint();
      final response =
          await baseEndpoint.post(ApiNetwork.createStoryForUser, data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Failed to create story for user - $e");
    }
  }

  Future<bool> deleteStoryForUser(int storyId) async {
    try {
      Map<String, dynamic> data = {'storyId': 0, 'storyType': 0, 'id': storyId};
      var baseEndpoint = await endPoint();
      final response =
          await baseEndpoint.delete(ApiNetwork.deleteStoryForUser, data: data);
      if (response.statusCode == 200) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      throw Exception("Failed to delete story for user - $e");
    }
  }

  Future<StoriesModel> getStoriesForUser(
      int pageIndex, int pageSize, int type) async {
    try {
      var baseEndpoint = await endPoint();
      final response = await baseEndpoint.get(
          sprintf(ApiNetwork.getStoriesForUser, [type, pageIndex, pageSize]));
      if (response.statusCode == 200) {
        return storiesFromJson(response.data.toString());
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
      throw Exception("Failed to get story for user - $e");
    }
  }
}
