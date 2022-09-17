// To parse this JSON data, do
//
//     final allMembershipPlans = allMembershipPlansFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

AllMembershipPlans allMembershipPlansFromJson(String str) => AllMembershipPlans.fromJson(json.decode(str));

String allMembershipPlansToJson(AllMembershipPlans data) => json.encode(data.toJson());

class AllMembershipPlans {
  AllMembershipPlans({
    required this.id,
    this.planName,
    this.duration,
    this.amount,
    this.image,
    this.bonusType,
    this.bonusTypeName,
    this.bonus,
    this.bonusCoinType,
    this.status,
    this.statusName,
    this.description,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? planName;
  int? duration;
  double? amount;
  String? image;
  int? bonusType;
  String? bonusTypeName;
  double? bonus;
  String? bonusCoinType;
  int? status;
  String? statusName;
  dynamic description;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory AllMembershipPlans.fromJson(Map<String, dynamic> json) => AllMembershipPlans(
    id: json["id"],
    planName: json["plan_name"],
    duration: json["duration"],
    amount: makeDouble(json["amount"]),
    image: json["image"],
    bonusType: makeInt(json["bonus_type"]),
    bonusTypeName: json["bonus_type_name"],
    bonus: makeDouble(json["bonus"]),
    bonusCoinType: json["bonus_coin_type"],
    status: makeInt(json["status"]),
    statusName: json["status_name"],
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
    "bonus_type_name": bonusTypeName,
    "bonus": bonus,
    "bonus_coin_type": bonusCoinType,
    "status": status,
    "status_name": statusName,
    "description": description,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
