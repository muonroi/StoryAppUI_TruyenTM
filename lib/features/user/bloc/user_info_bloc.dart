import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:muonroi/features/user/data/models/model.user.info.dart';
import 'package:muonroi/features/user/data/repository/user.repository.dart';
part 'user_info_event.dart';
part 'user_info_state.dart';

class UserInfoBloc extends Bloc<UserInfoEvent, UserInfoState> {
  UserInfoBloc(this.username) : super(UserInfoInitial()) {
    final userRepository = UserRepository();
    on<GetUserInfo>((event, emit) async {
      try {
        emit(UserInfoLoadingState());
        final mList = await userRepository.fetchUserInfoData(username);
        emit(UserInfoLoadedState(mList));
        if (!mList.isOk) {
          emit(UserInfoErrorState(
              mList.errorMessages.map((e) => e.toString()).toList().join(',')));
        }
      } on NetworkError {
        emit(const UserInfoErrorState(
            "Failed to fetch data. is your device online?"));
      }
    });
  }
  final String username;
}
