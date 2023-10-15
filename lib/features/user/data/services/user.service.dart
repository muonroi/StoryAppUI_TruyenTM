import 'package:flutter/foundation.dart';
import 'package:muonroi/core/Authorization/setting.api.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/user/data/models/user.info.model.dart';
import 'package:muonroi/features/user/data/models/user.single.detail.model.dart';
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
        throw Exception("Failed to load user info");
      }
    } catch (e) {
      throw Exception("Failed to load user info - $e");
    }
  }

  Future<UserInfoResponseModel> updateUserInfo(SingleUserDetail request) async {
    try {
      var baseEndpoint = await endPoint();
      debugPrint(singleUserDetailToJson(request));
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

//   Future<UserInfoResponseModel> uploadAvatarUser(
//       File file, String userGuid) async {
//     try {
//       String fileName = basename(file.path);
//       // Map<String, MultipartFile> fileMap = {
//       //   'ImageSrc': MultipartFile(file.openRead(), await file.length(),
//       //       filename: 'muonroi_$fileName')
//       // };
//       //var formData = FormData.fromMap(fileMap);
//       // var baseEndpoint = await endPoint();
//       // final response = await baseEndpoint.post(ApiNetwork.uploadAvatar,
//       //     data: formData, options: Options(contentType: 'multipart/form-data'));
//       if (response.statusCode == 200) {
//         return userInfoResponseModelFromJson(response.data.toString());
//       } else {
//         throw Exception("Failed to load user info");
//       }
//     } on DioException catch (e) {
//       throw Exception("Failed to load user info - $e");
//     }
//   }
}
