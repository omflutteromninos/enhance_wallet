// To parse this JSON data, do
//
//     final transaction = transactionFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

DepositOrWithdraw transactionFromJson(String str) => DepositOrWithdraw.fromJson(json.decode(str));

String transactionToJson(DepositOrWithdraw data) => json.encode(data.toJson());

class DepositOrWithdraw {
  DepositOrWithdraw({
    required this.id,
    this.address,
    this.fees,
    this.senderWalletId,
    this.receiverWalletId,
    this.addressType,
    //this.type,
    this.amount,
    this.btc,
    this.doller,
    this.transactionHash,
    this.status,
    this.confirmations,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? address;
  double? fees;
  int? senderWalletId;
  int? receiverWalletId;
  int? addressType;
  //String? type;
  String? amount;
  String? btc;
  String? doller;
  String? transactionHash;
  int? status;
  int? confirmations;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory DepositOrWithdraw.fromJson(Map<String, dynamic> json) => DepositOrWithdraw(
    id: json["id"],
    address: json["address"],
    fees: makeDouble(json["fees"]),
    senderWalletId: makeInt(json["sender_wallet_id"]),
    receiverWalletId: makeInt(json["receiver_wallet_id"]),
    addressType: makeInt(json["address_type"]),
    //type: json["type"],
    amount: json["amount"],
    btc: json["btc"],
    doller: json["doller"],
    transactionHash: json["transaction_hash"],
    status: makeInt(json["status"]),
    confirmations: makeInt(json["confirmations"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "address": address,
    "fees": fees,
    "sender_wallet_id": senderWalletId,
    "receiver_wallet_id": receiverWalletId,
    "address_type": addressType,
    //"type": type,
    "amount": amount,
    "btc": btc,
    "doller": doller,
    "transaction_hash": transactionHash,
    "status": status,
    "confirmations": confirmations,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };
}





//
//
// // To parse this JSON data, do
// //
// //     final transaction = transactionFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:cPocket/utils/view_utils/common_utils.dart';
//
// Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));
//
// String transactionToJson(Transaction data) => json.encode(data.toJson());
//
// class Transaction {
//   Transaction({
//     required this.id,
//     this.uniqueCode,
//     this.coinId,
//     this.userId,
//     this.name,
//     this.coinType,
//     this.status,
//     this.isPrimary,
//     this.balance,
//     this.referralBalance,
//     this.createdAt,
//     this.updatedAt,
//     this.address,
//     this.fees,
//     this.senderWalletId,
//     this.receiverWalletId,
//     this.addressType,
//     this.type,
//     this.amount,
//     this.btc,
//     this.dollar,
//     this.transactionHash,
//     this.confirmations,
//   });
//
//   int id;
//   dynamic uniqueCode;
//   int? coinId;
//   int? userId;
//   String? name;
//   String? coinType;
//   int? status;
//   int? isPrimary;
//   double? balance;
//   double? referralBalance;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? address;
//   double? fees;
//   int? senderWalletId;
//   int? receiverWalletId;
//   int? addressType;
//   String? type;
//   double? amount;
//   double? btc;
//   double? dollar;
//   String? transactionHash;
//   int? confirmations;
//
//   factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
//     id: json["id"],
//     uniqueCode: json["unique_code"],
//     coinId: json["coin_id"],
//     userId: makeInt(json["user_id"]),
//     name: json["name"],
//     coinType: json["coin_type"],
//     status: makeInt(json["status"]),
//     isPrimary: makeInt(json["is_primary"]),
//     balance: makeDouble(json["balance"]),
//     referralBalance: makeDouble(json["referral_balance"]),
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     address: json["address"],
//     fees: makeDouble(json["fees"]),
//     senderWalletId: makeInt(json["sender_wallet_id"]),
//     receiverWalletId: makeInt(json["receiver_wallet_id"]),
//     addressType: makeInt(json["address_type"]),
//     type: json["type"],
//     amount: makeDouble(json["amount"]),
//     btc: makeDouble(json["btc"]),
//     dollar: makeDouble(json["doller"]),
//     transactionHash: json["transaction_hash"],
//     confirmations: makeInt(json["confirmations"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "unique_code": uniqueCode,
//     "coin_id": coinId,
//     "user_id": userId,
//     "name": name,
//     "coin_type": coinType,
//     "status": status,
//     "is_primary": isPrimary,
//     "balance": balance,
//     "referral_balance": referralBalance,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "address": address,
//     "fees": fees,
//     "sender_wallet_id": senderWalletId,
//     "receiver_wallet_id": receiverWalletId,
//     "address_type": addressType,
//     "type": type,
//     "amount": amount,
//     "btc": btc,
//     "doller": dollar,
//     "transaction_hash": transactionHash,
//     "confirmations": confirmations,
//   };
// }
































//
// // To parse this JSON data, do
// //
// //     final transaction = transactionFromJson(jsonString);
//
// import 'dart:convert';
//
// import 'package:cPocket/utils/view_utils/common_utils.dart';
//
// Transaction transactionFromJson(String str) => Transaction.fromJson(json.decode(str));
//
// String transactionToJson(Transaction data) => json.encode(data.toJson());
//
// class Transaction {
//   Transaction({
//     required this.id,
//     this.uniqueCode,
//     this.coinId,
//     this.userId,
//     this.name,
//     this.coinType,
//     this.status,
//     this.isPrimary,
//     this.balance,
//     this.referralBalance,
//     this.createdAt,
//     this.updatedAt,
//     this.address,
//     this.fees,
//     this.senderWalletId,
//     this.receiverWalletId,
//     this.addressType,
//     this.type,
//     this.amount,
//     this.btc,
//     this.dollar,
//     this.transactionId,
//     this.confirmations,
//   });
//
//   int id;
//   dynamic uniqueCode;
//   int? coinId;
//   int? userId;
//   String? name;
//   String? coinType;
//   int? status;
//   int? isPrimary;
//   double? balance;
//   double? referralBalance;
//   DateTime? createdAt;
//   DateTime? updatedAt;
//   String? address;
//   double? fees;
//   int? senderWalletId;
//   int? receiverWalletId;
//   int? addressType;
//   String? type;
//   double? amount;
//   double? btc;
//   double? dollar;
//   String? transactionId;
//   int? confirmations;
//
//   factory Transaction.fromJson(Map<String, dynamic> json) => Transaction(
//     id: json["id"],
//     uniqueCode: json["unique_code"],
//     coinId: json["coin_id"],
//     userId: makeInt(json["user_id"]),
//     name: json["name"],
//     coinType: json["coin_type"],
//     status: makeInt(json["status"]),
//     isPrimary: makeInt(json["is_primary"]),
//     balance: makeDouble(json["balance"]),
//     referralBalance: makeDouble(json["referral_balance"]),
//     createdAt: DateTime.parse(json["created_at"]),
//     updatedAt: DateTime.parse(json["updated_at"]),
//     address: json["address"],
//     fees: makeDouble(json["fees"]),
//     senderWalletId: makeInt(json["sender_wallet_id"]),
//     receiverWalletId: makeInt(json["receiver_wallet_id"]),
//     addressType: makeInt(json["address_type"]),
//     type: json["type"],
//     amount: makeDouble(json["amount"]),
//     btc: makeDouble(json["btc"]),
//     dollar: makeDouble(json["doller"]),
//     transactionId: json["transaction_id"],
//     confirmations: makeInt(json["confirmations"]),
//   );
//
//   Map<String, dynamic> toJson() => {
//     "id": id,
//     "unique_code": uniqueCode,
//     "coin_id": coinId,
//     "user_id": userId,
//     "name": name,
//     "coin_type": coinType,
//     "status": status,
//     "is_primary": isPrimary,
//     "balance": balance,
//     "referral_balance": referralBalance,
//     "created_at": createdAt,
//     "updated_at": updatedAt,
//     "address": address,
//     "fees": fees,
//     "sender_wallet_id": senderWalletId,
//     "receiver_wallet_id": receiverWalletId,
//     "address_type": addressType,
//     "type": type,
//     "amount": amount,
//     "btc": btc,
//     "doller": dollar,
//     "transaction_id": transactionId,
//     "confirmations": confirmations,
//   };
// }

