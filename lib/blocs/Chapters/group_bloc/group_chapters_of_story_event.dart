part of 'group_chapters_of_story_bloc.dart';

@immutable
abstract class GroupChapterOfStoryEvent extends Equatable {
  const GroupChapterOfStoryEvent();
  @override
  List<Object?> get props => [];
}

class GroupChapterOfStoryList extends GroupChapterOfStoryEvent {}

class GroupMoreChapterOfStoryList extends GroupChapterOfStoryEvent {}

class DetailChapterOfStoryList extends GroupChapterOfStoryEvent {}
