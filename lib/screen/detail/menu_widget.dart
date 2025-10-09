import 'package:flutter/material.dart';
import 'package:restaurant_app/data/model/restaurant.dart';

class RestaurantMenu extends StatelessWidget {
  const RestaurantMenu({super.key, required this.restaurant});
  final Restaurant restaurant;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Categories", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 4,
          children: restaurant.categories
              .map(
                (cat) => Chip(
                  label: Text(cat.name),
                  backgroundColor: Theme.of(
                    context,
                  ).colorScheme.primaryContainer,
                  labelStyle: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
              )
              .toList(),
        ),
        const SizedBox(height: 24),
        Text("Foods", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        _horizontalMenuList(
          context,
          restaurant.menus!.foods.map((e) => e.name).toList(),
          icon: Icons.restaurant_menu,
        ),
        const SizedBox(height: 16),
        Text("Drinks", style: Theme.of(context).textTheme.titleMedium),
        const SizedBox(height: 8),
        _horizontalMenuList(
          context,
          restaurant.menus!.drinks.map((e) => e.name).toList(),
          icon: Icons.local_drink,
        ),
      ],
    );
  }

  Widget _horizontalMenuList(
    BuildContext context,
    List<String> items, {
    required IconData icon,
  }) {
    return SizedBox(
      height: 120,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: items.length,
        separatorBuilder: (context, index) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          return SizedBox(
            width: 150,
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, size: 32),
                    const SizedBox(height: 8),
                    Text(
                      items[index],
                      style: Theme.of(context).textTheme.bodyMedium,
                      textAlign: TextAlign.center,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
