// To parse this JSON data, do
//
//     final idVerification = idVerificationFromJson(jsonString);

import 'dart:convert';

IdVerification idVerificationFromJson(String str) => IdVerification.fromJson(json.decode(str));

String idVerificationToJson(IdVerification data) => json.encode(data.toJson());

class IdVerification {
  IdVerification({
    this.nid,
    this.passport,
    this.drivingLicense,
  });

  IdDetails? nid;
  IdDetails? passport;
  IdDetails? drivingLicense;

  factory IdVerification.fromJson(Map<String, dynamic> json) => IdVerification(
    nid: IdDetails.fromJson(json["nid"]),
    passport: IdDetails.fromJson(json["passport"]),
    drivingLicense: IdDetails.fromJson(json["driving_license"]),
  );

  Map<String, dynamic> toJson() => {
    "nid": nid == null ? null : nid!.toJson(),
    "passport": passport == null ? null : passport!.toJson(),
    "driving_license": drivingLicense == null ? null : drivingLicense!.toJson(),
  };
}

class IdDetails {
  IdDetails({
    this.common,
    this.status,
    this.front,
    this.back,
  });

  String? common;
  String? status;
  String? front;
  String? back;

  factory IdDetails.fromJson(Map<String, dynamic> json) => IdDetails(
    common: json["common"],
    status: json["status"],
    front: json["front"],
    back: json["back"],
  );

  Map<String, dynamic> toJson() => {
    "common": common,
    "status": status,
    "front": front,
    "back": back,
  };
}
