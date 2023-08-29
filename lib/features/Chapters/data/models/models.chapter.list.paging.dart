// To parse this JSON data, do
//
//     final listPagingChapters = listPagingChaptersFromJson(jsonString);

import 'dart:convert';

ListPagingChapters listPagingChaptersFromJson(String str) =>
    ListPagingChapters.fromJson(json.decode(str));

String listPagingChaptersToJson(ListPagingChapters data) =>
    json.encode(data.toJson());

class ListPagingChapters {
  List<Result> result;
  List<dynamic> errorMessages;
  bool isOk;
  int statusCode;

  ListPagingChapters({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory ListPagingChapters.fromJson(Map<String, dynamic> json) =>
      ListPagingChapters(
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
  int from;
  int to;
  int fromId;
  int toId;

  Result({
    required this.from,
    required this.to,
    required this.fromId,
    required this.toId,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        from: json["from"],
        to: json["to"],
        fromId: json["fromId"],
        toId: json["toId"],
      );

  Map<String, dynamic> toJson() => {
        "from": from,
        "to": to,
        "fromId": fromId,
        "toId": toId,
      };
}
