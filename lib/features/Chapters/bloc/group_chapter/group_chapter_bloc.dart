import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.group.dart';
import 'package:muonroi/features/chapters/data/repositories/chapter_repository.dart';
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
    on<GroupChapter>(
      (event, emit) async {
        try {
          emit(GroupChapterLoadingState());
          var mList = await chapterRepository.fetchGroupChapters(
              storyId, event.pageIndex);
          if (mList.result.items.isNotEmpty) {
            emit(GroupChapterLoadedState(mList));
          } else {
            emit(const GroupChapterNoDataState());
          }
          if (!mList.isOk) {
            emit(GroupChapterErrorState(mList.errorMessages
                .map((e) => e.toString())
                .toList()
                .join(',')));
          }
        } on NetworkChapterError {
          emit(const GroupChapterErrorState(
              "Failed to fetch data. is your device online?"));
        }
      },
    );
    on<SingleChapter>(
      (event, emit) async {
        try {
          emit(GroupChapterLoadingState());
          var mList =
              await chapterRepository.fetchChapterOfStory(event.chapterId);
          emit(GroupChapterLoadedState(GroupChapters(
              result: Result(items: [
                mList.result
              ], pagingInfo: PagingInfo(pageSize: 10, page: 1, totalItems: 10)),
              errorMessages: [],
              isOk: false,
              statusCode: 200)));
          if (!mList.isOk) {
            emit(GroupChapterErrorState(mList.errorMessages
                .map((e) => e.toString())
                .toList()
                .join(',')));
          }
        } on NetworkChapterError {
          emit(const GroupChapterErrorState(
              "Failed to fetch data. is your device online?"));
        }
      },
    );
  }
  final int storyId;
  int pageIndex;
  final int pageSize;
}
