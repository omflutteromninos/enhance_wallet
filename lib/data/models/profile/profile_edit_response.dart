// To parse this JSON data, do
//
//     final editUserResponse = editUserResponseFromJson(jsonString);

import 'dart:convert';
import '../user.dart';

ProfileEditResponse editUserResponseFromJson(String str) => ProfileEditResponse.fromJson(json.decode(str));

String editUserResponseToJson(ProfileEditResponse data) => json.encode(data.toJson());

class ProfileEditResponse {
  ProfileEditResponse({
    this.user,
    this.countries,
    this.genders,
  });

  User? user;
  Map<String, String>? countries;
  Map<String, String>? genders;

  factory ProfileEditResponse.fromJson(Map<String, dynamic> json) => ProfileEditResponse(
    user: User.fromJson(json["user"]),
    countries: Map.from(json["countries"]).map((k, v) => MapEntry<String, String>(k, v)),
    genders: Map.from(json["genders"]).map((k, v) => MapEntry<String, String>(k, v)),
  );

  Map<String, dynamic> toJson() => {
    "user": user == null ? null : user!.toJson(),
    "countries": countries == null ? null : Map.from(countries!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "genders": genders == null ? null : Map.from(genders!).map((k, v) => MapEntry<String, dynamic>(k, v)),
  };
}


