part of 'latest_chapter_of_story_bloc.dart';

@immutable
abstract class LatestChapterOfStoryEvent extends Equatable {
  const LatestChapterOfStoryEvent();
  @override
  List<Object?> get props => [];
}

class GetLatestChapterOfStoryList extends LatestChapterOfStoryEvent {}
