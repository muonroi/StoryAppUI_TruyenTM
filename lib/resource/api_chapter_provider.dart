import 'package:muonroi/Models/Chapters/models.chapters.chapter.dart';
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
}
