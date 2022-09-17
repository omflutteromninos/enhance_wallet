// To parse this JSON data, do
//
//     final swapCoinHistory = swapCoinHistoryFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/data/models/pocket_wallet/pocket_wallet.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';

SwapCoinHistory swapCoinHistoryFromJson(String str) => SwapCoinHistory.fromJson(json.decode(str));

String swapCoinHistoryToJson(SwapCoinHistory data) => json.encode(data.toJson());

class SwapCoinHistory {
  SwapCoinHistory({
    required this.id,
    this.userId,
    this.fromWalletId,
    this.toWalletId,
    this.fromCoinType,
    this.toCoinType,
    this.requestedAmount,
    this.convertedAmount,
    this.rate,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.fromWalletName,
    this.toWalletName,
    this.requestedAmountString,
    this.convertedAmountString,
    this.fromWallet,
    this.toWallet,
  });

  int id;
  int? userId;
  int? fromWalletId;
  int? toWalletId;
  String? fromCoinType;
  String? toCoinType;
  String? requestedAmount;
  String? convertedAmount;
  double? rate;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? fromWalletName;
  String? toWalletName;
  String? requestedAmountString;
  String? convertedAmountString;
  PocketWallet? fromWallet;
  PocketWallet? toWallet;

  factory SwapCoinHistory.fromJson(Map<String, dynamic> json) => SwapCoinHistory(
    id: json["id"],
    userId: makeInt(json["user_id"]),
    fromWalletId: json["from_wallet_id"],
    toWalletId: json["to_wallet_id"],
    fromCoinType: json["from_coin_type"],
    toCoinType: json["to_coin_type"],
    requestedAmount: json["requested_amount"],
    convertedAmount: json["converted_amount"],
    rate: makeDouble(json["rate"]),
    status: json["status"],
    createdAt: json["updated_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    fromWalletName: json["from_wallet_name"],
    toWalletName: json["to_wallet_name"],
    requestedAmountString: json["requested_amount_string"],
    convertedAmountString: json["converted_amount_string"],
    fromWallet: PocketWallet.fromJson(json["from_wallet"]),
    toWallet: PocketWallet.fromJson(json["to_wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "user_id": userId,
    "from_wallet_id": fromWalletId,
    "to_wallet_id": toWalletId,
    "from_coin_type": fromCoinType,
    "to_coin_type": toCoinType,
    "requested_amount": requestedAmount,
    "converted_amount": convertedAmount,
    "rate": rate,
    "status": status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
    "from_wallet_name": fromWalletName,
    "to_wallet_name": toWalletName,
    "requested_amount_string": requestedAmountString,
    "converted_amount_string": convertedAmountString,
    "from_wallet": fromWallet!.toJson(),
    "to_wallet": toWallet!.toJson(),
  };
}
