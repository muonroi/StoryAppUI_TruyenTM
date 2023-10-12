import 'dart:convert';

SingleUserDetail singleUserDetailFromJson(String str) =>
    SingleUserDetail.fromJson(json.decode(str));

String singleUserDetailToJson(SingleUserDetail data) =>
    json.encode(data.toJson());

class SingleUserDetail {
  String name;
  String surname;
  String userName;
  String phoneNumber;
  String email;
  String address;
  DateTime birthDate;
  int gender;
  String? avatarTemp;
  String? newSalf;
  String? newPassword;
  int accountStatus;
  String reason;

  SingleUserDetail({
    required this.name,
    required this.surname,
    required this.userName,
    required this.phoneNumber,
    required this.email,
    required this.address,
    required this.birthDate,
    required this.gender,
    required this.avatarTemp,
    this.newSalf,
    this.newPassword,
    required this.accountStatus,
    required this.reason,
  });

  factory SingleUserDetail.fromJson(Map<String, dynamic> json) =>
      SingleUserDetail(
        name: json["name"],
        surname: json["surname"],
        userName: json["userName"],
        phoneNumber: json["phoneNumber"],
        email: json["email"],
        address: json["address"],
        birthDate: DateTime.parse(json["birthDate"]),
        gender: json["gender"],
        avatarTemp: json["avatarTemp"],
        newSalf: json["newSalf"],
        newPassword: json["newPassword"],
        accountStatus: json["accountStatus"],
        reason: json["reason"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "surname": surname,
        "userName": userName,
        "phoneNumber": phoneNumber,
        "email": email,
        "address": address,
        "birthDate": birthDate.toIso8601String(),
        "gender": gender,
        "avatarTemp": avatarTemp,
        "newSalf": newSalf,
        "newPassword": newPassword,
        "accountStatus": accountStatus,
        "reason": reason,
      };
}
