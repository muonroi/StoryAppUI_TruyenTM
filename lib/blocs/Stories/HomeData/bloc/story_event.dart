part of 'story_bloc.dart';

@immutable
abstract class StoryEvent extends Equatable {
  const StoryEvent();
  @override
  List<Object?> get props => [];
}

class GetStoriesList extends StoryEvent {}
