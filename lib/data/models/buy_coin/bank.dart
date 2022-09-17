// To parse this JSON data, do
//
//     final bank = bankFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

Bank bankFromJson(String str) => Bank.fromJson(json.decode(str));

String bankToJson(Bank data) => json.encode(data.toJson());

class Bank {
  Bank({
    required this.id,
    this.accountHolderName,
    this.accountHolderAddress,
    this.bankName,
    this.bankAddress,
    this.country,
    this.swiftCode,
    this.iban,
    this.note,
    this.status,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? accountHolderName;
  String? accountHolderAddress;
  String? bankName;
  String? bankAddress;
  String? country;
  String? swiftCode;
  String? iban;
  String? note;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory Bank.fromJson(Map<String, dynamic> json) => Bank(
    id: json["id"],
    accountHolderName: json["account_holder_name"],
    accountHolderAddress: json["account_holder_address"],
    bankName: json["bank_name"],
    bankAddress: json["bank_address"],
    country: json["country"],
    swiftCode: json["swift_code"],
    iban: json["iban"],
    note: json["note"],
    status: makeInt(json["status"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "account_holder_name": accountHolderName,
    "account_holder_address": accountHolderAddress,
    "bank_name": bankName,
    "bank_address": bankAddress,
    "country": country,
    "swift_code": swiftCode,
    "iban": iban,
    "note": note,
    "status": status,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}
