part of 'recommend_bloc.dart';

abstract class RecommendStoryEvent extends Equatable {
  const RecommendStoryEvent();
  @override
  List<Object> get props => [];
}

class GetRecommendStoriesList extends RecommendStoryEvent {}
