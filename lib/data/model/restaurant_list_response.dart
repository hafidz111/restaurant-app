import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant.dart';

RestauranListResponse restauranListResponseFromJson(String str) =>
    RestauranListResponse.fromJson(json.decode(str));

String restauranListResponseToJson(RestauranListResponse data) =>
    json.encode(data.toJson());

class RestauranListResponse {
  bool error;
  String message;
  int count;
  List<Restaurant> restaurants;

  RestauranListResponse({
    required this.error,
    required this.message,
    required this.count,
    required this.restaurants,
  });

  factory RestauranListResponse.fromJson(Map<String, dynamic> json) =>
      RestauranListResponse(
        error: json["error"],
        message: json["message"],
        count: json["count"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "message": message,
    "count": count,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
