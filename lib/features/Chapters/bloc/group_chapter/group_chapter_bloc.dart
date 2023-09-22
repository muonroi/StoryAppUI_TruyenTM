import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.group.dart';
import 'package:muonroi/features/chapters/data/repositories/chapter_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

part 'group_chapter_event.dart';
part 'group_chapter_state.dart';

class GroupChapterBloc
    extends Bloc<GroupChapterBlocEvent, GroupChapterBlocState> {
  GroupChapterBloc(this.storyId, this.pageIndex, this.pageSize)
      : super(GroupChapterBlocInitial()) {
    final ChapterRepository chapterRepository = ChapterRepository(
      pageIndex,
      pageSize,
      0,
      storyId: storyId,
      isLatest: false,
    );
    on<GroupChapter>((event, emit) async {
      try {
        emit(GroupChapterLoadingState());
        final _sharedPreferences = await SharedPreferences.getInstance();
        var mList = await chapterRepository.fetchGroupChapters(
            storyId, event.pageIndex);
        await _sharedPreferences.setString(
            "story-$storyId-current-group-chapter", groupChaptersToJson(mList));
        if (mList.result.items.length > 0) {
          emit(GroupChapterLoadedState(mList));
        } else {
          emit(GroupChapterNoDataState());
        }
        if (!mList.isOk) {
          emit(GroupChapterErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const GroupChapterErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
  final int storyId;
  int pageIndex;
  final int pageSize;
}
