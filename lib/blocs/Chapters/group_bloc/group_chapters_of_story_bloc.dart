import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/Models/Chapters/models.chapters.chapter.dart';
import 'package:muonroi/repository/Chapter/chapter_repository.dart';
part 'group_chapters_of_story_event.dart';
part 'group_chapters_of_story_state.dart';

class GroupChapterOfStoryBloc
    extends Bloc<GroupChapterOfStoryEvent, GroupChapterOfStoryState> {
  GroupChapterOfStoryBloc(this.storyId, this.pageIndex, this.pageSize,
      this.isLatest, this.chapterId)
      : super(GroupChapterOfStoryInitial()) {
    final ChapterRepository chapterRepository = ChapterRepository(
      pageIndex,
      pageSize,
      chapterId,
      storyId: storyId,
      isLatest: isLatest,
    );
    on<GroupChapterOfStoryList>((event, emit) async {
      try {
        emit(GroupChapterOfStoryLoadingState());
        final mList = await chapterRepository.fetchGroupChapterOfStory(
            storyId, chapterId,
            pageIndex: pageIndex, pageSize: pageSize);
        emit(GroupChapterOfStoryLoadedState(mList));
        if (!mList.isOk) {
          emit(GroupChapterOfStoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const GroupChapterOfStoryErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
    on<GroupMoreChapterOfStoryList>((event, emit) async {
      try {
        emit(GroupChapterOfStoryLoadingState());
        pageIndex++;
        final mList = await chapterRepository.fetchGroupChapterOfStory(
            storyId, chapterId,
            pageIndex: pageIndex, pageSize: pageSize);
        emit(GroupChapterOfStoryLoadedState(mList));
        if (!mList.isOk) {
          emit(GroupChapterOfStoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const GroupChapterOfStoryErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
    on<DetailChapterOfStoryList>((event, emit) async {
      try {
        emit(GroupChapterOfStoryLoadingState());
        final mList = await chapterRepository.fetchGroupChapterOfStory(
            storyId, chapterId,
            pageIndex: pageIndex, pageSize: pageSize);
        emit(GroupChapterOfStoryLoadedState(mList));
        if (!mList.isOk) {
          emit(GroupChapterOfStoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const GroupChapterOfStoryErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
  final int storyId;
  int pageIndex;
  final int pageSize;
  final bool isLatest;
  final int chapterId;
}
