import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/Models/Chapters/models.chapters.preview.chapter.dart';
import 'package:muonroi/repository/Chapter/chapter_repository.dart';
part 'latest_chapter_of_story_event.dart';
part 'latest_chapter_of_story_state.dart';

class LatestChapterOfStoryBloc
    extends Bloc<LatestChapterOfStoryEvent, LatestChapterOfStoryState> {
  final int storyId;
  final int chapterId;
  final bool isLatest;
  final int pageIndex;
  final int pageSize;
  LatestChapterOfStoryBloc(this.storyId, this.isLatest, this.pageIndex,
      this.pageSize, this.chapterId)
      : super(LatestChapterOfStoryInitial()) {
    final ChapterRepository chapterRepository = ChapterRepository(
      pageIndex,
      pageSize,
      chapterId,
      storyId: storyId,
      isLatest: isLatest,
    );
    on<GetLatestChapterOfStoryList>((event, emit) async {
      try {
        emit(LatestChapterOfStoryLoadingState());
        final mList = await chapterRepository.fetchChaptersData();
        emit(LatestChapterOfStoryLoadedState(mList));
        if (!mList.isOk) {
          emit(LatestChapterOfStoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const LatestChapterOfStoryErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
