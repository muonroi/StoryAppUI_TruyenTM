part of 'user_info_bloc.dart';

abstract class UserInfoState extends Equatable {
  const UserInfoState();

  @override
  List<Object> get props => [];
}

final class UserInfoInitial extends UserInfoState {}

class UserInfoLoadingState extends UserInfoState {}

class UserInfoLoadedState extends UserInfoState {
  final UserInfoResponseModel user;
  const UserInfoLoadedState(this.user);
}

class UserInfoErrorState extends UserInfoState {
  final String error;
  const UserInfoErrorState(this.error);
}
