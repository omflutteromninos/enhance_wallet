// To parse this JSON data, do
//
//     final appNotificationResponse = appNotificationResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

AppNotificationResponse appNotificationResponseFromJson(String str) => AppNotificationResponse.fromJson(json.decode(str));

String appNotificationResponseToJson(AppNotificationResponse data) => json.encode(data.toJson());

class AppNotificationResponse {
  AppNotificationResponse({
    this.id,
    this.userId,
    this.title,
    this.notificationBody,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int? id;
  int? userId;
  String? title;
  String? notificationBody;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AppNotificationResponse.fromJson(Map<String, dynamic> json) => AppNotificationResponse(
    id: json["id"],
    userId: makeInt(json["user_id"]),
    title: json["title"],
    notificationBody: json["notification_body"],
    status: json["status"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "title": title,
    "notification_body": notificationBody,
    "status": status,
    "created_at": createdAt!.toIso8601String(),
    "updated_at": updatedAt!.toIso8601String(),
  };
}
