part of 'recommend_bloc.dart';

abstract class RecommendStoryState extends Equatable {
  const RecommendStoryState();
  @override
  List<Object> get props => [];
}

class RecommendStoryInitialState extends RecommendStoryState {}

class RecommendStoryLoadingState extends RecommendStoryState {}

class RecommendStoryLoadedState extends RecommendStoryState {
  final StoriesModel story;
  const RecommendStoryLoadedState(this.story);
}

class RecommendStoryErrorState extends RecommendStoryState {
  final String error;
  const RecommendStoryErrorState(this.error);
}
