import 'package:muonroi/shared/settings/enums/enum.search.story.dart';
import 'package:muonroi/shared/settings/settings.main.dart';
import 'package:muonroi/features/stories/data/models/models.single.story.dart';
import 'package:muonroi/features/stories/data/models/models.stories.story.dart';
import 'package:muonroi/features/stories/settings/settings.dart';
import 'package:sprintf/sprintf.dart';
import '../../shared/settings/settings.api.dart';

class StoryProvider {
  Future<StoriesModel> getStoriesDataList(
      [int pageIndex = 1, int pageSize = 15]) async {
    try {
      final response = await baseUrl().get(
          sprintf(ApiNetwork.getStoriesPaging, ["$pageIndex", "$pageSize"]));
      if (response.statusCode == 200) {
        return storiesFromJson(response.data.toString());
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
      final response =
          await baseUrl().get(sprintf(ApiNetwork.getDetailStory, ["$storyId"]));
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
      final response = await baseUrl().patch(ApiNetwork.voteStory, data: data);
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
      final response = await baseUrl().get("${ApiNetwork.baseSearchStory}$url");
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
}
