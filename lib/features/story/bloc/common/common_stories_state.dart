part of 'common_stories_bloc.dart';

abstract class CommonStoriesState extends Equatable {
  const CommonStoriesState();

  @override
  List<Object> get props => [];
}

final class CommonStoriesInitial extends CommonStoriesState {}

class CommonStoriesLoadingState extends CommonStoriesState {}

class CommonStoriesNoDataState extends CommonStoriesState {}

class CommonStoriesLoadedState extends CommonStoriesState {
  final StoriesModel stories;
  const CommonStoriesLoadedState(this.stories);
}

class CommonStoriesErrorState extends CommonStoriesState {
  final String error;
  const CommonStoriesErrorState(this.error);
}
