import 'dart:convert';

NotificationSignalr notificationSignalrFromJson(String str) =>
    NotificationSignalr.fromJson(json.decode(str));

String notificationSignalrToJson(NotificationSignalr data) =>
    json.encode(data.toJson());

class NotificationSignalr {
  String notificationContent;
  String timeCreated;
  String imgUrl;
  int type;
  NotificationSignalr({
    required this.notificationContent,
    required this.timeCreated,
    required this.imgUrl,
    required this.type,
  });

  factory NotificationSignalr.fromJson(Map<String, dynamic> json) =>
      NotificationSignalr(
        notificationContent: json["notificationcontent"],
        timeCreated: json["timecreated"],
        imgUrl: json["url"],
        type: json["type"],
      );

  Map<String, dynamic> toJson() => {
        "notificationcontent": notificationContent,
        "timecreated": timeCreated,
        "url": imgUrl,
        "type": type,
      };
}
