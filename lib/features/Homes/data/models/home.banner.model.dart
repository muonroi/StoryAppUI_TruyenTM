import 'dart:convert';

ModelBannerResponse modelBannerResponseFromJson(String str) =>
    ModelBannerResponse.fromJson(json.decode(str));

String modelBannerResponseToJson(ModelBannerResponse data) =>
    json.encode(data.toJson());

class ModelBannerResponse {
  Result result;
  List<dynamic> errorMessages;
  bool isOk;
  dynamic statusCode;

  ModelBannerResponse({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory ModelBannerResponse.fromJson(Map<String, dynamic> json) =>
      ModelBannerResponse(
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
  List<String> bannerUrl;
  String settingName;
  String content;
  int type;

  Result({
    required this.bannerUrl,
    required this.settingName,
    required this.content,
    required this.type,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        bannerUrl: List<String>.from(json["bannerUrl"].map((x) => x)),
        settingName: json["settingName"],
        content: json["content"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "bannerUrl": List<dynamic>.from(bannerUrl.map((x) => x)),
        "settingName": settingName,
        "content": content,
        "type": type,
      };
}
