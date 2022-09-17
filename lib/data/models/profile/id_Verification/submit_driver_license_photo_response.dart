// To parse this JSON data, do
//
//     final submitDriverLicensePhotoResponse = submitDriverLicensePhotoResponseFromJson(jsonString);

import 'dart:convert';

SubmitDriverLicensePhotoResponse submitDriverLicensePhotoResponseFromJson(
        String str) =>
    SubmitDriverLicensePhotoResponse.fromJson(json.decode(str));

String submitDriverLicensePhotoResponseToJson(
        SubmitDriverLicensePhotoResponse data) =>
    json.encode(data.toJson());

class SubmitDriverLicensePhotoResponse {
  SubmitDriverLicensePhotoResponse({
    this.success,
    this.data,
    this.message,
  });

  bool? success;
  Data? data;
  String? message;

  factory SubmitDriverLicensePhotoResponse.fromJson(
          Map<String, dynamic> json) =>
      SubmitDriverLicensePhotoResponse(
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
    this.driveFront,
    this.driveBack,
  });

  String? driveFront;
  String? driveBack;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        driveFront: json["drive_front"],
        driveBack: json["drive_back"],
      );

  Map<String, dynamic> toJson() => {
        "drive_front": driveFront,
        "drive_back": driveBack,
      };
}
