part of 'notification_bloc.dart';

abstract class NotificationState extends Equatable {
  const NotificationState();

  @override
  List<Object> get props => [];
}

final class NotificationInitial extends NotificationState {}

class NotificationLoadingState extends NotificationState {}

class NotificationLoadedState extends NotificationState {
  final NotificationSingleUser notificationSingleUser;
  const NotificationLoadedState(this.notificationSingleUser);
}

class NotificationErrorState extends NotificationState {
  final String error;
  const NotificationErrorState(this.error);
}
