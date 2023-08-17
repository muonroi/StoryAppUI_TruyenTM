import 'dart:convert';

SingleStoryModel singleStoryModelFromJson(String str) =>
    SingleStoryModel.fromJson(json.decode(str));

String singleStoryModelToJson(SingleStoryModel data) =>
    json.encode(data.toJson());

class SingleStoryModel {
  SingleResult result;
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
        result: SingleResult.fromJson(json["result"]),
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

class SingleResult {
  int id;
  String guid;
  String storyTitle;
  String storySynopsis;
  String imgUrl;
  bool isShow;
  int totalView;
  int totalFavorite;
  int rating;
  String slug;
  String nameCategory;
  String authorName;
  List<dynamic> nameTag;
  int totalChapters;
  int updatedDateTs;
  String updatedDateString;

  SingleResult({
    required this.id,
    required this.guid,
    required this.storyTitle,
    required this.storySynopsis,
    required this.imgUrl,
    required this.isShow,
    required this.totalView,
    required this.totalFavorite,
    required this.rating,
    required this.slug,
    required this.nameCategory,
    required this.authorName,
    required this.nameTag,
    required this.totalChapters,
    required this.updatedDateTs,
    required this.updatedDateString,
  });

  factory SingleResult.fromJson(Map<String, dynamic> json) => SingleResult(
        id: json["id"],
        guid: json["guid"],
        storyTitle: json["storyTitle"],
        storySynopsis: json["storySynopsis"],
        imgUrl: json["imgUrl"],
        isShow: json["isShow"],
        totalView: json["totalView"],
        totalFavorite: json["totalFavorite"],
        rating: json["rating"],
        slug: json["slug"],
        nameCategory: json["nameCategory"],
        authorName: json["authorName"],
        nameTag: List<dynamic>.from(json["nameTag"].map((x) => x)),
        totalChapters: json["totalChapters"],
        updatedDateTs: json["updatedDateTs"],
        updatedDateString: json["updatedDateString"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "guid": guid,
        "storyTitle": storyTitle,
        "storySynopsis": storySynopsis,
        "imgUrl": imgUrl,
        "isShow": isShow,
        "totalView": totalView,
        "totalFavorite": totalFavorite,
        "rating": rating,
        "slug": slug,
        "nameCategory": nameCategory,
        "authorName": authorName,
        "nameTag": List<dynamic>.from(nameTag.map((x) => x)),
        "totalChapters": totalChapters,
        "updatedDateTs": updatedDateTs,
        "updatedDateString": updatedDateString,
      };
}
