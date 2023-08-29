part of 'detail_bloc.dart';

@immutable
abstract class DetailChapterOfStoryState extends Equatable {
  const DetailChapterOfStoryState();
  @override
  List<Object?> get props => [];
}

class DetailChapterOfStoryInitial extends DetailChapterOfStoryState {}

class DetailChapterOfStoryLoadingState extends DetailChapterOfStoryState {}

class DetailChapterOfStoryLoadedState extends DetailChapterOfStoryState {
  final DetailChapterInfo chapter;
  const DetailChapterOfStoryLoadedState(this.chapter);
}

class DetailChapterOfStoryErrorState extends DetailChapterOfStoryState {
  final String error;
  const DetailChapterOfStoryErrorState(this.error);
}
