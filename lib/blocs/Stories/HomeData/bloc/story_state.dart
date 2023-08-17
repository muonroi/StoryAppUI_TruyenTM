part of 'story_bloc.dart';

@immutable
abstract class StoryState extends Equatable {
  const StoryState();
  @override
  List<Object?> get props => [];
}

class StoryInitial extends StoryState {}

class StoryLoadingState extends StoryState {}

class StoryLoadedState extends StoryState {
  final StoriesModel story;
  const StoryLoadedState(this.story);
}

class StoryErrorState extends StoryState {
  final String error;
  const StoryErrorState(this.error);
}
