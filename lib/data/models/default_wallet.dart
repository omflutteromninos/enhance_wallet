// To parse this JSON data, do
//
//     final defaultWallet = defaultWalletFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

DefaultWallet defaultWalletFromJson(String str) => DefaultWallet.fromJson(json.decode(str));

String defaultWalletToJson(DefaultWallet data) => json.encode(data.toJson());

class DefaultWallet {
  DefaultWallet({
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
  });

  int id;
  int? userId;
  String? name;
  String? coinType;
  int? coinId;
  int? status;
  int? isPrimary;
  double? balance;
  String? referralBalance;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? key;
  int? type;

  factory DefaultWallet.fromJson(Map<String, dynamic> json) => DefaultWallet(
    id: json["id"],
    userId: makeInt(json["user_id"]),
    name: json["name"],
    coinType: json["coin_type"],
    coinId: json["coin_id"],
    status: json["status"],
    isPrimary: json["is_primary"],
    balance: makeDouble(json["balance"]),
    referralBalance: json["referral_balance"],
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    key: json["key"],
    type: json["type"],
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
    // "created_at": formatDate(createdAt,format: dateTimeFormatDdMMMMYyyyHhMm),
    // "updated_at": formatDate(updatedAt,format: dateTimeFormatDdMMMMYyyyHhMm),
    "key": key,
    "type": type,
  };
}
