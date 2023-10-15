import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/notification/data/repository/notification.repository.dart';

part 'view_single_event.dart';
part 'view_single_state.dart';

class ViewSingleBloc extends Bloc<ViewSingleEvent, ViewSingleState> {
  ViewSingleBloc() : super(ViewSingleInitial()) {
    var notificationRepository = NotificationRepository();
    on<ActionSingleEvent>((event, emit) async {
      try {
        emit(ViewSingleLoadingState());
        final mList = await notificationRepository
            .viewSingleNotificationUser(event.notificationId);
        emit(ViewSingleLoadedState(mList));
      } on NetworkError {
        emit(const ViewSingleErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
