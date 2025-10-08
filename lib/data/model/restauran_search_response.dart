import 'dart:convert';

import 'package:restaurant_app/data/model/restaurant.dart';

RestauranSearchResponse restauranSearchResponseFromJson(String str) =>
    RestauranSearchResponse.fromJson(json.decode(str));

String restauranSearchResponseToJson(RestauranSearchResponse data) =>
    json.encode(data.toJson());

class RestauranSearchResponse {
  bool error;
  int founded;
  List<Restaurant> restaurants;

  RestauranSearchResponse({
    required this.error,
    required this.founded,
    required this.restaurants,
  });

  factory RestauranSearchResponse.fromJson(Map<String, dynamic> json) =>
      RestauranSearchResponse(
        error: json["error"],
        founded: json["founded"],
        restaurants: List<Restaurant>.from(
          json["restaurants"].map((x) => Restaurant.fromJson(x)),
        ),
      );

  Map<String, dynamic> toJson() => {
    "error": error,
    "founded": founded,
    "restaurants": List<dynamic>.from(restaurants.map((x) => x.toJson())),
  };
}
