part of 'latest_chapter_of_story_bloc.dart';

@immutable
abstract class LatestChapterOfStoryEvent extends Equatable {
  const LatestChapterOfStoryEvent();
  @override
  List<Object?> get props => [];
}

class GetLatestChapterOfStoryList extends LatestChapterOfStoryEvent {}

class GetAnyLatestChapterList extends LatestChapterOfStoryEvent {}

class GetFromToChapterOfStoryList extends LatestChapterOfStoryEvent {
  final int fromChapterId;
  final int toChapterId;
  final int pageIndex;
  const GetFromToChapterOfStoryList(
      {required this.pageIndex,
      required this.fromChapterId,
      required this.toChapterId});
}
