part of 'group_chapter_bloc.dart';

@immutable
abstract class GroupChapterBlocEvent extends Equatable {
  const GroupChapterBlocEvent();

  @override
  List<Object> get props => [];
}

class GroupChapter extends GroupChapterBlocEvent {
  final int storyId;
  final bool isAudio;
  final int pageIndex;
  const GroupChapter(this.storyId, this.pageIndex, this.isAudio);
}

class SingleChapter extends GroupChapterBlocEvent {
  final int chapterId;
  const SingleChapter(this.chapterId);
}
