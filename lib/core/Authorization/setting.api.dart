import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:muonroi/core/Authorization/enums/key.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/accounts/data/models/models.account.token.dart';
import 'package:muonroi/features/accounts/data/repository/accounts.repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

Future<Dio> endPoint() async {
  var sharedPreferences = await SharedPreferences.getInstance();
  String? token = sharedPreferences.getString(KeyToken.accessToken.name);
  String refreshTokenStr = "";
  if (token == null) {
    AccountRepository account = AccountRepository('muonroi', '0967442142Az*');
    var accountInfo = await account.signIn();
    sharedPreferences.setString(
        KeyToken.accessToken.name, accountInfo.result.jwtToken);
    sharedPreferences.setString(
        KeyToken.refreshToken.name, accountInfo.result.refreshToken);
    token = sharedPreferences.getString(KeyToken.accessToken.name)!;
    refreshTokenStr = sharedPreferences.getString(KeyToken.refreshToken.name)!;
  }

  Dio dio = Dio();
  dio.options.baseUrl = ApiNetwork.baseApi;
  dio.options.responseType = ResponseType.plain;
  // dio.interceptors.add(LogInterceptor());
  dio.interceptors.add(
    InterceptorsWrapper(
      onRequest: (request, handler) {
        if (token != '') {
          request.headers['Authorization'] = 'Bearer $token';
        }
        return handler.next(request);
      },
      onError: (e, handler) async {
        if (e.response?.statusCode == 401) {
          try {
            await dio
                .post(ApiNetwork.renewToken,
                    data: jsonEncode({"refreshToken": refreshTokenStr}))
                .then((value) async {
              if (value.statusCode == 200) {
                var newToken = tokenModelFromJson(value.data.toString());
                token = newToken.result;
                e.requestOptions.headers["Authorization"] =
                    "Bearer ${newToken.result}";
                final opts = Options(
                    method: e.requestOptions.method,
                    headers: e.requestOptions.headers);
                final cloneReq = await dio.request(e.requestOptions.path,
                    options: opts, data: e.requestOptions.data);
                return handler.resolve(cloneReq);
              }
            });
          } catch (e) {
            return;
          }
        }
      },
    ),
  );
  return dio;
}
