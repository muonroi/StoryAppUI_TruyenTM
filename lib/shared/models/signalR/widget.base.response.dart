import 'dart:convert';

BaseResponseServer baseResponseServerFromJson(String str) =>
    BaseResponseServer.fromJson(json.decode(str));

String baseResponseServerToJson(BaseResponseServer data) =>
    json.encode(data.toJson());

class BaseResponseServer {
  bool result;
  List<dynamic> errorMessages;
  bool isOk;
  dynamic statusCode;

  BaseResponseServer({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory BaseResponseServer.fromJson(Map<String, dynamic> json) =>
      BaseResponseServer(
        result: json["result"],
        errorMessages: List<dynamic>.from(json["errorMessages"].map((x) => x)),
        isOk: json["isOK"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "errorMessages": List<dynamic>.from(errorMessages.map((x) => x)),
        "isOK": isOk,
        "statusCode": statusCode,
      };
}
