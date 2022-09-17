// To parse this JSON data, do
//
//     final swapCoinRate = swapCoinRateFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/data/models/swap_coin/swap_coin_all_wallets.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';

SwapCoinRate swapCoinRateFromJson(String str) => SwapCoinRate.fromJson(json.decode(str));

String swapCoinRateToJson(SwapCoinRate data) => json.encode(data.toJson());

class SwapCoinRate {
  SwapCoinRate({
    this.success,
    this.walletRate,
    this.convertRate,
    this.rate,
    this.amount,
    this.fromWallet,
    this.toWallet,
  });

  bool? success;
  double? walletRate;
  double? convertRate;
  double? rate;
  double? amount;
  Wallet? fromWallet;
  Wallet? toWallet;

  factory SwapCoinRate.fromJson(Map<String, dynamic> json) => SwapCoinRate(
    success: json["success"],
    walletRate: makeDouble(json["wallet_rate"]),
    convertRate: makeDouble(json["convert_rate"]),
    rate: makeDouble(json["rate"]),
    amount: makeDouble(json["amount"]),
    fromWallet: Wallet.fromJson(json["from_wallet"]),
    toWallet: Wallet.fromJson(json["to_wallet"]),
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "wallet_rate": walletRate,
    "convert_rate": convertRate,
    "rate": rate,
    "amount": amount,
    "from_wallet": fromWallet?.toJson(),
    "to_wallet": toWallet?.toJson(),
  };
}

