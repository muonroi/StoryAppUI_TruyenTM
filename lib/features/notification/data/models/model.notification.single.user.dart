// To parse this JSON data, do
//
//     final notificationSingleUser = notificationSingleUserFromJson(jsonString);

import 'dart:convert';

NotificationSingleUser notificationSingleUserFromJson(String str) =>
    NotificationSingleUser.fromJson(json.decode(str));

String notificationSingleUserToJson(NotificationSingleUser data) =>
    json.encode(data.toJson());

class NotificationSingleUser {
  Result result;
  List<dynamic> errorMessages;
  bool isOk;
  int statusCode;

  NotificationSingleUser({
    required this.result,
    required this.errorMessages,
    required this.isOk,
    required this.statusCode,
  });

  factory NotificationSingleUser.fromJson(Map<String, dynamic> json) =>
      NotificationSingleUser(
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
  int id;
  String title;
  String notificationUrl;
  String imgUrl;
  int notificationSate;
  int notificationType;
  String message;
  String userGuid;
  int storyId;

  Item({
    required this.id,
    required this.title,
    required this.notificationUrl,
    required this.imgUrl,
    required this.message,
    required this.notificationSate,
    required this.notificationType,
    required this.userGuid,
    required this.storyId,
  });

  factory Item.fromJson(Map<String, dynamic> json) => Item(
      id: json["id"],
      title: json["title"],
      notificationUrl: json["notificationUrl"],
      imgUrl: json["imgUrl"],
      notificationSate: json["notificationSate"],
      notificationType: json["notificationType"],
      userGuid: json["userGuid"],
      storyId: json["storyId"],
      message: json['message']);

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "notificationUrl": notificationUrl,
        "imgUrl": imgUrl,
        "notificationSate": notificationSate,
        "notificationType": notificationType,
        "userGuid": userGuid,
        "storyId": storyId,
        "message": message
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
