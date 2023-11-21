import 'dart:convert';

import 'package:muonroi/features/chapters/settings/settings.dart';

ListPagingRangeChapters listPagingRangeChaptersFromJson(String str) =>
    ListPagingRangeChapters.fromJson(json.decode(str));

String listPagingRangeChaptersToJson(ListPagingRangeChapters data) =>
    json.encode(data.toJson());

class ListPagingRangeChapters {
  List<Result> result;
  List<dynamic> errorMessages;
  bool isOk;
  int statusCode;

  ListPagingRangeChapters({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory ListPagingRangeChapters.fromJson(Map<String, dynamic> json) =>
      ListPagingRangeChapters(
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
  int id;
  String chapterTitle;
  String body;
  int numberOfChapter;
  int numberOfWord;
  int storyId;
  String slug;
  int createdDateTs;
  int updatedDateTs;
  String createdUserName;
  String updatedUserName;
  int pageIndex;
  int groupIndex;
  Result({
    required this.id,
    required this.chapterTitle,
    required this.body,
    required this.numberOfChapter,
    required this.numberOfWord,
    required this.storyId,
    required this.slug,
    required this.createdDateTs,
    required this.updatedDateTs,
    required this.createdUserName,
    required this.updatedUserName,
    required this.pageIndex,
    required this.groupIndex,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
      id: json["id"],
      chapterTitle: json["chapterTitle"],
      body: decryptStringAES(json["body"]),
      numberOfChapter: json["numberOfChapter"],
      numberOfWord: json["numberOfWord"],
      storyId: json["storyId"],
      slug: json["slug"],
      createdDateTs: json["createdDateTS"],
      updatedDateTs: json["updatedDateTS"],
      createdUserName: json["createdUserName"],
      updatedUserName: json["updatedUserName"],
      pageIndex: json["index"],
      groupIndex: json["groupIndex"]);

  Map<String, dynamic> toJson() => {
        "id": id,
        "chapterTitle": chapterTitle,
        "body": body,
        "numberOfChapter": numberOfChapter,
        "numberOfWord": numberOfWord,
        "storyId": storyId,
        "slug": slug,
        "createdDateTS": createdDateTs,
        "updatedDateTS": updatedDateTs,
        "createdUserName": createdUserName,
        "updatedUserName": updatedUserName,
        "index": pageIndex,
        "current_group_index": groupIndex
      };
}
