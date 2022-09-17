// To parse this JSON data, do
//
//     final buyCoinAndPhaseInformation = buyCoinAndPhaseInformationFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/data/models/pocket_wallet/coin.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';

import 'bank.dart';

BuyCoinAndPhaseInformation buyCoinAndPhaseInformationFromJson(String str) =>
    BuyCoinAndPhaseInformation.fromJson(json.decode(str));

String buyCoinAndPhaseInformationToJson(BuyCoinAndPhaseInformation data) =>
    json.encode(data.toJson());

class BuyCoinAndPhaseInformation {
  BuyCoinAndPhaseInformation({
    this.settings,
    this.banks,
    this.coins,
    this.coinPrice,
    this.baseCoinType,
    this.coinName,
    this.btcDlr,
    this.noPhase,
    this.activePhase,
    this.paymentMethods,
  });

  Map<String, String>? settings;
  List<Bank>? banks;
  List<Coin>? coins;
  double? coinPrice;
  String? baseCoinType;
  String? coinName;
  String? btcDlr;
  bool? noPhase;
  ActivePhase? activePhase;
  Map<String, String>? paymentMethods;

  factory BuyCoinAndPhaseInformation.fromJson(Map<String, dynamic> json) =>
      BuyCoinAndPhaseInformation(
        settings: Map.from(json["settings"])
            .map((k, v) => MapEntry<String, String>(k, v ?? "")),
        // settings: Map.from(json["settings"]).map((k, v) => MapEntry<String, String>(k, v == null ? null : v)),
        banks: List<Bank>.from(json["banks"].map((x) => Bank.fromJson(x))),
        coins: List<Coin>.from(json["coins"].map((x) => Coin.fromJson(x))),
        coinPrice: makeDouble(json["coin_price"]),
        baseCoinType: json["base_coin_type"],
        coinName: json["coin_name"],
        btcDlr: json["btc_dlr"],
        noPhase: json["no_phase"],
        activePhase: ActivePhase.fromJson(json["activePhase"]),
        paymentMethods: Map.from(json["payment_methods"])
            .map((k, v) => MapEntry<String, String>(k, v)),
      );

  Map<String, dynamic> toJson() => {
        // "settings": settings == null ? null : Map.from(settings!).map((k, v) => MapEntry<String, dynamic>(k, v)),
        "settings": settings == null
            ? null
            : Map.from(settings!).map(
                (k, v) => MapEntry<String, dynamic>(k, v == null ? null : v)),
        "banks": banks == null
            ? null
            : List<dynamic>.from(banks!.map((x) => x.toJson())),
        "coins": coins == null
            ? null
            : List<dynamic>.from(coins!.map((x) => x.toJson())),
        "coin_price": coinPrice,
        "base_coin_type": baseCoinType,
        "coin_name": coinName,
        "btc_dlr": btcDlr,
        "no_phase": noPhase,
        "activePhase": activePhase!.toJson(),
        "payment_methods": paymentMethods == null
            ? null
            : Map.from(paymentMethods!)
                .map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class ActivePhase {
  ActivePhase({
    this.status,
    this.futurePhase,
    this.pahseInfo,
  });

  bool? status;
  bool? futurePhase;
  PahseInfo? pahseInfo;

  factory ActivePhase.fromJson(Map<String, dynamic> json) => ActivePhase(
        status: json["status"],
        futurePhase:
            json.containsKey('futurePhase') ? json["futurePhase"] : null,
        pahseInfo: json.containsKey('pahse_info')
            ? PahseInfo.fromJson(json["pahse_info"])
            : null,
      );

  Map<String, dynamic> toJson() => {
        "status": status,
        "futurePhase": futurePhase,
        "pahse_info": pahseInfo!.toJson(),
      };
}

class PahseInfo {
  PahseInfo({
    required this.id,
    this.phaseName,
    this.startDate,
    this.endDate,
    this.fees,
    this.rate,
    this.amount,
    this.bonus,
    this.status,
    this.affiliationLevel,
    this.affiliationPercentage,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? phaseName;
  DateTime? startDate;
  DateTime? endDate;
  String? fees;
  String? rate;
  String? amount;
  String? bonus;
  int? status;
  int? affiliationLevel;
  String? affiliationPercentage;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory PahseInfo.fromJson(Map<String, dynamic> json) => PahseInfo(
        id: json["id"],
        phaseName: json["phase_name"],
        startDate: DateTime.parse(json["start_date"]),
        endDate: DateTime.parse(json["end_date"]),
        fees: json["fees"],
        rate: json["rate"],
        amount: json["amount"],
        bonus: json["bonus"],
        status: json["status"],
        affiliationLevel: json["affiliation_level"],
        affiliationPercentage: json["affiliation_percentage"],
        createdAt: json["created_at"] == null
            ? null
            : DateTime.parse(json["created_at"]),
        updatedAt: json["updated_at"] == null
            ? null
            : DateTime.parse(json["updated_at"]),
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "phase_name": phaseName,
        "start_date": startDate,
        "end_date": endDate,
        "fees": fees,
        "rate": rate,
        "amount": amount,
        "bonus": bonus,
        "status": status,
        "affiliation_level": affiliationLevel,
        "affiliation_percentage": affiliationPercentage,
        "created_at": createdAt == null ? null : createdAt,
        "updated_at": updatedAt == null ? null : updatedAt,
      };
}
