// To parse this JSON data, do
//
//     final plan = planFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

Plan planFromJson(String str) => Plan.fromJson(json.decode(str));

String planToJson(Plan data) => json.encode(data.toJson());

class Plan {
  Plan({
    required this.id,
    this.planName,
    this.duration,
    this.amount,
    this.image,
    this.bonusType,
    this.bonus,
    this.bonusCoinType,
    this.status,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? planName;
  double? duration;
  String? amount;
  dynamic image;
  int? bonusType;
  String? bonus;
  String? bonusCoinType;
  int? status;
  dynamic description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Plan.fromJson(Map<String, dynamic> json) => Plan(
    id: makeInt(json["id"]),
    planName: stringNullCheck(json["plan_name"]),
    duration: makeDouble(json["duration"]),
    amount: stringNullCheck(json["amount"]),
    image: json["image"],
    bonusType: makeInt(json["bonus_type"]),
    bonus: stringNullCheck(json["bonus"]),
    bonusCoinType: stringNullCheck(json["bonus_coin_type"]),
    status: makeInt(json["status"]),
    description: json["description"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_name": planName,
    "duration": duration,
    "amount": amount,
    "image": image,
    "bonus_type": bonusType,
    "bonus": bonus,
    "bonus_coin_type": bonusCoinType,
    "status": status,
    "description": description,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
