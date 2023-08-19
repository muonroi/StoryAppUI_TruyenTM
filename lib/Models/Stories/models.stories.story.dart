import 'dart:convert';

StoriesModel storiesFromJson(String str) =>
    StoriesModel.fromJson(json.decode(str));

String storiesToJson(StoriesModel data) => json.encode(data.toJson());

class StoriesModel {
  final Result result;
  final List<dynamic> errorMessages;
  final bool isOk;
  final dynamic statusCode;

  StoriesModel({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory StoriesModel.fromJson(Map<String, dynamic> json) => StoriesModel(
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

  StoryItems({
    required this.rankNumber,
    required this.totalChapter,
    required this.totalVote,
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
    required this.updatedDateTs,
    required this.updatedDateString,
  });

  factory StoryItems.fromJson(Map<String, dynamic> json) => StoryItems(
        rankNumber: json["rankNumber"],
        totalChapter: json["totalChapter"],
        id: json["id"],
        guid: json["guid"],
        storyTitle: json["storyTitle"],
        storySynopsis: json["storySynopsis"],
        imgUrl: json["imgUrl"],
        isShow: json["isShow"],
        totalVote: json["totalVote"],
        totalView: json["totalView"],
        totalFavorite: json["totalFavorite"],
        rating: double.parse(json["rating"].toString()),
        slug: json["slug"],
        nameCategory: json["nameCategory"],
        authorName: json["authorName"],
        nameTag: List<dynamic>.from(json["nameTag"].map((x) => x)),
        updatedDateTs: json["updatedDateTs"],
        updatedDateString: json["updatedDateString"],
      );

  Map<String, dynamic> toJson() => {
        "rankNumber": rankNumber,
        "totalChapter": totalChapter,
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
