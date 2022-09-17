// To parse this JSON data, do
//
//     final response = responseFromJson(jsonString);

import 'dart:convert';

/// *** Common Server Response *** ///

ServerResponse responseFromJson(String str) => ServerResponse.fromJson(json.decode(str));

String responseToJson(ServerResponse data) => json.encode(data.toJson());

class ServerResponse {
  ServerResponse({
    required this.success,
    required this.message,
    this.data,
  });

  bool success;
  String message;
  dynamic data;

  factory ServerResponse.fromJson(Map<String, dynamic> json) => ServerResponse(
        success: json["success"],
        message: json["message"],
        data: json["data"],
      );

  Map<String, dynamic> toJson() => {
        "success": success,
        "message": message,
        "data": data,
      };
}


/*

/// *** Category Server Response *** ///

CategoryResponse categoryResponseFromJson(String str) =>
    CategoryResponse.fromJson(json.decode(str));

String categoryResponseToJson(CategoryResponse data) =>
    json.encode(data.toJson());

class CategoryResponse {
  CategoryResponse({
    this.categories,
  });

  List<Category> categories;

  factory CategoryResponse.fromJson(Map<String, dynamic> json) =>
      CategoryResponse(
        categories: List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
      };
}

/// *** Product Details Server Response *** ///

ProductDetailsResponse productDetailsResponseFromJson(String str) =>
    ProductDetailsResponse.fromJson(json.decode(str));

String productDetailsResponseToJson(ProductDetailsResponse data) =>
    json.encode(data.toJson());

class ProductDetailsResponse {
  ProductDetailsResponse({
    this.baseImageUrl,
    this.auction,
    this.productImages,
    this.productTags,
    this.auctionMessages,
    this.myBid,
  });

  String baseImageUrl;
  Auction auction;
  MyBid myBid;
  List<ProductImage> productImages;
  List<dynamic> productTags;
  List<BidMessage> auctionMessages;

  factory ProductDetailsResponse.fromJson(Map<String, dynamic> json) =>
      ProductDetailsResponse(
        baseImageUrl: json["base_image_url"],
        auction: Auction.fromJson(json["auction"]),
        myBid: json["my_bid"] == null ? null : MyBid.fromJson(json["my_bid"]),
        productImages: List<ProductImage>.from(
            json["product_images"].map((x) => ProductImage.fromJson(x))),
        productTags: List<dynamic>.from(json["product_tags"].map((x) => x)),
        auctionMessages: List<BidMessage>.from(
            json["auction_messages"].map((x) => BidMessage.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "base_image_url": baseImageUrl,
        "auction": auction.toJson(),
        "my_bid": myBid == null ? null : myBid.toJson(),
        "product_images":
            List<ProductImage>.from(productImages.map((x) => x.toJson())),
        "product_tags": List<dynamic>.from(productTags.map((x) => x)),
        "auction_messages":
            List<BidMessage>.from(auctionMessages.map((x) => x)),
      };
}
*/
