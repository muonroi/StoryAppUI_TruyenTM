import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/notification/data/models/model.notification.single.user.dart';
import 'package:muonroi/features/notification/data/repository/notification.repository.dart';
part 'notification_event.dart';
part 'notification_state.dart';

class NotificationBloc extends Bloc<NotificationEvent, NotificationState> {
  late int pageIndex;
  final int pageSize;
  NotificationBloc({required this.pageIndex, required this.pageSize})
      : super(NotificationInitial()) {
    var notificationRepository = NotificationRepository();
    on<GetNotificationEventList>((event, emit) async {
      try {
        emit(NotificationLoadingState());
        if (event.isPrevious && !event.onRefresh) {
          pageIndex--;
        } else if (!event.isPrevious && pageIndex >= 1 && !event.onRefresh) {
          pageIndex++;
        }
        pageIndex = pageIndex < 1 ? 1 : pageIndex;
        final mList = await notificationRepository.getNotificationUser(
            pageIndex, pageSize);
        emit(NotificationLoadedState(mList));
        if (!mList.isOk) {
          emit(NotificationErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const NotificationErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
