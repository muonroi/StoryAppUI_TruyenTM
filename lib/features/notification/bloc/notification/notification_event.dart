part of 'notification_bloc.dart';

abstract class NotificationEvent extends Equatable {
  const NotificationEvent();

  @override
  List<Object> get props => [];
}

class GetNotificationEventList extends NotificationEvent {
  final bool isPrevious;
  final bool onRefresh;
  const GetNotificationEventList(this.onRefresh, {required this.isPrevious});
}
