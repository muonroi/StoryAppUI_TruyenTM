part of 'free_bloc.dart';

abstract class FreeStoryState extends Equatable {
  const FreeStoryState();
  @override
  List<Object> get props => [];
}

class FreeStoryInitialState extends FreeStoryState {}

class FreeStoryLoadingState extends FreeStoryState {}

class FreeStoryLoadedState extends FreeStoryState {
  final StoriesModel story;
  const FreeStoryLoadedState(this.story);
}

class FreeStoryErrorState extends FreeStoryState {
  final String error;
  const FreeStoryErrorState(this.error);
}
