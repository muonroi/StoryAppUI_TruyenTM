import 'dart:io';
import 'package:muonroi/features/user/data/models/model.user.info.dart';
import 'package:muonroi/features/user/data/models/model.user.single.detail.dart';
import 'package:muonroi/features/user/data/services/api.user.service.dart';
import 'package:muonroi/shared/models/signalR/widget.base.response.dart';

class UserRepository {
  final _provider = UserService();
  UserRepository();
  Future<UserInfoResponseModel> fetchUserInfoData(String username) =>
      _provider.getUserInfo(username);

  Future<UserInfoResponseModel> uploadAvatarUser(
          File image, String userGuid, String type) =>
      _provider.uploadAvatarUser(image, userGuid, type);

  Future<UserInfoResponseModel> uploadInfoUser(SingleUserDetail request) =>
      _provider.updateUserInfo(request);

  Future<BaseResponseServer> createUserSubscription() =>
      _provider.createUserSubscription();

  Future<BaseResponseServer> getUserSubscription() =>
      _provider.getUserSubscription();

  Future<BaseResponseServer> getDuplicateUsername(username) =>
      _provider.duplicateUsername(username);
}

class NetworkError extends Error {}
