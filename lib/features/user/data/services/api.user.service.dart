import 'dart:io';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:http_parser/http_parser.dart';
import 'package:muonroi/core/Authorization/setting.api.dart';
import 'package:muonroi/core/authorization/enums/key.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/accounts/data/models/model.account.signin.dart';
import 'package:muonroi/features/user/data/models/model.user.info.dart';
import 'package:muonroi/features/user/data/models/model.user.single.detail.dart';
import 'package:muonroi/features/user/settings/settings.dart';
import 'package:muonroi/shared/models/signalR/widget.base.response.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sprintf/sprintf.dart';

class UserService {
  Future<UserInfoResponseModel> getUserInfo(String username) async {
    try {
      var baseEndpoint = await endPoint();
      final response = await baseEndpoint
          .get(sprintf(ApiNetwork.userInfoByUsername, [username]));
      if (response.statusCode == 200) {
        return userInfoResponseModelFromJson(response.data.toString());
      } else {
        return UserInfoResponseModel(
          errorMessages: [],
          result: null,
          isOk: false,
          statusCode: null,
        );
      }
    } catch (e) {
      if (e is DioException) {
        if (e.response != null) {
        } else {}
      } else {}
    }
    return UserInfoResponseModel(
      errorMessages: [],
      result: null,
      isOk: false,
      statusCode: null,
    );
  }

  Future<UserInfoResponseModel> uploadAvatarUser(
      File file, String userGuid, String contentType) async {
    try {
      await refreshAccessToken();
      var sharedPreferences = await SharedPreferences.getInstance();
      String? token = sharedPreferences.getString(KeyToken.accessToken.name);
      var client = http.Client();
      var request = http.MultipartRequest(
          'POST', Uri.parse('${ApiNetwork.baseApi}${ApiNetwork.uploadAvatar}'));
      request.files.add(await http.MultipartFile.fromPath(
        'ImageSrc',
        file.path,
        filename: 'image_$userGuid.jpg',
        contentType: MediaType(
            contentType.split('/').first, contentType.split('/').last),
      ));
      request.headers['Authorization'] = 'Bearer $token';
      request.headers['Content-Type'] = 'multipart/form-data';
      var response = await client.send(request);
      if (response.statusCode == 200) {
        var responseBody = await response.stream.bytesToString();
        var avatarInfo = userInfoResponseModelFromJson(responseBody);
        final sharedPreferences = await SharedPreferences.getInstance();
        var userInfo = accountSignInFromJson(
            sharedPreferences.getString('userLogin') ?? '');
        userInfo.result?.avatar = avatarInfo.result!.avatar ?? '';
        sharedPreferences.setString('userLogin', accountSignInToJson(userInfo));

        return avatarInfo;
      } else {
        throw Exception("Failed to load user info");
      }
    } catch (e) {
      throw Exception("Failed to load user info - $e");
    }
  }

  Future<UserInfoResponseModel> updateUserInfo(SingleUserDetail request) async {
    try {
      var baseEndpoint = await endPoint();
      final response = await baseEndpoint.put(ApiNetwork.updateInfo,
          data: singleUserDetailToJson(request));
      if (response.statusCode == 200) {
        return userInfoResponseModelFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load user info");
      }
    } catch (e) {
      throw Exception("Failed to load user info - $e");
    }
  }

  Future<BaseResponseServer> createUserSubscription() async {
    try {
      var baseEndpoint = await endPoint();
      final response =
          await baseEndpoint.post(ApiNetwork.userSubscription, data: {});
      if (response.statusCode == 200) {
        return baseResponseServerFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load user subscription info");
      }
    } catch (e) {
      throw Exception("Failed to load user subscription - $e");
    }
  }

  Future<BaseResponseServer> getUserSubscription() async {
    try {
      var baseEndpoint = await endPoint();
      final response = await baseEndpoint.get(ApiNetwork.userSubscription);
      if (response.statusCode == 200) {
        return baseResponseServerFromJson(response.data.toString());
      } else {
        throw Exception("Failed to load user subscription info");
      }
    } catch (e) {
      throw Exception("Failed to load user subscription - $e");
    }
  }
}
