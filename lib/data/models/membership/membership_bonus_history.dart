
// To parse this JSON data, do
//
//     final membershipBonusHistory = membershipBonusHistoryFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/data/models/membership/plan.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';

import '../user.dart';

MembershipBonusHistory membershipBonusHistoryFromJson(String str) => MembershipBonusHistory.fromJson(json.decode(str));

String membershipBonusHistoryToJson(MembershipBonusHistory data) => json.encode(data.toJson());

class MembershipBonusHistory {
  MembershipBonusHistory({
    required this.id,
    this.userId,
    this.planId,
    this.walletId,
    this.membershipId,
    this.distributionDate,
    this.bonusAmount,
    this.planCurrentBonus,
    this.bonusType,
    this.bonusAmountBtc,
    this.bonusCoinType,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.planName,
    this.walletName,
    this.email,
    this.plan,
    this.wallet,
  });

  int id;
  int? userId;
  int? planId;
  int? walletId;
  int? membershipId;
  DateTime? distributionDate;
  double? bonusAmount;
  double? planCurrentBonus;
  int? bonusType;
  double? bonusAmountBtc;
  String? bonusCoinType;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? planName;
  String? walletName;
  String? email;
  Plan? plan;
  Wallet? wallet;

  factory MembershipBonusHistory.fromJson(Map<String, dynamic> json) => MembershipBonusHistory(
    id: json["id"],
    userId: makeInt(json["user_id"]),
    planId: json["plan_i"],
    walletId: makeInt(json["wallet_id"]),
    membershipId: makeInt(json["membership_id"]),
    distributionDate: DateTime.parse(json["distribution_date"]),
    bonusAmount: makeDouble(json["bonus_amount"]),
    planCurrentBonus: makeDouble(json["plan_current_bonus"]),
    bonusType: json["bonus_type"],
    bonusAmountBtc: makeDouble(json["bonus_amount_btc"]),
    bonusCoinType: json["bonus_coin_type"],
    status: makeInt(json["status"]),
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"],
    planName: json["plan_name"],
    walletName: json["wallet_name"],
    email: json["email"],
    plan: Plan.fromJson(json["plan"]),
    wallet: Wallet.fromJson(json["wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "plan_id": planId,
    "wallet_id": walletId,
    "membership_id": membershipId,
    "distribution_date": "${distributionDate!.year.toString().padLeft(4, '0')}-${distributionDate!.month.toString().padLeft(2, '0')}-${distributionDate!.day.toString().padLeft(2, '0')}",
    "bonus_amount": bonusAmount,
    "plan_current_bonus": planCurrentBonus,
    "bonus_type": bonusType,
    "bonus_amount_btc": bonusAmountBtc,
    "bonus_coin_type": bonusCoinType,
    "status": status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "plan_name": planName,
    "wallet_name": walletName,
    "email": email,
    "plan": plan!.toJson(),
    "wallet": wallet!.toJson(),
  };
}


class Wallet {
  Wallet({
    required this.id,
    this.userId,
    this.name,
    this.coinType,
    this.coinId,
    this.status,
    this.isPrimary,
    this.balance,
    this.referralBalance,
    this.createdAt,
    this.updatedAt,
    this.key,
    this.type,
    this.user,
  });

  int id;
  int? userId;
  String? name;
  String? coinType;
  int? coinId;
  int? status;
  int? isPrimary;
  String? balance;
  String? referralBalance;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? key;
  int? type;
  User? user;

  factory Wallet.fromJson(Map<String, dynamic> json) => Wallet(
    id: json["id"],
    userId: makeInt(json["user_id"]),
    name: json["name"],
    coinType: json["coin_type"],
    coinId: json["coin_id"],
    status: json["status"],
    isPrimary: json["is_primary"],
    balance: json["balance"],
    referralBalance: json["referral_balance"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    key: json["key"],
    type: json["type"],
    user: User.fromJson(json["user"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "name": name,
    "coin_type": coinType,
    "coin_id": coinId,
    "status": status,
    "is_primary": isPrimary,
    "balance": balance,
    "referral_balance": referralBalance,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "key": key,
    "type": type,
    "user": user!.toJson(),
  };
}
