part of 'stories_for_user_bloc.dart';

abstract class StoriesForUserState extends Equatable {
  const StoriesForUserState();
  @override
  List<Object> get props => [];
}

final class StoriesForUserInitial extends StoriesForUserState {}

class StoriesForUserLoadingState extends StoriesForUserState {}

class StoriesForUserLoadedState extends StoriesForUserState {
  final StoriesModel stories;
  const StoriesForUserLoadedState(this.stories);
}

class StoriesForUserNoDataState extends StoriesForUserState {}

class StoriesForUserErrorState extends StoriesForUserState {
  final String error;
  const StoriesForUserErrorState(this.error);
}
