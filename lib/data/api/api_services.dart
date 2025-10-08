import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:restaurant_app/data/model/restaurant_detail_response.dart';
import 'package:restaurant_app/data/model/restaurant_list_response.dart';

class ApiServices {
  static const String baseUrl = "https://restaurant-api.dicoding.dev";
  static String getImageUrl(String pictureId, {String size = "small"}) {
    return "$baseUrl/images/$size/$pictureId";
  }

  Future<RestauranListResponse> getRestaurantList() async {
    final response = await http.get(Uri.parse("$baseUrl/list"));

    if (response.statusCode == 200) {
      return RestauranListResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant list");
    }
  }

  Future<RestauranDetailResponse> getRestaurantDetail(String id) async {
    final response = await http.get(Uri.parse("$baseUrl/detail/$id"));

    if (response.statusCode == 200) {
      return RestauranDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail");
    }
  }

  Future<RestauranDetailResponse> getRestaurantSearch(String query) async {
    final response = await http.get(Uri.parse("$baseUrl/search?q=$query"));

    if (response.statusCode == 200) {
      return RestauranDetailResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to load restaurant detail");
    }
  }
}
