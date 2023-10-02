// To parse this JSON data, do
//
//     final notificationListModel = notificationListModelFromJson(jsonString);

import 'dart:convert';

List<NotificationListModel> notificationListModelFromJson(String str) => List<NotificationListModel>.from(json.decode(str).map((x) => NotificationListModel.fromJson(x)));

String notificationListModelToJson(List<NotificationListModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NotificationListModel {
    int? notificationId;
    DateTime? date;
    String? message;
    String? title;
    int? isImportant;
    int? isRead;
    String? appId;
    String? appName;
    String? route;
    String? from;
    int? isFavorite;
    String? appIconUrl;

    NotificationListModel({
        this.notificationId,
        this.date,
        this.message,
        this.title,
        this.isImportant,
        this.isRead,
        this.appId,
        this.appName,
        this.route,
        this.from,
        this.isFavorite,
        this.appIconUrl,
    });

    factory NotificationListModel.fromJson(Map<String, dynamic> json) => NotificationListModel(
        notificationId: json["notificationId"],
        date: json["date"] == null ? null : DateTime.parse(json["date"]),
        message: json["message"],
        title: json["title"],
        isImportant: json["isImportant"],
        isRead: json["isRead"],
        appId: json["appId"],
        appName: json["appName"],
        route: json["route"],
        from: json["from"],
        isFavorite: json["isFavorite"],
        appIconUrl: json["appIconUrl"],
    );

    Map<String, dynamic> toJson() => {
        "notificationId": notificationId,
        "date": date?.toIso8601String(),
        "message": message,
        "title": title,
        "isImportant": isImportant,
        "isRead": isRead,
        "appId": appId,
        "appName": appName,
        "route": route,
        "from": from,
        "isFavorite": isFavorite,
        "appIconUrl": appIconUrl,
    };
}
