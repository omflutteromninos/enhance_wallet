// To parse this JSON data, do
//
//     final submitNidPhotoResponse = submitNidPhotoResponseFromJson(jsonString);

import 'dart:convert';

SubmitNidPhotoResponse submitNidPhotoResponseFromJson(String str) => SubmitNidPhotoResponse.fromJson(json.decode(str));

String submitNidPhotoResponseToJson(SubmitNidPhotoResponse data) => json.encode(data.toJson());

class SubmitNidPhotoResponse {
  SubmitNidPhotoResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory SubmitNidPhotoResponse.fromJson(Map<String, dynamic> json) => SubmitNidPhotoResponse(
    success: json["success"],
    data: Data.fromJson(json["data"]),
    message: json["message"],
  );

  Map<String, dynamic> toJson() => {
    "success": success,
    "data": data!.toJson(),
    "message": message,
  };
}

class Data {
  Data({
    this.nidFront,
    this.nidBack,
  });

  String? nidFront;
  String? nidBack;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    nidFront: json["nid_front"],
    nidBack: json["nid_back"],
  );

  Map<String, dynamic> toJson() => {
    "nid_front": nidFront,
    "nid_back": nidBack,
  };
}
