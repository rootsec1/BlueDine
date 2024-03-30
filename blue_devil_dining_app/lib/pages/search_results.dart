import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/models/menu_item.dart';
import 'package:blue_devil_dining_app/services/api_service.dart';
import 'package:blue_devil_dining_app/themes.dart';
import 'package:blue_devil_dining_app/util.dart';
import 'package:flutter/material.dart';

class SearchResultsContainer extends StatefulWidget {
  final String query;
  final BuildContext dialogContext;

  const SearchResultsContainer({
    super.key,
    required this.query,
    required this.dialogContext,
  });

  @override
  State<SearchResultsContainer> createState() => _SearchResultsContainerState();
}

class _SearchResultsContainerState extends State<SearchResultsContainer> {
  Future<List<MenuItem>>? getSearchResultsFuture;

  int cartCount = 0;

  Widget getSearchResults() {
    return FutureBuilder<List<MenuItem>>(
      future: getSearchResultsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(
            child: Container(
              margin: const EdgeInsets.only(top: standardSeparation * 4),
              child: const CircularProgressIndicator(color: primaryColor),
            ),
          );
        }

        if (snapshot.hasError) {
          return const Center(
            child: Text(
              "An error occurred",
              style: TextStyle(color: Colors.red),
            ),
          );
        }

        final List<MenuItem> items = snapshot.data!;
        // Restaurant names
        final Set<String> restaurants = {};
        for (final item in items) {
          restaurants.add(item.restaurant);
        }

        // List of lists, category cards with items
        return ListView.builder(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          physics: const ClampingScrollPhysics(),
          itemCount: restaurants.length,
          itemBuilder: (context, index) {
            final restaurant = restaurants.elementAt(index);
            final restaurantItems = items.where((item) {
              return item.restaurant == restaurant;
            }).toList();
            return Card(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                    padding: standardPadding,
                    child: Text(
                      restaurant,
                      style: const TextStyle(
                        fontSize: standardSeparation,
                        fontWeight: FontWeight.bold,
                        color: primaryColor,
                      ),
                    ),
                  ),
                  ListView.builder(
                    shrinkWrap: true,
                    padding: EdgeInsets.zero,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: restaurantItems.length,
                    itemBuilder: (context, index) {
                      final item = restaurantItems[index];
                      final itemType = item.type;
                      String price = item.price;
                      if (price.contains(" ")) {
                        price = price.split(" ")[1];
                      }

                      List<String> tags = item.ingredients;
                      if (tags.length > 4) {
                        tags = tags.sublist(0, 4);
                      }
                      String description = item.description;
                      if (description.endsWith(".")) {
                        description =
                            description.substring(0, description.length - 1);
                      }
                      String calories = item.calories.toString();
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
                              item.name,
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
                                  "\$$price",
                                  textScaler: const TextScaler.linear(1.1),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: standardSeparation - 6,
                                  ),
                                ),
                                const SizedBox(height: 4),
                                InkWell(
                                  onTap: () => setState(() => cartCount++),
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
        );
      },
    );
  }

  @override
  void didChangeDependencies() {
    setState(() {
      getSearchResultsFuture = fetchMenuItems(widget.query);
    });
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        top: standardSeparation / 2,
        left: standardSeparation / 1.5,
        right: standardSeparation / 1.5,
      ),
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(height: standardSeparation / 2),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                '"${widget.query}"',
                style: const TextStyle(
                  fontSize: standardSeparation,
                  fontWeight: FontWeight.bold,
                ),
              ),
              FilledButton.icon(
                onPressed: () {
                  Navigator.pop(widget.dialogContext);
                  alertUser("Order created successfully ✅", context);
                },
                icon: const Text("Checkout"),
                label: Badge.count(
                  count: cartCount,
                  child: const Icon(
                    Icons.shopping_cart_outlined,
                    size: standardSeparation * 1.5,
                  ),
                ),
              ),
            ],
          ),
          const SizedBox(height: standardSeparation),
          Expanded(child: getSearchResults()),
        ],
      ),
    );
  }
}
