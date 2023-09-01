import 'package:dio/dio.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/accounts/data/models/models.account.signin.dart';

class AccountsProvider {
  Future<AccountSignInModel> signIn(String username, String password) async {
    try {
      Map<String, dynamic> data = {
        'username': '$username',
        'password': '$password'
      };
      Dio dio = Dio(BaseOptions(
          baseUrl: ApiNetwork.baseApi, responseType: ResponseType.plain));
      final response = await dio.post(ApiNetwork.login, data: data);
      if (response.statusCode == 200) {
        return accountSignInFromJson(response.data.toString());
      } else {
        throw Exception("Failed to signin");
      }
    } catch (e) {
      throw Exception("Failed to signin");
    }
  }
}
