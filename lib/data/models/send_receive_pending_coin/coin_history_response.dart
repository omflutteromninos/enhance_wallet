// To parse this JSON data, do
//
//     final sendCoinHistory = sendCoinHistoryFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

CoinHistoryResponse sendCoinHistoryFromJson(String str) =>
    CoinHistoryResponse.fromJson(json.decode(str));

String sendCoinHistoryToJson(CoinHistoryResponse data) =>
    json.encode(data.toJson());

class CoinHistoryResponse {
  CoinHistoryResponse({
    this.coinHistory,
    this.coinName,
  });

  List<CoinHistory>? coinHistory;
  String? coinName;

  factory CoinHistoryResponse.fromJson(Map<String, dynamic> json) =>
      CoinHistoryResponse(
        coinHistory: List<CoinHistory>.from(json[checkJsonKey(json)].map((x) => CoinHistory.fromJson(x))),
        coinName: json["coin_name"],
      );

  Map<String, dynamic> toJson() => {
        "coin_history": coinHistory == null ? null : List<dynamic>.from(coinHistory!.map((x) => x.toJson())),
        "coin_name": coinName,
      };
}

checkJsonKey(Map<String, dynamic> json){
  if (json.containsKey("coin_history")) {
    return "coin_history";
  } else if(json.containsKey("receive_coin_list")){
    return "receive_coin_list";
  } else if(json.containsKey("pending_history")){
    return "pending_history";
  }
}

class CoinHistory {
  CoinHistory({
    required this.id,
    this.amount,
    this.senderUserId,
    this.receiverUserId,
    this.senderWalletId,
    this.receiverWalletId,
    this.status,
    this.createdAt,
    this.updatedAt,
    this.senderEmail,
    this.receiverEmail,
  });

  int id;
  double? amount;
  int? senderUserId;
  int? receiverUserId;
  int? senderWalletId;
  int? receiverWalletId;
  int? status;
  DateTime? createdAt;
  DateTime? updatedAt;
  String? senderEmail;
  String? receiverEmail;

  factory CoinHistory.fromJson(Map<String, dynamic> json) => CoinHistory(
    id: json["id"],
    amount: makeDouble(json["amount"]),
    senderUserId: makeInt(json["sender_user_id"]),
    receiverUserId: makeInt(json["receiver_user_id"]),
    senderWalletId: makeInt(json["sender_wallet_id"]),
    receiverWalletId: makeInt(json["receiver_wallet_id"]),
    status: makeInt(json["status"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
    senderEmail: json["sender_email"],
    receiverEmail: json["receiver_email"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "amount": amount,
        "sender_user_id": senderUserId,
        "receiver_user_id": receiverUserId,
        "sender_wallet_id": senderWalletId,
        "receiver_wallet_id": receiverWalletId,
        "status": status,
        "created_at": createdAt,
        "updated_at": updatedAt,
        "sender_email": senderEmail,
        "receiver_email": receiverEmail,
      };
}
