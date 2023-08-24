import 'package:muonroi/Models/Chapters/models.chapter.list.paging.dart';
import 'package:muonroi/Models/Chapters/models.chapter.list.paging.range.dart';
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
      _provider.getChaptersDataList(storyId, pageIndex, isLatest: isLatest);

  Future<ListPagingChapters> fetchGroupChapterOfStory(int storyId) =>
      _provider.getGroupChaptersDataDetail(storyId);

  Future<DetailChapterInfo> fetchChapterOfStory(int chapterId) =>
      _provider.getChapterDataDetail(chapterId);
  Future<DetailChapterInfo> fetchActionChapterOfStory(
          int chapterId, int storyId, bool action) =>
      _provider.fetchActionChapterOfStory(chapterId, storyId, action);
  Future<ChapterInfo> fetchLatestChapterAnyStory(int pageIndex, int pageSize) =>
      _provider.fetchLatestChapterAnyStory(
          pageIndex: pageIndex, pageSize: pageSize);

  Future<ListPagingRangeChapters> fetchFromToChapterOfStory(
          int storyId, int from, int to) =>
      _provider.getFromToChaptersDataDetail(storyId, from, to);
}

class NetworkError extends Error {}
