part of 'group_chapters_of_story_bloc.dart';

@immutable
abstract class GroupChapterOfStoryState extends Equatable {
  const GroupChapterOfStoryState();
  @override
  List<Object?> get props => [];
}

class GroupChapterOfStoryInitial extends GroupChapterOfStoryState {}

class GroupChapterOfStoryLoadingState extends GroupChapterOfStoryState {}

class GroupChapterOfStoryLoadedState extends GroupChapterOfStoryState {
  final ChapterInfo chapter;
  const GroupChapterOfStoryLoadedState(this.chapter);
}

class GroupChapterOfStoryErrorState extends GroupChapterOfStoryState {
  final String error;
  const GroupChapterOfStoryErrorState(this.error);
}
