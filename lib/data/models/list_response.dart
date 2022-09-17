// To parse this JSON data, do
//
//     final listResponse = listResponseFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

ListResponse listResponseFromJson(String str) => ListResponse.fromJson(json.decode(str));

String listResponseToJson(ListResponse data) => json.encode(data.toJson());

class ListResponse {
  ListResponse({
    this.currentPage,
    this.data,
    this.firstPageUrl,
    this.from,
    this.lastPage,
    this.lastPageUrl,
    this.nextPageUrl,
    this.path,
    this.perPage,
    this.prevPageUrl,
    this.to,
    this.total,
  });

  int? currentPage;
  List<dynamic>? data;
  String? firstPageUrl;
  int? from;
  int? lastPage;
  String? lastPageUrl;
  String? nextPageUrl;
  String? path;
  int? perPage;
  String? prevPageUrl;
  int? to;
  int? total;

  factory ListResponse.fromJson(Map<String, dynamic> json) => ListResponse(
    currentPage: makeInt(json["current_page"]),
    data: json["data"] == null ? [] : List<dynamic>.from(json["data"].map((x) => x)),
    firstPageUrl: json["first_page_url"],
    from: makeInt(json["from"]),
    lastPage: makeInt(json["last_page"]),
    lastPageUrl: json["last_page_url"],
    nextPageUrl: json["next_page_url"],
    path: json["path"],
    perPage: makeInt(json["per_page"]),
    prevPageUrl: json["prev_page_url"],
    to: makeInt(json["to"]),
    total: makeInt(json["total"]),
  );

  Map<String, dynamic> toJson() => {
    "current_page": currentPage,
    "data": data == null ? null : List<dynamic>.from(data!.map((x) => x.toJson())),
    "first_page_url": firstPageUrl,
    "from": from,
    "last_page": lastPage,
    "last_page_url": lastPageUrl,
    "next_page_url": nextPageUrl,
    "path": path,
    "per_page": perPage,
    "prev_page_url": prevPageUrl,
    "to": to,
    "total": total,
  };
}

