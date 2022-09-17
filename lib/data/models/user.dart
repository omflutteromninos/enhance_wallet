// To parse this JSON data, do
//
//     final user = userFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

User userFromJson(String str) => User.fromJson(json.decode(str));

String userToJson(User data) => json.encode(data.toJson());


class User {
  User({
    required this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.resetCode,
    this.role,
    this.status,
    this.countryCode,
    this.phone,
    this.phoneVerified,
    this.country,
    this.gender,
    this.birthDate,
    this.photo,
    this.g2FEnabled,
    this.google2FaSecret,
    this.isVerified,
    this.language,
    this.deviceId,
    this.deviceType,
    this.pushNotificationStatus,
    this.emailNotificationStatus,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  String? firstName;
  String? lastName;
  String? email;
  dynamic resetCode;
  int? role;
  int? status;
  dynamic countryCode;
  dynamic phone;
  int? phoneVerified;
  dynamic country;
  int? gender;
  dynamic birthDate;
  String? photo;
  int? g2FEnabled;
  dynamic google2FaSecret;
  int? isVerified;
  String? language;
  dynamic deviceId;
  int? deviceType;
  int? pushNotificationStatus;
  int? emailNotificationStatus;
  dynamic createdAt;
  dynamic updatedAt;

  factory User.fromJson(Map<String, dynamic> json) => User(
    id: json["id"],
    firstName: json["first_name"],
    lastName: json["last_name"],
    email: json["email"],
    resetCode: json["reset_code"],
    role: json["role"],
    status: json["status"],
    countryCode: json["country_code"],
    phone: json["phone"],
    phoneVerified: json["phone_verified"],
    country: json["country"],
    gender: json["gender"],
    birthDate: json["birth_date"],
    photo: json["photo"],
    g2FEnabled: makeInt(json["g2f_enabled"]),
    google2FaSecret: json["google2fa_secret"],
    isVerified: json["is_verified"],
    language: json["language"],
    deviceId: json["device_id"],
    deviceType: json["device_type"],
    pushNotificationStatus: json["push_notification_status"],
    emailNotificationStatus: json["email_notification_status"],
    createdAt: json["created_at"],
    updatedAt: json["updated_at"],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "first_name": firstName,
    "last_name": lastName,
    "email": email,
    "reset_code": resetCode,
    "role": role,
    "status": status,
    "country_code": countryCode,
    "phone": phone,
    "phone_verified": phoneVerified,
    "country": country,
    "gender": gender,
    "birth_date": birthDate,
    "photo": photo,
    "g2f_enabled": g2FEnabled,
    "google2fa_secret": google2FaSecret,
    "is_verified": isVerified,
    "language": language,
    "device_id": deviceId,
    "device_type": deviceType,
    "push_notification_status": pushNotificationStatus,
    "email_notification_status": emailNotificationStatus,
    "created_at": createdAt == null ? null : createdAt,
    "updated_at": updatedAt == null ? null : updatedAt,
  };

  User createNewInstance() {
    var userMap = toJson();
    return User.fromJson(userMap);
  }
}


