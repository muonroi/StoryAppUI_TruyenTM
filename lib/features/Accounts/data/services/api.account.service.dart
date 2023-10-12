import 'package:dio/dio.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';

class AccountsService {
  Future<AccountSignInModel> signIn(String username, String password) async {
    try {
      Map<String, dynamic> data = {'username': username, 'password': password};
      Dio dio = Dio(BaseOptions(
          baseUrl: ApiNetwork.baseApi, responseType: ResponseType.plain));
      final response = await dio.post(ApiNetwork.login, data: data);
      if (response.statusCode == 200) {
        return accountSignInFromJson(response.data.toString());
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return AccountSignInModel(
            result: null, errorMessages: [], isOk: false, statusCode: 400);
      }
    }
    return AccountSignInModel(
        result: null, errorMessages: [], isOk: false, statusCode: 400);
  }

  Future<bool> forgotPassword(String username) async {
    try {
      Map<String, dynamic> data = {
        'username': username,
      };
      Dio dio = Dio(BaseOptions(
          baseUrl: ApiNetwork.baseApi, responseType: ResponseType.plain));
      final response = await dio.post(ApiNetwork.forgotPassword, data: data);
      if (response.statusCode == 200) {
        return true;
      }
    } on DioException catch (e) {
      if (e.type == DioExceptionType.badResponse) {
        return false;
      }
    }
    return false;
  }
}
