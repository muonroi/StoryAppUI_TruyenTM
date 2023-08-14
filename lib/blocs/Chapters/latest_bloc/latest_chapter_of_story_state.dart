part of 'latest_chapter_of_story_bloc.dart';

@immutable
abstract class LatestChapterOfStoryState extends Equatable {
  const LatestChapterOfStoryState();
  @override
  List<Object?> get props => [];
}

class LatestChapterOfStoryInitial extends LatestChapterOfStoryState {}

class LatestChapterOfStoryLoadingState extends LatestChapterOfStoryState {}

class LatestChapterOfStoryLoadedState extends LatestChapterOfStoryState {
  final ChapterPreviewModel chapter;
  const LatestChapterOfStoryLoadedState(this.chapter);
}

class LatestChapterOfStoryErrorState extends LatestChapterOfStoryState {
  final String error;
  const LatestChapterOfStoryErrorState(this.error);
}
