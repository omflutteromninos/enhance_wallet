// To parse this JSON data, do
//
//     final userClubInfos = userClubInfosFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

UserClubInfo userClubInfosFromJson(String str) =>
    UserClubInfo.fromJson(json.decode(str));

String userClubInfosToJson(UserClubInfo data) => json.encode(data.toJson());

class UserClubInfo {
  UserClubInfo({
    this.clubId,
    this.planId,
    this.blockedCoin,
    this.planName,
    this.planImage,
  });

  int? clubId;
  int? planId;
  double? blockedCoin;
  String? planName;
  String? planImage;

  factory UserClubInfo.fromJson(Map<String, dynamic> json) => UserClubInfo(
        clubId: makeInt(json["club_id"]),
        planId: makeInt(json["plan_id"]),
        blockedCoin: makeDouble(json["blocked_coin"]),
        planName: json["plan_name"],
        planImage: json["plan_image"],
      );

  Map<String, dynamic> toJson() => {
        "club_id": clubId,
        "plan_id": planId,
        "blocked_coin": blockedCoin,
        "plan_name": planName,
        "plan_image": planImage,
      };
}
