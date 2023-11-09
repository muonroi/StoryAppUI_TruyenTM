part of 'latest_chapter_of_story_bloc.dart';

@immutable
abstract class LatestChapterOfStoryState extends Equatable {
  const LatestChapterOfStoryState();
  @override
  List<Object?> get props => [];
}

class LatestChapterOfStoryInitial extends LatestChapterOfStoryState {}

class LatestChapterOfStoryLoadingState extends LatestChapterOfStoryState {}

class LatestChapterOfStoryNoDataState extends LatestChapterOfStoryState {}

class LatestChapterOfStoryLoadedState extends LatestChapterOfStoryState {
  final ChapterPreviewModel chapter;
  const LatestChapterOfStoryLoadedState(this.chapter);
}

class LatestChapterOfStoryErrorState extends LatestChapterOfStoryState {
  final String error;
  const LatestChapterOfStoryErrorState(this.error);
}
// #region Any

class AnyLatestChapterOfStoryInitial extends LatestChapterOfStoryState {}

class AnyLatestChapterOfStoryLoadingState extends LatestChapterOfStoryState {}

class AnyLatestChapterOfStoryLoadedState extends LatestChapterOfStoryState {
  final ChapterInfo chapter;
  const AnyLatestChapterOfStoryLoadedState(this.chapter);
}

class AnyLatestChapterOfStoryErrorState extends LatestChapterOfStoryState {
  final String error;
  const AnyLatestChapterOfStoryErrorState(this.error);
}
// #endregion
// #region From to

class FromToChapterOfStoryInitial extends LatestChapterOfStoryState {}

class FromToChapterOfStoryLoadingState extends LatestChapterOfStoryState {}

class FromToChapterOfStoryLoadedState extends LatestChapterOfStoryState {
  final ListPagingRangeChapters chapter;
  const FromToChapterOfStoryLoadedState(this.chapter);
}

class FromToChapterOfStoryErrorState extends LatestChapterOfStoryState {
  final String error;
  const FromToChapterOfStoryErrorState(this.error);
}
// #endregion
