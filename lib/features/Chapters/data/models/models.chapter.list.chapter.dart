import 'dart:convert';

import 'package:muonroi/features/chapters/settings/settings.dart';

ChapterInfo chapterInfoFromJson(String str) =>
    ChapterInfo.fromJson(json.decode(str));

String chapterInfoToJson(ChapterInfo data) => json.encode(data.toJson());

class ChapterInfo {
  Result result;
  List<dynamic> errorMessages;
  bool isOk;
  int statusCode;

  ChapterInfo({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory ChapterInfo.fromJson(Map<String, dynamic> json) => ChapterInfo(
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
  List<ChapterItems> items;
  PagingInfo pagingInfo;

  Result({
    required this.items,
    required this.pagingInfo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        items: List<ChapterItems>.from(
            json["items"].map((x) => ChapterItems.fromJson(x))),
        pagingInfo: PagingInfo.fromJson(json["pagingInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pagingInfo": pagingInfo.toJson(),
      };
}

class ChapterItems {
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

  ChapterItems({
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
  });

  factory ChapterItems.fromJson(Map<String, dynamic> json) => ChapterItems(
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
      );

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
      };
}

class PagingInfo {
  int pageSize;
  int page;
  int totalItems;

  PagingInfo({
    required this.pageSize,
    required this.page,
    required this.totalItems,
  });

  factory PagingInfo.fromJson(Map<String, dynamic> json) => PagingInfo(
        pageSize: json["pageSize"],
        page: json["page"],
        totalItems: json["totalItems"],
      );

  Map<String, dynamic> toJson() => {
        "pageSize": pageSize,
        "page": page,
        "totalItems": totalItems,
      };
}
