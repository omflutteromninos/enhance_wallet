// To parse this JSON data, do
//
//     final generalSettings = generalSettingsFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/data/models/pocket_wallet/coin.dart';
import 'package:cPocket/utils/view_utils/common_utils.dart';

GeneralSettings generalSettingsFromJson(String str) => GeneralSettings.fromJson(json.decode(str));

String generalSettingsToJson(GeneralSettings data) => json.encode(data.toJson());

class GeneralSettings {
  GeneralSettings({
    this.languages,
    this.settings,
    this.coins,
    this.smallPlanDescription,
  });

  Map<String, String>? languages;
  Settings? settings;
  List<Coin>? coins;
  SmallPlanDescription? smallPlanDescription;

  factory GeneralSettings.fromJson(Map<String, dynamic> json) => GeneralSettings(
    languages: Map.from(json["languages"]).map((k, v) => MapEntry<String, String>(k, v)),
    settings: Settings.fromJson(json["settings"]),
    coins: List<Coin>.from(json["coins"].map((x) => Coin.fromJson(x))),
    smallPlanDescription: SmallPlanDescription.fromJson(json["small_plan_description"]),
  );

  Map<String, dynamic> toJson() => {
    "languages": languages == null ? null : Map.from(languages!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "settings": settings == null ? null : settings!.toJson(),
    "coins": coins == null ? null : List<dynamic>.from(coins!.map((x) => x.toJson())),
    "small_plan_description": smallPlanDescription == null ? null :  smallPlanDescription!.toJson(),
  };
}

class Settings {
  Settings({
    this.coinPrice,
    this.coinName,
    this.minimumWithdrawalAmount,
    this.maximumWithdrawalAmount,
  });

  double? coinPrice;
  String? coinName;
  double? minimumWithdrawalAmount;
  double? maximumWithdrawalAmount;

  factory Settings.fromJson(Map<String, dynamic> json) => Settings(
    coinPrice: makeDouble(json["coin_price"]),
    coinName: json["coin_name"],
    minimumWithdrawalAmount: makeDouble(json["minimum_withdrawal_amount"]),
    maximumWithdrawalAmount: makeDouble(json["maximum_withdrawal_amount"]),
  );

  Map<String, dynamic> toJson() => {
    "coin_price": coinPrice,
    "coin_name": coinName,
    "minimum_withdrawal_amount": minimumWithdrawalAmount,
    "maximum_withdrawal_amount": maximumWithdrawalAmount,
  };
}

class SmallPlanDescription {
  SmallPlanDescription({
    required this.id,
    this.planName,
    this.duration,
    this.amount,
    // this.image,
    this.bonusType,
    this.bonus,
    this.bonusCoinType,
    this.status,
    // this.description,
    // this.createdAt,
    // this.updatedAt,
  });

  int id;
  String? planName;
  int? duration;
  double? amount;
  // dynamic image;
  int? bonusType;
  double? bonus;
  String? bonusCoinType;
  int? status;
  // dynamic description;
  // DateTime createdAt;
  // DateTime updatedAt;

  factory SmallPlanDescription.fromJson(Map<String, dynamic> json) => SmallPlanDescription(
    id: json["id"],
    planName: json["plan_name"],
    duration: makeInt(json["duration"]),
    amount: makeDouble(json["amount"]),
    // image: json["image"],
    bonusType: json["bonus_type"],
    bonus: makeDouble(json["bonus"]),
    bonusCoinType: json["bonus_coin_type"],
    status: makeInt(json["status"]),
    // description: json["description"],
    // createdAt: DateTime.parse(json["created_at"]),
    // updatedAt: DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "plan_name": planName,
    "duration": duration,
    "amount": amount,
    // "image": image,
    "bonus_type": bonusType,
    "bonus": bonus,
    "bonus_coin_type": bonusCoinType,
    "status": status,
    // "description": description,
    // "created_at": createdAt.toIso8601String(),
    // "updated_at": updatedAt.toIso8601String(),
  };
}


// class Coin {
//   Coin({
//     required this.id,
//     this.name,
//     this.type,
//     this.minimumWithdrawal,
//     this.maximumWithdrawal,
//     this.withdrawalFees,
//   });
//
//   int id;
//   String? name;
//   String? type;
//   double? minimumWithdrawal;
//   double? maximumWithdrawal;
//   double? withdrawalFees;
//
//   factory Coin.fromJson(Map<String, dynamic> json) => Coin(
//     id: json["id"],
//     name: json["name"],
//     type: json["type"],
//     minimumWithdrawal: makeDouble(json["minimum_withdrawal"]),
//     maximumWithdrawal: makeDouble(json["maximum_withdrawal"]),
//     withdrawalFees: makeDouble(json["withdrawal_fees"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "name": name,
//     "type": type,
//     "minimum_withdrawal": minimumWithdrawal,
//     "maximum_withdrawal": maximumWithdrawal,
//     "withdrawal_fees": withdrawalFees,
//   };
// }
