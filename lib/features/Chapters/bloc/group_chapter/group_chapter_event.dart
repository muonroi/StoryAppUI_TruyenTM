part of 'group_chapter_bloc.dart';

@immutable
abstract class GroupChapterBlocEvent extends Equatable {
  const GroupChapterBlocEvent();

  @override
  List<Object> get props => [];
}

class GroupChapter extends GroupChapterBlocEvent {
  final int storyId;
  final int pageIndex;
  const GroupChapter(this.storyId, this.pageIndex);
}
