import 'dart:convert';

ChapterPreviewModel chapterPreviewModelFromJson(String str) =>
    ChapterPreviewModel.fromJson(json.decode(str));

String chapterPreviewModelToJson(ChapterPreviewModel data) =>
    json.encode(data.toJson());

class ChapterPreviewModel {
  Result result;
  List<dynamic> errorMessages;
  bool isOk;
  int statusCode;

  ChapterPreviewModel({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory ChapterPreviewModel.fromJson(Map<String, dynamic> json) =>
      ChapterPreviewModel(
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
  List<Item> items;
  PagingInfo pagingInfo;

  Result({
    required this.items,
    required this.pagingInfo,
  });

  factory Result.fromJson(Map<String, dynamic> json) => Result(
        items: List<Item>.from(json["items"].map((x) => Item.fromJson(x))),
        pagingInfo: PagingInfo.fromJson(json["pagingInfo"]),
      );

  Map<String, dynamic> toJson() => {
        "items": List<dynamic>.from(items.map((x) => x.toJson())),
        "pagingInfo": pagingInfo.toJson(),
      };
}

class Item {
  int chapterId;
  int numberOfChapter;
  String chapterName;
  int pageIndex;
  Item({
    required this.chapterId,
    required this.numberOfChapter,
    required this.chapterName,
    required this.pageIndex,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
        chapterId: json["chapterId"],
        numberOfChapter: json["numberOfChapter"],
        chapterName: json["chapterName"],
        pageIndex: json["index"],
      );

  Map<String, dynamic> toJson() => {
        "chapterId": chapterId,
        "numberOfChapter": numberOfChapter,
        "chapterName": chapterName,
        "index": pageIndex
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
