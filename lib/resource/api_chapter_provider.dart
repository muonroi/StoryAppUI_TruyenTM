import 'package:muonroi/Models/Chapters/models.chapter.list.paging.dart';
import 'package:muonroi/Models/Chapters/models.chapter.list.paging.range.dart';
import 'package:muonroi/Models/Chapters/models.chapter.single.chapter.dart';
import 'package:muonroi/Models/Chapters/models.chapters.list.chapter.dart';
import 'package:muonroi/Models/Chapters/models.chapters.preview.chapter.dart';
import 'package:muonroi/Settings/settings.api.dart';
import 'package:muonroi/Settings/settings.main.dart';
import 'package:sprintf/sprintf.dart';

class ChapterProvider {
  Future<ChapterPreviewModel> getChaptersDataList(int storyId, int pageIndex,
      {bool isLatest = false}) async {
    try {
      final response = await baseUrl().get(sprintf(ApiNetwork.getChapterPaging,
          ["$storyId", "$pageIndex", "100", "$isLatest"]));
      if (response.statusCode == 200) {
        return chapterPreviewModelFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load chapter");
      }
    } catch (e) {
      throw Exception("Failed to load chapter");
    }
  }

  Future<ListPagingChapters> getGroupChaptersDataDetail(int storyId) async {
    try {
      final response = await baseUrl()
          .get(sprintf(ApiNetwork.getListChapterPaging, ["$storyId"]));
      if (response.statusCode == 200) {
        return listPagingChaptersFromJson(response.data.toString());
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

  Future<ChapterInfo> fetchLatestChapterAnyStory(
      {int pageIndex = 1, int pageSize = 5}) async {
    try {
      final response = await baseUrl().get(
          sprintf(ApiNetwork.getLatestChapterNumber, [pageIndex, pageSize]));
      if (response.statusCode == 200) {
        return chapterInfoFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load list chapter");
      }
    } catch (e) {
      throw Exception("Failed to load list chapter");
    }
  }

  Future<ListPagingRangeChapters> getFromToChaptersDataDetail(
      int storyId, int from, int to) async {
    try {
      final response = await baseUrl().get(sprintf(
          ApiNetwork.getFromToChapterPaging, ["$storyId", "$from", "$to"]));
      if (response.statusCode == 200) {
        return listPagingRangeChaptersFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load chapter");
      }
    } catch (e) {
      throw Exception("Failed to load chapter");
    }
  }
}
