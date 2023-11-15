part of 'special_bloc.dart';

abstract class SpecialStoriesEvent extends Equatable {
  const SpecialStoriesEvent();

  @override
  List<Object> get props => [];
}

class GetSpecialStoriesList extends SpecialStoriesEvent {
  final bool isPrevious;
  final bool onRefresh;
  const GetSpecialStoriesList(this.onRefresh, {required this.isPrevious});
}
