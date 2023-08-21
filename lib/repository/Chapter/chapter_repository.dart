import 'package:muonroi/Models/Chapters/models.chapter.single.chapter.dart';
import 'package:muonroi/Models/Chapters/models.chapters.list.chapter.dart';
import 'package:muonroi/Models/Chapters/models.chapters.preview.chapter.dart';
import 'package:muonroi/resource/api_chapter_provider.dart';

class ChapterRepository {
  final int storyId;
  final int chapterId;
  final bool isLatest;
  final int pageIndex;
  final int pageSize;
  final _provider = ChapterProvider();

  ChapterRepository(this.pageIndex, this.pageSize, this.chapterId,
      {required this.storyId, required this.isLatest});

  Future<ChapterPreviewModel> fetchChaptersData() =>
      _provider.getChaptersDataList(storyId, isLatest: isLatest);

  Future<ChapterInfo> fetchGroupChapterOfStory(int storyId, int chapterId,
          {int pageIndex = 1, int pageSize = 20}) =>
      _provider.getGroupChaptersDataDetail(storyId, chapterId,
          pageIndex: pageIndex, pageSize: pageSize);

  Future<DetailChapterInfo> fetchChapterOfStory(int chapterId) =>
      _provider.getChapterDataDetail(chapterId);
  Future<DetailChapterInfo> fetchActionChapterOfStory(
          int chapterId, int storyId, bool action) =>
      _provider.fetchActionChapterOfStory(chapterId, storyId, action);
}

class NetworkError extends Error {}
