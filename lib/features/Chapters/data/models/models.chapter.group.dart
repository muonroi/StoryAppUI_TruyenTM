// To parse this JSON data, do
//
//     final groupChapters = groupChaptersFromJson(jsonString);

import 'dart:convert';

GroupChapters groupChaptersFromJson(String str) =>
    GroupChapters.fromJson(json.decode(str));

String groupChaptersToJson(GroupChapters data) => json.encode(data.toJson());

class GroupChapters {
  Result result;
  List<dynamic> errorMessages;
  bool isOk;
  int statusCode;

  GroupChapters({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory GroupChapters.fromJson(Map<String, dynamic> json) => GroupChapters(
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
  List<GroupChapterItems> items;
  PagingInfo pagingInfo;

  Result({
    required this.items,
    required this.pagingInfo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        items: List<GroupChapterItems>.from(
            json["items"].map((x) => GroupChapterItems.fromJson(x))),
        pagingInfo: PagingInfo.fromJson(json["pagingInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pagingInfo": pagingInfo.toJson(),
      };
}

class GroupChapterItems {
  dynamic bodyChunk;
  int chunkSize;
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

  GroupChapterItems({
    required this.bodyChunk,
    required this.chunkSize,
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

  factory GroupChapterItems.fromJson(Map<String, dynamic> json) =>
      GroupChapterItems(
        bodyChunk: json["bodyChunk"],
        chunkSize: json["chunkSize"],
        id: json["id"],
        chapterTitle: json["chapterTitle"],
        body: json["body"],
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
        "bodyChunk": bodyChunk,
        "chunkSize": chunkSize,
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
