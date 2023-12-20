import 'dart:convert';

ModelSettingResponse getSettingResponseFromJson(String str) =>
    ModelSettingResponse.fromJson(json.decode(str));

String getSettingResponseToJson(ModelSettingResponse data) =>
    json.encode(data.toJson());

class ModelSettingResponse {
  List<Result> result;
  List<dynamic> errorMessages;
  bool isOk;
  dynamic statusCode;

  ModelSettingResponse({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory ModelSettingResponse.fromJson(Map<String, dynamic> json) =>
      ModelSettingResponse(
        result:
            List<Result>.from(json["result"].map((x) => Result.fromJson(x))),
        errorMessages: List<dynamic>.from(json["errorMessages"].map((x) => x)),
        isOk: json["isOK"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": List<dynamic>.from(result.map((x) => x.toJson())),
        "errorMessages": List<dynamic>.from(errorMessages.map((x) => x)),
        "isOK": isOk,
        "statusCode": statusCode,
      };
}

class Result {
  String settingName;
  String content;
  int type;

  Result({
    required this.settingName,
    required this.content,
    required this.type,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        settingName: json["settingName"],
        content: json["content"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "settingName": settingName,
        "content": content,
        "type": type,
      };
}
