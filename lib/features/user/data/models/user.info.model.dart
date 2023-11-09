// To parse this JSON data, do
//
//     final userInfoResponseModel = userInfoResponseModelFromJson(jsonString);

import 'dart:convert';

import 'package:muonroi/shared/settings/settings.images.dart';

UserInfoResponseModel userInfoResponseModelFromJson(String str) =>
    UserInfoResponseModel.fromJson(json.decode(str));

String userInfoResponseModelToJson(UserInfoResponseModel data) =>
    json.encode(data.toJson());

class UserInfoResponseModel {
  Result result;
  List<dynamic> errorMessages;
  bool isOk;
  dynamic statusCode;

  UserInfoResponseModel({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory UserInfoResponseModel.fromJson(Map<String, dynamic> json) =>
      UserInfoResponseModel(
        result: Result.fromJson(json["result"]),
        errorMessages: List<dynamic>.from(json["errorMessages"].map((x) => x)),
        isOk: json["isOK"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result.toJson(),
        "errorMessages": List<dynamic>.from(errorMessages.map((x) => x)),
        "isOK": isOk,
        "statusCode": statusCode,
      };
}

class Result {
  String name;
  String surname;
  String id;
  String username;
  String email;
  String address;
  bool emailConfirmed;
  DateTime lastLogin;
  String? avatar;
  int status;
  int accountStatus;
  dynamic note;
  dynamic lockReason;
  int groupId;
  DateTime createDate;
  DateTime updateDate;
  DateTime birthDate;
  String? roleName;
  String? groupName;
  String phoneNumber;
  Result({
    required this.name,
    required this.surname,
    required this.id,
    required this.username,
    required this.email,
    required this.address,
    required this.emailConfirmed,
    required this.lastLogin,
    required this.avatar,
    required this.status,
    required this.accountStatus,
    required this.note,
    required this.lockReason,
    required this.groupId,
    required this.createDate,
    required this.updateDate,
    required this.birthDate,
    required this.roleName,
    required this.groupName,
    required this.phoneNumber,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        name: json["name"],
        surname: json["surname"],
        id: json["id"],
        username: json["username"],
        email: json["email"],
        address: json["address"],
        emailConfirmed: json["emailConfirmed"],
        lastLogin: DateTime.parse(json["lastLogin"]),
        avatar: json["avatar"] ?? CustomImages.imageAvatarDefault,
        status: json["status"],
        accountStatus: json["accountStatus"],
        note: json["note"],
        lockReason: json["lockReason"],
        groupId: json["groupId"],
        createDate: DateTime.parse(json["createDate"]),
        updateDate: DateTime.parse(json["updateDate"]),
        birthDate: DateTime.parse(json["birthDate"]),
        roleName: json["roleName"],
        groupName: json["groupName"],
        phoneNumber: json["phoneNumber"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "id": id,
        "username": username,
        "email": email,
        "address": address,
        "emailConfirmed": emailConfirmed,
        "lastLogin": lastLogin.toIso8601String(),
        "avatar": avatar,
        "status": status,
        "accountStatus": accountStatus,
        "note": note,
        "lockReason": lockReason,
        "groupId": groupId,
        "createDate": createDate.toIso8601String(),
        "updateDate": updateDate.toIso8601String(),
        "birthDate": birthDate.toIso8601String(),
        "roleName": roleName,
        "groupName": groupName,
        "phoneNumber": phoneNumber,
      };
}
