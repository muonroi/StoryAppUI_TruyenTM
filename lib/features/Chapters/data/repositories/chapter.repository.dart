import 'package:muonroi/features/chapters/data/service/api.chapter.service.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.group.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.list.paging.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.list.paging.range.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.single.chapter.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.list.chapter.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.preview.chapter.dart';

class ChapterRepository {
  final int storyId;
  final int chapterId;
  final bool isLatest;
  final int pageIndex;
  final int pageSize;
  final _provider = ChapterService();

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
          int storyId, int pageIndex, int from, int to) =>
      _provider.getFromToChaptersDataDetail(storyId, pageIndex, from, to);

  Future<GroupChapters> fetchGroupChapters(int storyId, int pageIndex,
          {int pageSize = 100,
          bool isDownload = false,
          bool isAudio = false}) =>
      _provider.getGroupChapters(storyId, pageIndex,
          pageSize: pageSize, isDownload: isDownload, isAudio: isAudio);
}

class NetworkChapterError extends Error {}
