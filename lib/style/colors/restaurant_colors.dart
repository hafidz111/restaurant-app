import 'package:flutter/material.dart';

enum RestaurantColors {
  blue("Blue", Color.fromARGB(255, 214, 214, 35));

  const RestaurantColors(this.name, this.color);

  final String name;
  final Color color;
}
