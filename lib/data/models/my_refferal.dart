// To parse this JSON data, do
//
//     final myReferral = myReferralFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

MyReferral myReferralFromJson(String str) => MyReferral.fromJson(json.decode(str));

String myReferralToJson(MyReferral data) => json.encode(data.toJson());

class MyReferral {
  MyReferral({
    this.referral,
    this.referralLevel,
  });

  List<Reference>? referral;
  Map<String, int>? referralLevel;

  factory MyReferral.fromJson(Map<String, dynamic> json) => MyReferral(
        referral: List<Reference>.from(json["referral"].map((x) => Reference.fromJson(x))),
        referralLevel: Map.from(json["referralLevel"]).map((k, v) => MapEntry<String, int>(k, makeInt(v))),
      );

  Map<String, dynamic> toJson() => {
        "referral": referral == null ? null : List<dynamic>.from(referral!.map((x) => x.toJson())),
        "referralLevel":
            referralLevel == null ? null : Map.from(referralLevel!).map((k, v) => MapEntry<String, dynamic>(k, v)),
      };
}

class Reference {
  Reference({
    required this.id,
    this.fullName,
    this.email,
    this.joiningDate,
    this.level,
  });

  int id;
  String? fullName;
  String? email;
  DateTime? joiningDate;
  String? level;

  factory Reference.fromJson(Map<String, dynamic> json) => Reference(
        id: json["id"],
        fullName: json["full_name"],
        email: json["email"],
        joiningDate: DateTime.parse(json["joining_date"]),
        level: json["level"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "full_name": fullName,
        "email": email,
        "joining_date": joiningDate,
        "level": level,
      };
}

///final earning = earningFromJson(jsonString);

Earning earningFromJson(String str) => Earning.fromJson(json.decode(str));

String earningToJson(Earning data) => json.encode(data.toJson());

class Earning {
  Earning({
    this.yearMonth,
    this.totalAmount,
  });

  String? yearMonth;
  double? totalAmount;

  factory Earning.fromJson(Map<String, dynamic> json) => Earning(
        yearMonth: json["year_month"],
        totalAmount: makeDouble(json["total_amount"]),
      );

  Map<String, dynamic> toJson() => {
        "year_month": yearMonth,
        "total_amount": totalAmount,
      };
}
