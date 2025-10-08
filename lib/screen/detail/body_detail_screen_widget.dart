import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';
import 'package:restaurant_app/screen/detail/description_widget.dart';
import 'package:restaurant_app/screen/detail/menu_widget.dart';
import 'package:restaurant_app/screen/detail/restaurant_header_widget.dart';
import 'package:restaurant_app/screen/detail/reviews_widget.dart';

class BodyOfDetailScreenWidget extends StatelessWidget {
  const BodyOfDetailScreenWidget({super.key, required this.restaurant});

  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            RestaurantHeader(restaurant: restaurant),
            const SizedBox(height: 16),
            ExpandableDescription(text: restaurant.description),
            const SizedBox(height: 24),
            RestaurantMenu(restaurant: restaurant),
            const SizedBox(height: 24),
            RestaurantReviews(restaurant: restaurant),
          ],
        ),
      ),
    );
  }
}
