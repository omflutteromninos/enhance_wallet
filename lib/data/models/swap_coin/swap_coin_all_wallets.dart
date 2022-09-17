// To parse this JSON data, do
//
//     final swapCoinAllWallets = swapCoinAllWalletsFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

Wallet walletFromJson(String str) => Wallet.fromJson(json.decode(str));

String walletToJson(Wallet data) => json.encode(data.toJson());

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
    // "created_at": createdAt,
    // "updated_at": updatedAt,
    "created_at": createdAt == null ? null :  formatDate(createdAt,format: dateTimeFormatDdMMMMYyyyHhMm),
    "updated_at": updatedAt == null ? null :  formatDate(updatedAt,format: dateTimeFormatDdMMMMYyyyHhMm),
    "key": key,
    "type": type,
  };
}
