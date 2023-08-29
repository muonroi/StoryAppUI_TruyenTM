import 'dart:convert';

DetailChapterInfo detailChapterInfoFromJson(String str) =>
    DetailChapterInfo.fromJson(json.decode(str));

String detailChapterInfoToJson(DetailChapterInfo data) =>
    json.encode(data.toJson());

class DetailChapterInfo {
  Result result;
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
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
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
