part of 'common_stories_bloc.dart';

abstract class CommonStoriesEvent extends Equatable {
  const CommonStoriesEvent();

  @override
  List<Object> get props => [];
}

class GetCommonStoriesList extends CommonStoriesEvent {
  final bool isPrevious;
  final bool onRefresh;
  const GetCommonStoriesList(this.onRefresh, {required this.isPrevious});
}
