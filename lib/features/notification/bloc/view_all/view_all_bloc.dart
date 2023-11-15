import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/notification/data/repository/notification.repository.dart';
part 'view_all_event.dart';
part 'view_all_state.dart';

class ViewAllBloc extends Bloc<ViewAllEvent, ViewAllState> {
  ViewAllBloc() : super(ViewAllInitial()) {
    var notificationRepository = NotificationRepository();
    on<ActionAllEvent>((event, emit) async {
      try {
        emit(ViewAllLoadingState());
        final mList = await notificationRepository.viewAllNotificationUser();
        emit(ViewAllLoadedState(mList));
      } on NetworkError {
        emit(const ViewAllErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
}
