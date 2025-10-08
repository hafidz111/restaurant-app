import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant.dart';

RestauranDetailResponse restauranDetailResponseFromJson(String str) =>
    RestauranDetailResponse.fromJson(json.decode(str));

String restauranDetailResponseToJson(RestauranDetailResponse data) =>
    json.encode(data.toJson());

class RestauranDetailResponse {
  bool error;
  String message;
  Restaurant restaurant;

  RestauranDetailResponse({
    required this.error,
    required this.message,
    required this.restaurant,
  });

  factory RestauranDetailResponse.fromJson(Map<String, dynamic> json) =>
      RestauranDetailResponse(
        error: json["error"],
        message: json["message"],
        restaurant: Restaurant.fromJson(json["restaurant"]),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "restaurant": restaurant.toJson(),
  };
}
