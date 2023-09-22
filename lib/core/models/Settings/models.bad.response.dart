import 'dart:convert';

BadResponse badResponseFromJson(String str) =>
    BadResponse.fromJson(json.decode(str));

String badResponseToJson(BadResponse data) => json.encode(data.toJson());

class BadResponse {
  dynamic result;
  List<ErrorMessage> errorMessages;
  bool isOk;
  int statusCode;

  BadResponse({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory BadResponse.fromJson(Map<String, dynamic> json) => BadResponse(
        result: json["result"],
        errorMessages: List<ErrorMessage>.from(
            json["errorMessages"].map((x) => ErrorMessage.fromJson(x))),
        isOk: json["isOK"],
        statusCode: json["statusCode"],
      );

  Map<String, dynamic> toJson() => {
        "result": result,
        "errorMessages":
            List<dynamic>.from(errorMessages.map((x) => x.toJson())),
        "isOK": isOk,
        "statusCode": statusCode,
      };
}

class ErrorMessage {
  String errorCode;
  String errorMessage;
  List<String> errorValues;

  ErrorMessage({
    required this.errorCode,
    required this.errorMessage,
    required this.errorValues,
  });

  factory ErrorMessage.fromJson(Map<String, dynamic> json) => ErrorMessage(
        errorCode: json["errorCode"],
        errorMessage: json["errorMessage"],
        errorValues: List<String>.from(json["errorValues"].map((x) => x)),
      );

  Map<String, dynamic> toJson() => {
        "errorCode": errorCode,
        "errorMessage": errorMessage,
        "errorValues": List<dynamic>.from(errorValues.map((x) => x)),
      };
}
