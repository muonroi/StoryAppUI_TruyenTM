import 'package:muonroi/Models/Chapters/models.chapter.single.chapter.dart';
import 'package:muonroi/Models/Chapters/models.chapters.list.chapter.dart';
import 'package:muonroi/Models/Chapters/models.chapters.preview.chapter.dart';
import 'package:muonroi/Settings/settings.api.dart';
import 'package:muonroi/Settings/settings.main.dart';
import 'package:sprintf/sprintf.dart';

class ChapterProvider {
  Future<ChapterPreviewModel> getChaptersDataList(int storyId,
      {bool isLatest = false}) async {
    try {
      final response = await baseUrl().get(sprintf(
          ApiNetwork.getChapterPaging, ["$storyId", "1", "100", "$isLatest"]));
      if (response.statusCode == 200) {
        return chapterPreviewModelFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load chapter");
      }
    } catch (e) {
      throw Exception("Failed to load chapter");
    }
  }

  Future<ChapterInfo> getGroupChaptersDataDetail(int storyId, int fromChapterId,
      {int pageIndex = 1, int pageSize = 20}) async {
    try {
      final response = await baseUrl().get(sprintf(
          ApiNetwork.getGroupChapterDetail,
          ["$storyId", "$fromChapterId", "$pageIndex", "$pageSize"]));
      if (response.statusCode == 200) {
        return chapterInfoFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load chapter");
      }
    } catch (e) {
      throw Exception("Failed to load chapter");
    }
  }

  Future<DetailChapterInfo> getChapterDataDetail(int fromChapterId) async {
    try {
      final response = await baseUrl()
          .get(sprintf(ApiNetwork.getChapterDetail, ["$fromChapterId"]));
      if (response.statusCode == 200) {
        return detailChapterInfoFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load detail chapter");
      }
    } catch (e) {
      throw Exception("Failed to load detail chapter");
    }
  }

  Future<DetailChapterInfo> fetchActionChapterOfStory(
      int chapterId, int storyId, bool action) async {
    try {
      var stringEndpointName = action ? "Next" : "Previous";
      final response = await baseUrl().get(sprintf(
          ApiNetwork.getActionChapterDetail,
          [stringEndpointName, "$storyId", "$chapterId"]));
      if (response.statusCode == 200) {
        return detailChapterInfoFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load detail chapter");
      }
    } catch (e) {
      throw Exception("Failed to load detail chapter");
    }
  }
}
