// To parse this JSON data, do
//
//     final settingsData = settingsDataFromJson(jsonString);

import 'dart:convert';

SettingsData settingsDataFromJson(String str) => SettingsData.fromJson(json.decode(str));

String settingsDataToJson(SettingsData data) => json.encode(data.toJson());

class SettingsData {
  SettingsData({
    this.languages,
    this.google2FaSecret,
    this.qrcode,
  });

  Map<String, String>? languages;
  String? google2FaSecret;
  String? qrcode;

  factory SettingsData.fromJson(Map<String, dynamic> json) => SettingsData(
    languages: Map.from(json["languages"]).map((k, v) => MapEntry<String, String>(k, v)),
    google2FaSecret: json["google2fa_secret"],
    qrcode: json["qrcode"],
  );

  Map<String, dynamic> toJson() => {
    "languages": languages == null ? null : Map.from(languages!).map((k, v) => MapEntry<String, dynamic>(k, v)),
    "google2fa_secret": google2FaSecret,
    "qrcode": qrcode,
  };
}



// To parse this JSON data, do
//
//     final settingsData = settingsDataFromJson(jsonString);

// import 'dart:convert';
//
// SettingsData settingsDataFromJson(String str) => SettingsData.fromJson(json.decode(str));
//
// String settingsDataToJson(SettingsData data) => json.encode(data.toJson());
//
// class SettingsData {
//   SettingsData({
//     this.languages,
//     this.google2FaSecret,
//     this.qrcode,
//   });
//
//   Map<String, String>? languages;
//   String? google2FaSecret;
//   String? qrcode;
//
//   factory SettingsData.fromJson(Map<String, dynamic> json) => SettingsData(
//     languages: Map.from(json["languages"]).map((k, v) => MapEntry<String, String>(k, v)),
//     google2FaSecret: json["google2fa_secret"],
//     qrcode: json["qrcode"],
//   );
//
//   Map<String, dynamic> toJson() => {
//     "languages": languages == null ? null : Map.from(languages!).map((k, v) => MapEntry<String, dynamic>(k, v)),
//     "google2fa_secret": google2FaSecret,
//     "qrcode": qrcode,
//   };
// }
