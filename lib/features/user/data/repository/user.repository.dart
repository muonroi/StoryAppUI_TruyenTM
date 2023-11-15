import 'dart:io';

import 'package:muonroi/features/user/data/models/user.info.model.dart';
import 'package:muonroi/features/user/data/models/user.single.detail.model.dart';
import 'package:muonroi/features/user/data/services/user.service.dart';

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
}

class NetworkError extends Error {}
