import 'dart:convert';

import 'package:muonroi/features/chapters/data/models/models.chapter.group.dart';

DetailChapterInfo detailChapterInfoFromJson(String str) =>
    DetailChapterInfo.fromJson(json.decode(str));

String detailChapterInfoToJson(DetailChapterInfo data) =>
    json.encode(data.toJson());

class DetailChapterInfo {
  GroupChapterItems result;
  List<dynamic> errorMessages;
  bool isOk;
  int statusCode;

  DetailChapterInfo({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory DetailChapterInfo.fromJson(Map<String, dynamic> json) =>
      DetailChapterInfo(
        result: GroupChapterItems.fromJson(json["result"]),
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
