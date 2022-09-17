// To parse this JSON data, do
//
//     final buyCoinHistory = buyCoinHistoryFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

BuyCoinHistory buyCoinHistoryFromJson(String str) => BuyCoinHistory.fromJson(json.decode(str));

String buyCoinHistoryToJson(BuyCoinHistory data) => json.encode(data.toJson());

class BuyCoinHistory {
  BuyCoinHistory({
    required this.id,
    this.address,
    this.type,
    this.userId,
    this.coin,
    this.btc,
    this.doller,
    this.transactionId,
    this.status,
    this.adminConfirmation,
    this.confirmations,
    this.bankSleep,
    this.bankId,
    this.coinType,
    this.requestedAmount,
    this.referralBonus,
    this.bonus,
    this.fees,
    this.referralLevel,
    this.phaseId,
    this.stripeToken,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? address;
  String? type;
  int? userId;
  String? coin;
  String? btc;
  String? doller;
  //dynamic transactionId;
  String? transactionId;
  String? status;
  int? adminConfirmation;
  int? confirmations;
  String? bankSleep;
  int? bankId;
  String? coinType;
  String? requestedAmount;
  String? referralBonus;
  String? bonus;
  String? fees;
  int? referralLevel;
  int? phaseId;
  dynamic stripeToken;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory BuyCoinHistory.fromJson(Map<String, dynamic> json) => BuyCoinHistory(
    id: json["id"],
    address: json["address"],
    type: json["type"],
    userId: makeInt(json["user_id"]),
    coin: json["coin"],
    btc: json["btc"],
    doller: json["doller"],
    transactionId: json["transaction_id"],
    status: json["status"],
    adminConfirmation: json["admin_confirmation"],
    confirmations: json["confirmations"],
    bankSleep: json["bank_sleep"],
    bankId: json["bank_id"],
    coinType: json["coin_type"],
    requestedAmount: json["requested_amount"],
    referralBonus: json["referral_bonus"],
    bonus: json["bonus"],
    fees: json["fees"],
    referralLevel: json["referral_level"],
    phaseId: json["phase_id"],
    stripeToken: json["stripe_token"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "type": type,
    "user_id": userId,
    "coin": coin,
    "btc": btc,
    "doller": doller,
    "transaction_id": transactionId,
    "status": status,
    "admin_confirmation": adminConfirmation,
    "confirmations": confirmations,
    "bank_sleep": bankSleep,
    "bank_id": bankId,
    "coin_type": coinType,
    "requested_amount": requestedAmount,
    "referral_bonus": referralBonus,
    "bonus": bonus,
    "fees": fees,
    "referral_level": referralLevel,
    "phase_id": phaseId,
    "stripe_token": stripeToken,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
