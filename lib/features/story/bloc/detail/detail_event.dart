part of 'detail_bloc.dart';

abstract class DetailStoryEvent extends Equatable {
  const DetailStoryEvent();
  @override
  List<Object> get props => [];
}

class GetDetailStory extends DetailStoryEvent {}
