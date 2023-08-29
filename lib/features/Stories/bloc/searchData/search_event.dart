part of 'search_bloc.dart';

abstract class SearchStoryEvent extends Equatable {
  const SearchStoryEvent();
  @override
  List<Object> get props => [];
}

class SearchStoriesList extends SearchStoryEvent {}
