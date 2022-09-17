// To parse this JSON data, do
//
//     final activity = activityFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

Activity activityFromJson(String str) => Activity.fromJson(json.decode(str));

String activityToJson(Activity data) => json.encode(data.toJson());

class Activity {
  Activity({
    required this.id,
    this.userId,
    this.action,
    this.source,
    this.ipAddress,
    this.location,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  int? userId;
  String? action;
  String? source;
  String? ipAddress;
  String? location;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Activity.fromJson(Map<String, dynamic> json) => Activity(
    id: json["id"],
    userId: makeInt(json["user_id"]),
    action: json["action"],
    source: json["source"],
    ipAddress: json["ip_address"],
    location: json["location"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "action": action,
    "source": source,
    "ip_address": ipAddress,
    "location": location,
    "created_at": formatDate(createdAt,format: dateTimeFormatDdMMMMYyyyHhMm),
    "updated_at": formatDate(updatedAt,format: dateTimeFormatDdMMMMYyyyHhMm),
  };
}
