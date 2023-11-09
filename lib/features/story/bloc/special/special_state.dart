part of 'special_bloc.dart';

abstract class SpecialStoriesState extends Equatable {
  const SpecialStoriesState();

  @override
  List<Object> get props => [];
}

final class StoriesSpecialInitial extends SpecialStoriesState {}

class SpecialStoriesLoadingState extends SpecialStoriesState {}

class SpecialStoriesNoDataState extends SpecialStoriesState {}

class SpecialStoriesLoadedState extends SpecialStoriesState {
  final StoriesModel stories;
  const SpecialStoriesLoadedState(this.stories);
}

class SpecialStoriesErrorState extends SpecialStoriesState {
  final String error;
  const SpecialStoriesErrorState(this.error);
}
