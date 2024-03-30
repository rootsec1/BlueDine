import 'package:blue_devil_dining_app/util.dart';
import 'package:blue_devil_dining_app/widgets/restaurant_detail_item_section.dart';
import 'package:blue_devil_dining_app/widgets/restaurant_detail_top_section.dart';
import 'package:flutter/material.dart';

class RestaurantDetailPage extends StatefulWidget {
  const RestaurantDetailPage({super.key});

  @override
  State<RestaurantDetailPage> createState() => _RestaurantDetailPageState();
}

class _RestaurantDetailPageState extends State<RestaurantDetailPage> {
  int itemsInCartCount = 0;

  @override
  Widget build(BuildContext context) {
    final restaurantData =
        ModalRoute.of(context)!.settings.arguments as Map<String, dynamic>;
    final String restaurantName = restaurantData["name"];

    return Scaffold(
      floatingActionButton: itemsInCartCount == 0
          ? null
          : FloatingActionButton.extended(
              onPressed: () {
                alertUser("Order created successfully ✅", context);
              },
              icon: const Text("Checkout"),
              label: Badge(
                label: Text(itemsInCartCount.toString()),
                child: const Icon(Icons.shopping_cart_outlined),
              ),
            ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            RestaurantDetailTopSection(
              restaurantName: restaurantName,
              tags: restaurantData["tags"],
              imageUrl: restaurantData["image_url"],
              rating: restaurantData["rating"],
              latitude: restaurantData["latitude"],
              longitude: restaurantData["longitude"],
            ),
            RestaurantDetailItemSection(
              restaurantName: restaurantName,
              onItemAddedToCart: () => setState(() => itemsInCartCount++),
            ),
          ],
        ),
      ),
    );
  }
}
