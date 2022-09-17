// To parse this JSON data, do
//
//     final coin = coinFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

Coin coinFromJson(String str) => Coin.fromJson(json.decode(str));

String coinToJson(Coin data) => json.encode(data.toJson());

class Coin {
  Coin({
    required this.id,
    this.name,
    this.type,
    this.maximumWithdrawal,
    this.minimumWithdrawal,
    this.withdrawalFees,
    // this.status,
    // this.isWithdrawal,
    // this.isDeposit,
    // this.isBuy,
    // this.isSell,
    // this.minimumSellAmount,
    // this.minimumBuyAmount,
    // this.sign,
    // this.tradeStatus,
    // this.isVirtualAmount,
    // this.isTransferable,
    // this.isWallet,
    // this.isPrimary,
    // this.isCurrency,
    // this.isBase,
    // this.coinIcon,
    // this.createdAt,
    // this.updatedAt,
  });

  int id;
  String? name;
  String? type;
  double? maximumWithdrawal;
  double? minimumWithdrawal;
  double? withdrawalFees;
  // int? status;
  // int? isWithdrawal;
  // int? isDeposit;
  // int? isBuy;
  // int? isSell;
  // double? minimumSellAmount;
  // double? minimumBuyAmount;
  // dynamic sign;
  // int? tradeStatus;
  // int? isVirtualAmount;
  // int? isTransferable;
  // int? isWallet;
  // dynamic isPrimary;
  // int? isCurrency;
  // int? isBase;
  // dynamic coinIcon;
  // DateTime? createdAt;
  // DateTime? updatedAt;

  factory Coin.fromJson(Map<String, dynamic> json) => Coin(
    id: json["id"],
    name: json["name"],
    type: json["type"],
    maximumWithdrawal: makeDouble(json["maximum_withdrawal"]),
    minimumWithdrawal: makeDouble(json["minimum_withdrawal"]),
    withdrawalFees: makeDouble(json["withdrawal_fees"]),
    // status: json["status"],
    // isWithdrawal: json["is_withdrawal"],
    // isDeposit: json["is_deposit"],
    // isBuy: json["is_buy"],
    // isSell: json["is_sell"],
    // minimumSellAmount: makeDouble(json["minimum_sell_amount"]),
    // minimumBuyAmount: makeDouble(json["minimum_buy_amount"]),
    // sign: json["sign"],
    // tradeStatus: json["trade_status"],
    // isVirtualAmount: json["is_virtual_amount"],
    // isTransferable: json["is_transferable"],
    // isWallet: json["is_wallet"],
    // isPrimary: json["is_primary"],
    // isCurrency: json["is_currency"],
    // isBase: json["is_base"],
    // coinIcon: json["coin_icon"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "type": type,
    "maximum_withdrawal": maximumWithdrawal,
    "minimum_withdrawal": minimumWithdrawal,
    "withdrawal_fees": withdrawalFees,
    // "status": status,
    // "is_withdrawal": isWithdrawal,
    // "is_deposit": isDeposit,
    // "is_buy": isBuy,
    // "is_sell": isSell,
    // "minimum_sell_amount": minimumSellAmount,
    // "minimum_buy_amount": minimumBuyAmount,
    // "sign": sign,
    // "trade_status": tradeStatus,
    // "is_virtual_amount": isVirtualAmount,
    // "is_transferable": isTransferable,
    // "is_wallet": isWallet,
    // "is_primary": isPrimary,
    // "is_currency": isCurrency,
    // "is_base": isBase,
    // "coin_icon": coinIcon,
    // "created_at": createdAt,
    // "updated_at": updatedAt,
  };
}

