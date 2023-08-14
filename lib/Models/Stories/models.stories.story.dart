import 'dart:convert';

StoryModel storyFromJson(String str) => StoryModel.fromJson(json.decode(str));

String storyToJson(StoryModel data) => json.encode(data.toJson());

class StoryModel {
  final Result result;
  final List<dynamic> errorMessages;
  final bool isOk;
  final dynamic statusCode;

  StoryModel({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory StoryModel.fromJson(Map<String, dynamic> json) => StoryModel(
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
  final List<StoryItems> items;
  final PagingInfo pagingInfo;

  Result({
    required this.items,
    required this.pagingInfo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        items: List<StoryItems>.from(
            json["items"].map((x) => StoryItems.fromJson(x))),
        pagingInfo: PagingInfo.fromJson(json["pagingInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pagingInfo": pagingInfo.toJson(),
      };
}

class StoryItems {
  final int id;
  final String guid;
  final String storyTitle;
  final String storySynopsis;
  final String imgUrl;
  final bool isShow;
  final int totalView;
  final int totalFavorite;
  final double rating;
  final String slug;
  final String nameCategory;
  final String authorName;
  final List<dynamic> nameTag;
  final int totalChapters;
  final int updatedDateTs;
  final String updatedDateString;

  StoryItems({
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

  factory StoryItems.fromJson(Map<String, dynamic> json) => StoryItems(
        id: json["id"],
        guid: json["guid"],
        storyTitle: json["storyTitle"],
        storySynopsis: json["storySynopsis"],
        imgUrl: json["imgUrl"],
        isShow: json["isShow"],
        totalView: json["totalView"],
        totalFavorite: json["totalFavorite"],
        rating: json["rating"] * 1.0,
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

class PagingInfo {
  final int pageSize;
  final int page;
  final int totalItems;

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
