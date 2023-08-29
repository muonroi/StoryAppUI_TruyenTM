// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'group_chapters_of_story_bloc.dart';

@immutable
abstract class GroupChapterOfStoryEvent extends Equatable {
  const GroupChapterOfStoryEvent();
  @override
  List<Object?> get props => [];
}

class GroupChapterOfStoryList extends GroupChapterOfStoryEvent {}
