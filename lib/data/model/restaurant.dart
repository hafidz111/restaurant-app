import 'package:restaurant_app/data/model/restaurant_category.dart';
import 'package:restaurant_app/data/model/restaurant_customer_review.dart';
import 'package:restaurant_app/data/model/restaurant_menus.dart';

class Restaurant {
  String id;
  String name;
  String description;
  String city;
  String? address;
  String pictureId;
  List<Category> categories;
  Menus? menus;
  double rating;
  List<CustomerReview> customerReviews;

  Restaurant({
    required this.id,
    required this.name,
    required this.description,
    required this.city,
    this.address,
    required this.pictureId,
    this.categories = const [],
    this.menus,
    this.rating = 0.0,
    this.customerReviews = const [],
  });

  factory Restaurant.fromJson(Map<String, dynamic> json) => Restaurant(
    id: json["id"] ?? "",
    name: json["name"] ?? "",
    description: json["description"] ?? "",
    city: json["city"] ?? "",
    address: json["address"],
    pictureId: json["pictureId"] ?? "",
    categories: (json["categories"] != null)
        ? List<Category>.from(
            json["categories"].map((x) => Category.fromJson(x)),
          )
        : [],
    menus: json["menus"] != null ? Menus.fromJson(json["menus"]) : null,
    rating: (json["rating"] ?? 0).toDouble(),
    customerReviews: (json["customerReviews"] != null)
        ? List<CustomerReview>.from(
            json["customerReviews"].map((x) => CustomerReview.fromJson(x)),
          )
        : [],
  );

  Map<String, dynamic> toJson() => {
    "id": id,
    "name": name,
    "description": description,
    "city": city,
    "address": address,
    "pictureId": pictureId,
    "categories": List<dynamic>.from(categories.map((x) => x.toJson())),
    "menus": menus?.toJson(),
    "rating": rating,
    "customerReviews": List<dynamic>.from(
      customerReviews.map((x) => x.toJson()),
    ),
  };
}
