import 'dart:convert';

DetailChapterInfo detailChapterInfoFromJson(String str) =>
    DetailChapterInfo.fromJson(json.decode(str));

String detailChapterInfoToJson(DetailChapterInfo data) =>
    json.encode(data.toJson());

class DetailChapterInfo {
  DetailChapterResult result;
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
        result: DetailChapterResult.fromJson(json["result"]),
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

class DetailChapterResult {
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
  List<String> bodyChunk;
  int chunkSize;
  DetailChapterResult({
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
    required this.bodyChunk,
    required this.chunkSize,
  });
  factory DetailChapterResult.fromJson(Map<String, dynamic> json) =>
      DetailChapterResult(
        bodyChunk: List<String>.from(json["bodyChunk"].map((x) => x)),
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
        "bodyChunk": List<dynamic>.from(bodyChunk.map((x) => x)),
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
