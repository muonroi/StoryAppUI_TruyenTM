part of 'group_chapter_bloc.dart';

@immutable
abstract class GroupChapterBlocState extends Equatable {
  const GroupChapterBlocState();

  @override
  List<Object> get props => [];
}

class GroupChapterBlocInitial extends GroupChapterBlocState {}

class GroupChapterLoadingState extends GroupChapterBlocState {}

class GroupChapterLoadedState extends GroupChapterBlocState {
  final GroupChapters chapter;
  const GroupChapterLoadedState(this.chapter);
}

class GroupChapterNoDataState extends GroupChapterBlocState {
  const GroupChapterNoDataState();
}

class GroupChapterErrorState extends GroupChapterBlocState {
  final String error;
  const GroupChapterErrorState(this.error);
}
