// To parse this JSON data, do
//
//     final faq = faqFromJson(jsonString);

import 'dart:convert';

import 'package:cPocket/utils/view_utils/common_utils.dart';

FAQ faqFromJson(String str) => FAQ.fromJson(json.decode(str));

String faqToJson(FAQ data) => json.encode(data.toJson());

class FAQ {
  FAQ({
    required this.id,
    //this.uniqueCode,
    this.question,
    this.answer,
    this.status,
    this.author,
    this.createdAt,
    this.updatedAt,
  });

  int id;
  //String? uniqueCode;
  String? question;
  String? answer;
  int? status;
  int? author;
  DateTime? createdAt;
  DateTime? updatedAt;

  factory FAQ.fromJson(Map<String, dynamic> json) => FAQ(
    id: json["id"],
    //uniqueCode: json["unique_code"],
    question: json["question"],
    answer: json["answer"],
    status:  makeInt(json["status"]),
    author:  makeInt(json["author"]),
    createdAt: json["created_at"] == null ? null : DateTime.parse(json["created_at"]),
    updatedAt: json["updated_at"] == null ? null : DateTime.parse(json["updated_at"]),
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    //"unique_code": uniqueCode,
    "question": question,
    "answer": answer,
    "status": status,
    "author": author,
    "created_at": formatDate(createdAt, format: dateTimeFormatYyyyMMDdHhMm),
    "updated_at": formatDate(updatedAt, format: dateTimeFormatYyyyMMDdHhMm),
  };
}
