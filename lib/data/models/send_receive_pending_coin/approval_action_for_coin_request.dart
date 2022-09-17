// To parse this JSON data, do
//
//     final approvalActionForCoinRequest = approvalActionForCoinRequestFromJson(jsonString);

import 'dart:convert';

ApprovalActionForCoinRequest approvalActionForCoinRequestFromJson(String str) => ApprovalActionForCoinRequest.fromJson(json.decode(str));

String approvalActionForCoinRequestToJson(ApprovalActionForCoinRequest data) => json.encode(data.toJson());

class ApprovalActionForCoinRequest {
  ApprovalActionForCoinRequest({
    this.success,
    this.message,
  });

  bool? success;
  String? message;

  factory ApprovalActionForCoinRequest.fromJson(Map<String, dynamic> json) => ApprovalActionForCoinRequest(
    success: json["success"],
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "message": message,
  };
}
