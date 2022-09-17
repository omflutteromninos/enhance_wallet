// To parse this JSON data, do
//
//     final submitPassportPhotoResponse = submitPassportPhotoResponseFromJson(jsonString);

import 'dart:convert';

SubmitPassportPhotoResponse submitPassportPhotoResponseFromJson(String str) =>
    SubmitPassportPhotoResponse.fromJson(json.decode(str));

String submitPassportPhotoResponseToJson(SubmitPassportPhotoResponse data) =>
    json.encode(data.toJson());

class SubmitPassportPhotoResponse {
  SubmitPassportPhotoResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory SubmitPassportPhotoResponse.fromJson(Map<String, dynamic> json) =>
      SubmitPassportPhotoResponse(
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
    this.passFront,
    this.passBack,
  });

  String? passFront;
  String? passBack;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        passFront: json["pass_front"],
        passBack: json["pass_back"],
      );

  Map<String, dynamic> toJson() => {
        "pass_front": passFront,
        "pass_back": passBack,
      };
}
