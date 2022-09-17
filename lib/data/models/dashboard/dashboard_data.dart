

// To parse this JSON data, do
//
//     final dashBoardData = dashBoardDataFromJson(jsonString);

import 'dart:convert';
import 'dart:ffi';

import 'package:cPocket/utils/view_utils/common_utils.dart';

DashBoardData dashBoardDataFromJson(String str) => DashBoardData.fromJson(json.decode(str));

String dashBoardDataToJson(DashBoardData data) => json.encode(data.toJson());

class DashBoardData {
  DashBoardData({
    this.balance,
    this.totalBuyCoin,
    this.blockedCoin,
    this.completedWithdraw,
    this.pendingWithdraw,
    this.lastSixMonth,
    this.monthlyDeposit,
    this.monthlyWithdrawal,
    this.monthlyBuyCoin,
  });

  double? balance;
  double? totalBuyCoin;
  double? blockedCoin;
  double? completedWithdraw;
  double? pendingWithdraw;
  List<String>? lastSixMonth;
  List<double>? monthlyDeposit;
  List<double>? monthlyWithdrawal;
  List<double>? monthlyBuyCoin;

  factory DashBoardData.fromJson(Map<String, dynamic> json) => DashBoardData(
    balance: makeDouble(json["balance"]),
    totalBuyCoin: makeDouble(json["total_buy_coin"]),
    blockedCoin: makeDouble(json["blocked_coin"]),
    completedWithdraw: makeDouble(json["completed_withdraw"]),
    pendingWithdraw: makeDouble(json["pending_withdraw"]),
    lastSixMonth: List<String>.from(json["last_six_month"].map((x) => x)),
    monthlyDeposit: List<double>.from(json["monthly_deposit"].map((x) => makeDouble(x))),
    monthlyWithdrawal: List<double>.from(json["monthly_withdrawal"].map((x) => makeDouble(x))),
    monthlyBuyCoin: List<double>.from(json["monthly_buy_coin"].map((x) => makeDouble(x))),
  );

  Map<String, dynamic> toJson() => {
    "balance": balance,
    "total_buy_coin": totalBuyCoin,
    "blocked_coin": blockedCoin,
    "completed_withdraw": completedWithdraw,
    "pending_withdraw": pendingWithdraw,
    "last_six_month": lastSixMonth == null ? [] : List<dynamic>.from(lastSixMonth!.map((x) => x)),
    "monthly_deposit": monthlyDeposit == null ? [] : List<dynamic>.from(monthlyDeposit!.map((x) => x)),
    "monthly_withdrawal": monthlyWithdrawal == null ? [] : List<dynamic>.from(monthlyWithdrawal!.map((x) => x)),
    "monthly_buy_coin": monthlyBuyCoin == null? [] : List<dynamic>.from(monthlyBuyCoin!.map((x) => x)),
  };
}
















// To parse this JSON data, do
//
//     final dashBoardData = dashBoardDataFromJson(jsonString);

// import 'dart:convert';
//
// import 'package:cPocket/utils/view_utils/common_utils.dart';
//
// DashBoardData dashBoardDataFromJson(String str) => DashBoardData.fromJson(json.decode(str));
//
// String dashBoardDataToJson(DashBoardData data) => json.encode(data.toJson());
//
// class DashBoardData {
//   DashBoardData({
//     this.balance,
//     this.totalBuyCoin,
//     this.blockedCoin,
//     this.completedWithdraw,
//     this.pendingWithdraw,
//     this.monthlyDeposit,
//     this.monthlyWithdrawal,
//     this.monthlyBuyCoin,
//   });
//
//   String? balance;
//   String? totalBuyCoin;
//   String? blockedCoin;
//   String? completedWithdraw;
//   double? pendingWithdraw;
//   List<double>? monthlyDeposit;
//   List<double>? monthlyWithdrawal;
//   List<double>? monthlyBuyCoin;
//
//   factory DashBoardData.fromJson(Map<String, dynamic> json) => DashBoardData(
//     balance: json["balance"],
//     totalBuyCoin: json["total_buy_coin"],
//     blockedCoin: json["blocked_coin"],
//     completedWithdraw: json["completed_withdraw"],
//     pendingWithdraw: makeDouble(json["pending_withdraw"]),
//     monthlyDeposit: List<double>.from(json["monthly_deposit"].map((x) => makeDouble(x))),
//     monthlyWithdrawal: List<double>.from(json["monthly_withdrawal"].map((x) => makeDouble(x))),
//     monthlyBuyCoin: List<double>.from(json["monthly_buy_coin"].map((x) => makeDouble(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "balance": balance,
//     "total_buy_coin": totalBuyCoin,
//     "blocked_coin": blockedCoin,
//     "completed_withdraw": completedWithdraw,
//     "pending_withdraw": pendingWithdraw,
//     "monthly_deposit": monthlyDeposit == null ? [] : List<dynamic>.from(monthlyDeposit!.map((x) => x)),
//     "monthly_withdrawal": monthlyWithdrawal == null ? [] : List<dynamic>.from(monthlyWithdrawal!.map((x) => x)),
//     "monthly_buy_coin": monthlyBuyCoin == null? [] : List<dynamic>.from(monthlyBuyCoin!.map((x) => x)),
//   };
// }



















// // To parse this JSON data, do
// //
// //     final dashBoardData = dashBoardDataFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:cPocket/utils/view_utils/common_utils.dart';
//
// DashBoardData dashBoardDataFromJson(String str) => DashBoardData.fromJson(json.decode(str));
//
// String dashBoardDataToJson(DashBoardData data) => json.encode(data.toJson());
//
// class DashBoardData {
//   DashBoardData({
//     this.balance,
//     this.tradeSuccessStatus,
//     this.lastSixMonth,
//     this.sixBuys,
//     this.sixSells,
//     this.completedWithdraw,
//     this.pendingWithdraw,
//     this.successWithdrawalStatus,
//     this.monthlyDeposit,
//     this.monthlyWithdrawal,
//     this.monthlyTrade,
//   });
//
//   Balance? balance;
//   double? tradeSuccessStatus;
//   List<String>? lastSixMonth;
//   List<double>? sixBuys;
//   List<double>? sixSells;
//   double? completedWithdraw;
//   double? pendingWithdraw;
//   double? successWithdrawalStatus;
//   List<double>? monthlyDeposit;
//   List<double>? monthlyWithdrawal;
//   List<double>? monthlyTrade;
//
//   factory DashBoardData.fromJson(Map<String, dynamic> json) => DashBoardData(
//     balance: Balance.fromJson(json["balance"]),
//     tradeSuccessStatus: makeDouble(json["trade_success_status"]),
//     lastSixMonth: List<String>.from(json["last_six_month"].map((x) => x)),
//     sixBuys: List<double>.from(json["six_buys"].map((x) => makeDouble(x))),
//     sixSells: List<double>.from(json["six_sells"].map((x) => makeDouble(x))),
//     completedWithdraw: makeDouble(["completed_withdraw"]),
//     pendingWithdraw: makeDouble(json["pending_withdraw"]),
//     successWithdrawalStatus: makeDouble(json["success_withdrawal_status"]),
//     monthlyDeposit: List<double>.from(json["monthly_deposit"].map((x) => makeDouble(x))),
//     monthlyWithdrawal: List<double>.from(json["monthly_withdrawal"].map((x) => makeDouble(x))),
//     monthlyTrade: List<double>.from(json["monthly_trade"].map((x) => makeDouble(x))),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "balance": balance ==null ? null : balance!.toJson(),
//     "trade_success_status": tradeSuccessStatus,
//     "last_six_month": lastSixMonth == null ? [] : List<dynamic>.from(lastSixMonth!.map((x) => x)),
//     "six_buys": sixBuys == null ? [] : List<dynamic>.from(sixBuys!.map((x) => x)),
//     "six_sells": sixSells == null ? [] : List<dynamic>.from(sixSells!.map((x) => x)),
//     "completed_withdraw": completedWithdraw,
//     "pending_withdraw": pendingWithdraw,
//     "success_withdrawal_status": successWithdrawalStatus,
//     "monthly_deposit": monthlyDeposit == null ? [] : List<dynamic>.from(monthlyDeposit!.map((x) => x)),
//     "monthly_withdrawal": monthlyWithdrawal == null ? [] : List<dynamic>.from(monthlyWithdrawal!.map((x) => x)),
//     "monthly_trade": monthlyTrade == null ? [] : List<dynamic>.from(monthlyTrade!.map((x) => x)),
//   };
// }
//
// class Balance {
//   Balance({
//     this.availableCoin,
//     this.availableUsed,
//     this.btc,
//     this.usdt,
//     this.eth,
//     this.ltc,
//     this.doge,
//     this.bch,
//     this.dash,
//     this.balanceDefault,
//     this.ltct,
//     this.pendingWithdrawalCoin,
//     this.pendingWithdrawalUsd,
//   });
//
//   double? availableCoin;
//   double? availableUsed;
//   double? btc;
//   double? usdt;
//   double? eth;
//   double? ltc;
//   double? doge;
//   double? bch;
//   double? dash;
//   double? balanceDefault;
//   double? ltct;
//   double? pendingWithdrawalCoin;
//   double? pendingWithdrawalUsd;
//
//   factory Balance.fromJson(Map<String, dynamic> json) => Balance(
//     availableCoin: makeDouble(json["available_coin"]),
//     availableUsed: makeDouble(json["available_used"]),
//     btc: makeDouble(json["BTC"]),
//     usdt: makeDouble(json["USDT"]),
//     eth: makeDouble(json["ETH"]),
//     ltc: makeDouble(json["LTC"]),
//     doge: makeDouble(json["DOGE"]),
//     bch: makeDouble(json["BCH"]),
//     dash: makeDouble(json["DASH"]),
//     balanceDefault: makeDouble(json["DEFAULT"]),
//     ltct: makeDouble(json["LTCT"]),
//     pendingWithdrawalCoin: makeDouble(json["pending_withdrawal_coin"]),
//     pendingWithdrawalUsd: makeDouble(json["pending_withdrawal_usd"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "available_coin": availableCoin,
//     "available_used": availableUsed,
//     "BTC": btc,
//     "USDT": usdt,
//     "ETH": eth,
//     "LTC": ltc,
//     "DOGE": doge,
//     "BCH": bch,
//     "DASH": dash,
//     "DEFAULT": balanceDefault,
//     "LTCT": ltct,
//     "pending_withdrawal_coin": pendingWithdrawalCoin,
//     "pending_withdrawal_usd": pendingWithdrawalUsd,
//   };
// }
//
