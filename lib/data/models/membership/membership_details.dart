// To parse this JSON data, do
//
//     final membershipDetails = membershipDetailsFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/data/models/membership/plan.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';

MembershipDetails membershipDetailsFromJson(String str) => MembershipDetails.fromJson(json.decode(str));

String membershipDetailsToJson(MembershipDetails data) => json.encode(data.toJson());

class MembershipDetails {
  MembershipDetails({
    required this.id,
    this.userId,
    this.planId,
    this.walletId,
    this.amount,
    this.startDate,
    this.endDate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.bonusAmount,
    this.coinName,
    this.planName,
    this.membershipStatus,
    this.planImage,
    this.plan,
  });

  int id;
  int? userId;
  int? planId;
  int? walletId;
  double? amount;
  DateTime? startDate;
  DateTime? endDate;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  double? bonusAmount;
  String? coinName;
  String? planName;
  String? membershipStatus;
  String? planImage;
  Plan? plan;

  factory MembershipDetails.fromJson(Map<String, dynamic> json) => MembershipDetails(
    id: makeInt(json["id"]),
    userId: makeInt(json["user_id"]),
    planId: makeInt(json["plan_id"]),
    walletId: makeInt(json["wallet_id"]),
    amount: makeDouble(json["amount"]),
    startDate: DateTime.parse(json["start_date"]),
    endDate: DateTime.parse(json["end_date"]),
    status: makeInt(json["status"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    bonusAmount: makeDouble(json["bonus_amount"]),
    coinName: stringNullCheck(json["coin_name"]),
    planName: stringNullCheck(json["plan_name"]),
    membershipStatus: stringNullCheck(json["membership_status"]),
    planImage: stringNullCheck(json["plan_image"]),
    plan: Plan.fromJson(json["plan"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "plan_id": planId,
    "wallet_id": walletId,
    "amount": amount,
    "start_date": "${startDate!.year.toString().padLeft(4, '0')}-${startDate!.month.toString().padLeft(2, '0')}-${startDate!.day.toString().padLeft(2, '0')}",
    "end_date": "${endDate!.year.toString().padLeft(4, '0')}-${endDate!.month.toString().padLeft(2, '0')}-${endDate!.day.toString().padLeft(2, '0')}",
    "status": status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "bonus_amount": bonusAmount,
    "coin_name": coinName,
    "plan_name": planName,
    "membership_status": membershipStatus,
    "plan_image": planImage,
    "plan": plan!.toJson(),
  };
}
