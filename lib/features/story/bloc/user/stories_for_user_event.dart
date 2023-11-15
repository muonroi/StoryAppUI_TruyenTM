part of 'stories_for_user_bloc.dart';

abstract class StoriesForUserEvent extends Equatable {
  const StoriesForUserEvent();

  @override
  List<Object> get props => [];
}

class StoriesForUserList extends StoriesForUserEvent {
  final bool isPrevious;
  final bool onRefresh;
  const StoriesForUserList(this.onRefresh, {required this.isPrevious});
}

class OnRefresh extends StoriesForUserEvent {
  const OnRefresh();
}
