import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:muonroi/core/authorization/enums/key.dart';
import 'package:muonroi/core/services/api_route.dart';
import 'package:muonroi/features/accounts/data/models/model.account.token.dart';
import 'package:muonroi/shared/settings/setting.main.dart';

bool isEmailValid(String email) {
  RegExp regex = RegExp(
      r'^(([^<>()[\]\\.,;:\s@"]+(\.[^<>()[\]\\.,;:\s@"]+)*)|(".+"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$');
  return regex.hasMatch(email);
}

bool isPhoneNumberValid(String phone) {
  RegExp regex = RegExp(
      r'^(\+\d{1,2}\s?)?1?\-?\.?\s?\(?\d{3}\)?[\s.-]?\d{3}[\s.-]?\d{4}$');
  return regex.hasMatch(phone);
}

Set<String> formatNameUser(String fullName) {
  var regex = RegExp(r"(.+)(?:\s(\w+))$");
  var match = regex.firstMatch(fullName);
  var result = <String>{};
  if (match != null) {
    String? firstName =
        match.group(1) != null ? match.group(1)!.trim() : match.group(1);
    String? lastName =
        match.group(2) != null ? match.group(2)!.trim() : match.group(2);
    result.addAll({firstName ?? '', lastName ?? ''});
    return result;
  }
  return result;
}

Future<void> refreshAccessToken() async {
  String? token = userBox.get(KeyToken.accessToken.name);
  String? refreshTokenStr = userBox.get(KeyToken.refreshToken.name);
  Dio dio = Dio();
  dio.options.baseUrl = ApiNetwork.baseApi;
  dio.options.responseType = ResponseType.plain;
  dio.options.headers['Authorization'] = 'Bearer $token';
  try {
    var response = await dio.post(ApiNetwork.renewToken,
        data: jsonEncode({"refreshToken": refreshTokenStr}));
    if (response.statusCode == 200) {
      var newToken = tokenModelFromJson(response.data.toString());
      userBox.put(KeyToken.accessToken.name, newToken.result);
      userBox.put(KeyToken.refreshToken.name, refreshTokenStr!);
    }
  } catch (e) {
    debugPrint(e.toString());
  }
}
