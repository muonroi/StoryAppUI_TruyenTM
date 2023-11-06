import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.list.paging.dart';
import 'package:muonroi/features/chapters/data/repositories/chapter_repository.dart';
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
        var mList = await chapterRepository.fetchGroupChapterOfStory(storyId);
        emit(GroupChapterOfStoryLoadedState(mList));
        if (!mList.isOk) {
          emit(GroupChapterOfStoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkChapterError {
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
