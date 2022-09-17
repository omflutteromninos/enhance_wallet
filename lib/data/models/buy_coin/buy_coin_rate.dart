// To parse this JSON data, do
//
//     final buyCoinRate = buyCoinRateFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

BuyCoinRate buyCoinRateFromJson(String str) => BuyCoinRate.fromJson(json.decode(str));

String buyCoinRateToJson(BuyCoinRate data) => json.encode(data.toJson());

class BuyCoinRate {
  BuyCoinRate({
    this.amount,
    this.coinType,
    this.phaseFees,
    this.bonus,
    this.noPhase,
    this.coinPrice,
    this.btcDlr,
  });

  double? amount;
  String? coinType;
  double? phaseFees;
  double? bonus;
  bool? noPhase;
  double? coinPrice;
  double? btcDlr;

  factory BuyCoinRate.fromJson(Map<String, dynamic> json) => BuyCoinRate(
    amount: makeDouble(json["amount"]),
    coinType: json["coin_type"],
    phaseFees: makeDouble(json["phase_fees"]),
    bonus: makeDouble(json["bonus"]),
    noPhase: json["no_phase"],
    coinPrice: makeDouble(json["coin_price"]),
    btcDlr: makeDouble(json["btc_dlr"]),
  );

  Map<String, dynamic> toJson() => {
    "amount": amount,
    "coin_type": coinType,
    "phase_fees": phaseFees,
    "bonus": bonus,
    "no_phase": noPhase,
    "coin_price": coinPrice,
    "btc_dlr": btcDlr,
  };
}


// // To parse this JSON data, do
// //
// //     final buyCoinRate = buyCoinRateFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:cPocket/utils/view_utils/common_utils.dart';
//
// BuyCoinRate buyCoinRateFromJson(String str) => BuyCoinRate.fromJson(json.decode(str));
//
// String buyCoinRateToJson(BuyCoinRate data) => json.encode(data.toJson());
//
// class BuyCoinRate {
//   BuyCoinRate({
//     this.amount,
//     this.coinType,
//     this.phaseFees,
//     this.bonus,
//     this.noPhase,
//     this.coinPrice,
//     this.btcDlr,
//   });
//
//   double? amount;
//   String? coinType;
//   int? phaseFees;
//   int? bonus;
//   bool? noPhase;
//   double? coinPrice;
//   double? btcDlr;
//
//   factory BuyCoinRate.fromJson(Map<String, dynamic> json) => BuyCoinRate(
//     amount: json["amount"],
//     coinType: json["coin_type"],
//     phaseFees: makeInt(json["phase_fees"]),
//     bonus: makeInt(json["bonus"]),
//     noPhase: json["no_phase"],
//     coinPrice: makeDouble(json["coin_price"]),
//     btcDlr: makeDouble(json["btc_dlr"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "amount": amount,
//     "coin_type": coinType,
//     "phase_fees": phaseFees,
//     "bonus": bonus,
//     "no_phase": noPhase,
//     "coin_price": coinPrice,
//     "btc_dlr": btcDlr,
//   };
// }

