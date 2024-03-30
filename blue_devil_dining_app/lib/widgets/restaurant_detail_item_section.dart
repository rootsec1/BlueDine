import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase(pocketbaseUrl);
final avatarUrl = pb.authStore.model?.avatar;

class RestaurantDetailItemSection extends StatefulWidget {
  final String restaurantName;
  final VoidCallback onItemAddedToCart;

  const RestaurantDetailItemSection({
    super.key,
    required this.restaurantName,
    required this.onItemAddedToCart,
  });

  @override
  State<RestaurantDetailItemSection> createState() =>
      _RestaurantDetailItemSectionState();
}

class _RestaurantDetailItemSectionState
    extends State<RestaurantDetailItemSection> {
  String selectedFoodTypeFilter = "All";
  String selectedFoodCategoryFilter = "All";

  Future<List<RecordModel>>? futureGetRestaurantItems;

  Future<List<RecordModel>> getRestaurantItems() async {
    String filter = 'restaurant = "${widget.restaurantName}"';
    if (selectedFoodTypeFilter != "All") {
      filter += ' && type = "$selectedFoodTypeFilter"';
    }
    if (selectedFoodCategoryFilter != "All") {
      filter += ' && category = "$selectedFoodCategoryFilter"';
    }
    return pb.collection("items").getFullList(filter: filter);
  }

  @override
  void didChangeDependencies() {
    setState(() {
      futureGetRestaurantItems = getRestaurantItems();
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<RecordModel>>(
      future: futureGetRestaurantItems,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(color: primaryColor));
        }

        if (snapshot.hasError) {
          return const Center(child: Text('Error loading items'));
        }

        final records = snapshot.data as List<RecordModel>;
        final items = records.map((record) => record.data).toList();
        final openingTime = items.first["time_start"] ?? "9am";
        final closingTime = items.first["time_close"] ?? "9pm";
        // Categories
        final Set<String> categories = {};
        for (final item in items) {
          categories.add(item["category"]);
        }
        final Set<String> categoriesForFilter = {"All"};
        categoriesForFilter.addAll(categories);

        // List of lists, category cards with items
        return Column(
          children: [
            // Opening & Closing Time
            Container(
              padding: const EdgeInsets.all(standardSeparation),
              child: Text(
                "Open from $openingTime to $closingTime",
                style: const TextStyle(
                  fontSize: standardSeparation,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            // List of lists
            ListView.builder(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              itemCount: categories.length,
              itemBuilder: (context, index) {
                final category = categories.elementAt(index);
                final categoryItems = items.where((item) {
                  return item["category"] == category;
                }).toList();
                return Card(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: standardPadding,
                        child: Text(
                          category,
                          style: const TextStyle(
                            fontSize: standardSeparation,
                            fontWeight: FontWeight.bold,
                            color: primaryColor,
                          ),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        itemCount: categoryItems.length,
                        itemBuilder: (context, index) {
                          final item = categoryItems[index];
                          final itemType = item["type"];
                          final tagsString = item["ingredients"];
                          List<String> tags = tagsString.split(";");
                          if (tags.length > 4) {
                            tags = tags.sublist(0, 4);
                          }
                          String description = item["description"];
                          if (description.endsWith(".")) {
                            description = description.substring(
                                0, description.length - 1);
                          }
                          String calories = item["calories"].toString();
                          description += " ● $calories cal";

                          List<Widget> chipList = tags.map((tag) {
                            return Container(
                              margin: const EdgeInsets.only(
                                right: standardSeparation / 2,
                              ),
                              child: Chip(
                                elevation: standardSeparation,
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(
                                    standardSeparation * 2,
                                  ),
                                ),
                                label: Text(
                                  tag,
                                  style: const TextStyle(
                                    fontSize: standardSeparation - 6,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                backgroundColor: backgroundColor,
                                visualDensity: VisualDensity.compact,
                                padding: EdgeInsets.zero,
                              ),
                            );
                          }).toList();

                          return Column(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ListTile(
                                dense: true,
                                visualDensity: VisualDensity.compact,
                                leading: itemType == "Vegetarian"
                                    ? Image.network(
                                        "https://upload.wikimedia.org/wikipedia/commons/thumb/7/78/Indian-vegetarian-mark.svg/1200px-Indian-vegetarian-mark.svg.png",
                                        height: standardSeparation + 4,
                                        width: standardSeparation + 4,
                                        fit: BoxFit.fill,
                                      )
                                    : itemType == "Vegan"
                                        ? Image.network(
                                            "https://upload.wikimedia.org/wikipedia/commons/d/d4/Vegan_friendly_icon.png",
                                            height: standardSeparation + 4,
                                            width: standardSeparation + 4,
                                            fit: BoxFit.fill,
                                          )
                                        : Image.network(
                                            "https://upload.wikimedia.org/wikipedia/commons/thumb/b/ba/Non_veg_symbol.svg/2048px-Non_veg_symbol.svg.png",
                                            height: standardSeparation + 4,
                                            width: standardSeparation + 4,
                                            fit: BoxFit.fill,
                                          ),
                                title: Text(
                                  item["name"],
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                subtitle: Text(
                                  description,
                                  style: const TextStyle(
                                    fontSize: standardSeparation - 4,
                                  ),
                                ),
                                trailing: Column(
                                  mainAxisSize: MainAxisSize.min,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Text(
                                      "\$${item["price"]}",
                                      textScaler: const TextScaler.linear(1.1),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: standardSeparation - 6,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    InkWell(
                                      onTap: widget.onItemAddedToCart,
                                      child: const Icon(
                                        Icons.add_outlined,
                                        size: standardSeparation + 4,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Container(
                                padding: const EdgeInsets.only(
                                  left: standardSeparation / 2,
                                  right: standardSeparation / 2,
                                  bottom: standardSeparation,
                                ),
                                child: Wrap(
                                  alignment: WrapAlignment.start,
                                  children: chipList,
                                ),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                );
              },
            ),
            const SizedBox(height: standardSeparation * 2),
          ],
        );
      },
    );
  }
}
