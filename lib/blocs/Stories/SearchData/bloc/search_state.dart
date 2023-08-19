part of 'search_bloc.dart';

abstract class SearchStoryState extends Equatable {
  const SearchStoryState();
  @override
  List<Object> get props => [];
}

class SearchStoryInitialState extends SearchStoryState {}

class SearchStoryLoadingState extends SearchStoryState {}

class SearchStoryLoadedState extends SearchStoryState {
  final StoriesModel stories;
  const SearchStoryLoadedState(this.stories);
}

class SearchStoryErrorState extends SearchStoryState {
  final String error;
  const SearchStoryErrorState(this.error);
}
