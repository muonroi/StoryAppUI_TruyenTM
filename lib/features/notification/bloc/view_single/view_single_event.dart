part of 'view_single_bloc.dart';

abstract class ViewSingleEvent extends Equatable {
  const ViewSingleEvent();

  @override
  List<Object> get props => [];
}

class ActionSingleEvent extends ViewSingleEvent {
  final int notificationId;

  const ActionSingleEvent({required this.notificationId});
}
