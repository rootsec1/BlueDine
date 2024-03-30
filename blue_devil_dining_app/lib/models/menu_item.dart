import 'dart:convert';

class MenuItem {
  final double calories;
  final String category;
  final String description;
  final List<String> ingredients;
  final String name;
  final String price;
  final String restaurant;
  final String timeClose;
  final String timeOpen;
  final String type;

  MenuItem({
    required this.calories,
    required this.category,
    required this.description,
    required this.ingredients,
    required this.name,
    required this.price,
    required this.restaurant,
    required this.timeClose,
    required this.timeOpen,
    required this.type,
  });

  factory MenuItem.fromJson(Map<String, dynamic> json) {
    dynamic calories = json['calories'];
    // If calories is not of type double, return 150
    if (calories == null || calories.runtimeType == String) {
      calories = 150.0;
    }

    return MenuItem(
      calories: calories,
      category: json['category'],
      description: json['description'] ?? "",
      ingredients: List<String>.from(json['ingredients']),
      name: json['name'],
      price: json['price'].toString(),
      restaurant: json['restaurant'],
      timeClose: json['timeclose'],
      timeOpen: json['timeopen'],
      type: json['type'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'calories': calories,
      'category': category,
      'description': description,
      'ingredients': ingredients,
      'name': name,
      'price': price,
      'restaurant': restaurant,
      'timeclose': timeClose,
      'timeopen': timeOpen,
      'type': type,
    };
  }
}
