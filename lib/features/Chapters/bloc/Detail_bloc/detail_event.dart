part of 'detail_bloc.dart';

@immutable
abstract class DetailChapterOfStoryEvent extends Equatable {
  const DetailChapterOfStoryEvent();
  @override
  List<Object?> get props => [];
}

class DetailChapterOfStory extends DetailChapterOfStoryEvent {
  final int chapterId;
  final bool? actionChapter;
  final int? storyId;
  const DetailChapterOfStory(this.actionChapter, this.storyId,
      {required this.chapterId});
}
