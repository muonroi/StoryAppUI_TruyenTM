part of 'detail_bloc.dart';

abstract class DetailStoryState extends Equatable {
  const DetailStoryState();
  @override
  List<Object> get props => [];
}

class DetailStoryInitialState extends DetailStoryState {}

class DetailStoryLoadingState extends DetailStoryState {}

class DetailStoryLoadedState extends DetailStoryState {
  final SingleStoryModel story;
  const DetailStoryLoadedState(this.story);
}

class DetailStoryErrorState extends DetailStoryState {
  final String error;
  const DetailStoryErrorState(this.error);
}
