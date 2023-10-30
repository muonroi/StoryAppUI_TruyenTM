// ignore_for_file: public_member_api_docs, sort_constructors_first
// To parse this JSON data, do
//
//     final accountSignIn = accountSignInFromJson(jsonString);

import 'dart:convert';

AccountSignInModel accountSignInFromJson(String str) =>
    AccountSignInModel.fromJson(json.decode(str));

String accountSignInToJson(AccountSignInModel data) =>
    json.encode(data.toJson());

class AccountSignInModel {
  AccountResult? result;
  List<dynamic> errorMessages;
  bool isOk;
  int statusCode;

  AccountSignInModel({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory AccountSignInModel.fromJson(Map<String, dynamic> json) =>
      AccountSignInModel(
        result: AccountResult.fromJson(json["result"]),
        errorMessages: List<dynamic>.from(json["errorMessages"].map((x) => x)),
        isOk: json["isOK"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        // ignore: prefer_null_aware_operators
        "result": result != null ? result?.toJson() : null,
        "errorMessages": List<dynamic>.from(errorMessages.map((x) => x)),
        "isOK": isOk,
        "statusCode": statusCode,
      };
}

class AccountResult {
  bool isDeleted;
  String jwtToken;
  String refreshToken;
  dynamic locationUserLogin;
  String name;
  String surname;
  String id;
  String username;
  String email;
  String address;
  bool emailConfirmed;
  DateTime lastLogin;
  String avatar;
  int status;
  int accountStatus;
  dynamic note;
  dynamic lockReason;
  int groupId;
  DateTime createDate;
  DateTime updateDate;
  DateTime birthDate;
  String roleName;
  String groupName;
  String phoneNumber;
  int notificationNumber;
  AccountResult({
    required this.isDeleted,
    required this.jwtToken,
    required this.refreshToken,
    required this.locationUserLogin,
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
    required this.notificationNumber,
  });

  factory AccountResult.fromJson(Map<String, dynamic> json) => AccountResult(
      isDeleted: json["isDeleted"],
      jwtToken: json["jwtToken"],
      refreshToken: json["refreshToken"],
      locationUserLogin: json["locationUserLogin"] ?? "",
      name: json["name"],
      surname: json["surname"],
      id: json["id"],
      username: json["username"],
      email: json["email"],
      address: json["address"],
      emailConfirmed: json["emailConfirmed"],
      lastLogin: DateTime.parse(json["lastLogin"]),
      avatar: json["avatar"] ?? "",
      status: json["status"],
      accountStatus: json["accountStatus"],
      note: json["note"] ?? "",
      lockReason: json["lockReason"] ?? "",
      groupId: json["groupId"],
      createDate: DateTime.parse(json["createDate"]),
      updateDate: DateTime.parse(json["updateDate"]),
      birthDate: DateTime.parse(json["birthDate"]),
      roleName: json["roleName"],
      groupName: json["groupName"],
      phoneNumber: json["phoneNumber"],
      notificationNumber: json["notificationNumber"]);

  Map<String, dynamic> toJson() => {
        "isDeleted": isDeleted,
        "jwtToken": jwtToken,
        "refreshToken": refreshToken,
        "locationUserLogin": locationUserLogin,
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
        "notificationNumber": notificationNumber
      };
}
