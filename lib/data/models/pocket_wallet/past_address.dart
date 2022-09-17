// To parse this JSON data, do
//
//     final pastAddress = pastAddressFromJson(jsonString);

import 'dart:convert';

PastAddress pastAddressFromJson(String str) => PastAddress.fromJson(json.decode(str));

String pastAddressToJson(PastAddress data) => json.encode(data.toJson());

class PastAddress {
  PastAddress({
    this.addresses,
    this.isDataLoaded
  });

  List<Address>? addresses;
  bool? isDataLoaded;


  factory PastAddress.fromJson(Map<String, dynamic> json) => PastAddress(
    addresses: List<Address>.from(json["addresses"].map((x) => Address.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "addresses": addresses == null ? null : List<dynamic>.from(addresses!.map((x) => x.toJson())),
  };
}

class Address {
  Address({
    this.address,
  });

  String? address;

  factory Address.fromJson(Map<String, dynamic> json) => Address(
    address: json["address"],
  );

  Map<String, dynamic> toJson() => {
    "address": address,
  };
}
