import 'dart:convert';

SingleStoryModel singleStoryModelFromJson(String str) =>
    SingleStoryModel.fromJson(json.decode(str));

String singleStoryModelToJson(SingleStoryModel data) =>
    json.encode(data.toJson());

class SingleStoryModel {
  StorySingleResult result;
  List<dynamic> errorMessages;
  bool isOk;
  dynamic statusCode;

  SingleStoryModel({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory SingleStoryModel.fromJson(Map<String, dynamic> json) =>
      SingleStoryModel(
        result: StorySingleResult.fromJson(json["result"]),
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

class StorySingleResult {
  int rankNumber;
  int totalChapter;
  int id;
  String guid;
  String storyTitle;
  String storySynopsis;
  String imgUrl;
  bool isShow;
  int totalView;
  int totalVote;
  int totalFavorite;
  double rating;
  String slug;
  String nameCategory;
  String authorName;
  List<dynamic> nameTag;
  int updatedDateTs;
  String updatedDateString;
  int firstChapterId;
  int lastChapterId;
  String slugAuthor;
  bool isBookmark;
  int totalPageIndex;
  StorySingleResult({
    required this.rankNumber,
    required this.totalChapter,
    required this.id,
    required this.guid,
    required this.storyTitle,
    required this.storySynopsis,
    required this.imgUrl,
    required this.isShow,
    required this.totalView,
    required this.totalVote,
    required this.totalFavorite,
    required this.rating,
    required this.slug,
    required this.nameCategory,
    required this.authorName,
    required this.nameTag,
    required this.updatedDateTs,
    required this.updatedDateString,
    required this.firstChapterId,
    required this.lastChapterId,
    required this.slugAuthor,
    required this.isBookmark,
    required this.totalPageIndex,
  });

  factory StorySingleResult.fromJson(Map<String, dynamic> json) =>
      StorySingleResult(
        rankNumber: json["rankNumber"],
        totalChapter: json["totalChapter"],
        id: json["id"],
        guid: json["guid"],
        storyTitle: json["storyTitle"],
        storySynopsis: json["storySynopsis"],
        imgUrl: json["imgUrl"],
        isShow: json["isShow"],
        totalView: json["totalView"],
        totalVote: json["totalVote"],
        totalFavorite: json["totalFavorite"],
        rating: double.parse(json["rating"].toString()),
        slug: json["slug"],
        nameCategory: json["nameCategory"],
        authorName: json["authorName"],
        nameTag: List<dynamic>.from(json["nameTag"].map((x) => x)),
        updatedDateTs: json["updatedDateTs"],
        updatedDateString: json["updatedDateString"],
        firstChapterId: json["firstChapterId"],
        lastChapterId: json["lastChapterId"],
        slugAuthor: json["slugAuthor"],
        isBookmark: json["isBookmark"],
        totalPageIndex: json["totalPageIndex"],
      );

  Map<String, dynamic> toJson() => {
        "rankNumber": rankNumber,
        "totalChapter": totalChapter,
        "id": id,
        "guid": guid,
        "storyTitle": storyTitle,
        "storySynopsis": storySynopsis,
        "imgUrl": imgUrl,
        "totalVote": totalVote,
        "isShow": isShow,
        "totalView": totalView,
        "totalFavorite": totalFavorite,
        "rating": rating,
        "slug": slug,
        "nameCategory": nameCategory,
        "authorName": authorName,
        "nameTag": List<dynamic>.from(nameTag.map((x) => x)),
        "updatedDateTs": updatedDateTs,
        "updatedDateString": updatedDateString,
        "slugAuthor": slugAuthor,
        "isBookmark": isBookmark,
        "firstChapterId": firstChapterId,
        "lastChapterId": lastChapterId,
        "totalPageIndex": totalPageIndex,
      };
}
