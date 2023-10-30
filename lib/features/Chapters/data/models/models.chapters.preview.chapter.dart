import 'dart:convert';

ChapterPreviewModel chapterPreviewModelFromJson(String str, int pageIndex) =>
    ChapterPreviewModel.fromJson(json.decode(str), pageIndex);

String chapterPreviewModelToJson(ChapterPreviewModel data) =>
    json.encode(data.toJson());

class ChapterPreviewModel {
  Result result;
  List<dynamic> errorMessages;
  bool isOk;
  int statusCode;
  int pageIndex;

  ChapterPreviewModel({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
    required this.pageIndex,
  });

  factory ChapterPreviewModel.fromJson(
          Map<String, dynamic> json, int pageIndex) =>
      ChapterPreviewModel(
          result: Result.fromJson(json["result"]),
          errorMessages:
              List<dynamic>.from(json["errorMessages"].map((x) => x)),
          isOk: json["isOK"],
          statusCode: json["statusCode"],
          pageIndex: pageIndex);

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
  int totalChapterAtLastChunk;
  Item({
    required this.chapterId,
    required this.numberOfChapter,
    required this.chapterName,
    required this.pageIndex,
    required this.totalChapterAtLastChunk,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      chapterId: json["chapterId"],
      numberOfChapter: json["numberOfChapter"],
      chapterName: json["chapterName"],
      pageIndex: json["index"],
      totalChapterAtLastChunk: json["totalChapterAtLastChunk"]);

  Map<String, dynamic> toJson() => {
        "chapterId": chapterId,
        "numberOfChapter": numberOfChapter,
        "chapterName": chapterName,
        "index": pageIndex,
        "totalChapterAtLastChunk": totalChapterAtLastChunk
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
