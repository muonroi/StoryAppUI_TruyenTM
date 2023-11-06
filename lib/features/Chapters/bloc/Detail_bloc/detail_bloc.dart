import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/chapters/data/models/models.chapter.single.chapter.dart';
import 'package:muonroi/features/chapters/data/repositories/chapter_repository.dart';
part 'detail_event.dart';
part 'detail_state.dart';

class DetailChapterOfStoryBloc
    extends Bloc<DetailChapterOfStoryEvent, DetailChapterOfStoryState> {
  DetailChapterOfStoryBloc({required this.chapterId})
      : super(DetailChapterOfStoryInitial()) {
    on<DetailChapterOfStory>((event, emit) async {
      final ChapterRepository chapterRepository = ChapterRepository(
        1,
        15,
        chapterId,
        storyId: 0,
        isLatest: false,
      );
      try {
        emit(DetailChapterOfStoryLoadingState());
        late DetailChapterInfo mList;
        if (event.chapterId == 0 && event.actionChapter == null) {
          mList = await chapterRepository.fetchChapterOfStory(chapterId);
        } else {
          mList = await chapterRepository.fetchActionChapterOfStory(
              event.chapterId, event.storyId!, event.actionChapter!);
        }
        emit(DetailChapterOfStoryLoadedState(mList));
        if (!mList.isOk) {
          emit(DetailChapterOfStoryErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkChapterError {
        emit(const DetailChapterOfStoryErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
  final int chapterId;
}
