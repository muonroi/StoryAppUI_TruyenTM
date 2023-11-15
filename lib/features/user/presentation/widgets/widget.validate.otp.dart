import 'dart:convert';

ModelValidateOtp modelValidateOtpFromJson(String str) =>
    ModelValidateOtp.fromJson(json.decode(str));

String modelValidateOtpToJson(ModelValidateOtp data) =>
    json.encode(data.toJson());

class ModelValidateOtp {
  Result result;
  List<dynamic> errorMessages;
  bool isOk;
  int statusCode;

  ModelValidateOtp({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory ModelValidateOtp.fromJson(Map<String, dynamic> json) =>
      ModelValidateOtp(
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
  bool isVerify;
  String token;

  Result({
    required this.isVerify,
    required this.token,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        isVerify: json["isVerify"],
        token: json["token"],
      );

  Map<String, dynamic> toJson() => {
        "isVerify": isVerify,
        "token": token,
      };
}
