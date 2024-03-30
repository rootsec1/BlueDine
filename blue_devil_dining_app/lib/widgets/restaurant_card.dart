import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_fonts/google_fonts.dart';

class RestaurantCard extends StatelessWidget {
  final String restaurantName;
  final List<String> tags;
  final String imageUrl;
  final double rating;
  final double latitude;
  final double longitude;

  const RestaurantCard({
    super.key,
    required this.restaurantName,
    required this.tags,
    required this.imageUrl,
    required this.rating,
    required this.latitude,
    required this.longitude,
  });

  @override
  Widget build(BuildContext context) {
    List<Widget> chipList = tags.map((tag) {
      return Container(
        margin: const EdgeInsets.only(right: standardSeparation / 2),
        child: Chip(
          elevation: standardSeparation,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(standardSeparation * 2),
          ),
          label: Text(
            tag,
            style: const TextStyle(
              fontSize: standardSeparation - 4,
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

    return GestureDetector(
      onTap: () {
        Navigator.pushNamed(
          context,
          PageNames.RESTAURANT_DETAIL_PAGE.name,
          arguments: {
            'name': restaurantName,
            'tags': tags,
            'image_url': imageUrl,
            'rating': rating,
            'latitude': latitude,
            'longitude': longitude,
          },
        );
      },
      child: Card(
        elevation: standardSeparation,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(standardSeparation),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(standardSeparation),
          child: SizedBox(
            width: double.infinity,
            height: 200,
            child: Stack(
              children: [
                SizedBox(
                  height: double.infinity,
                  width: double.infinity,
                  child: Image.network(
                    imageUrl,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: standardSeparation / 3,
                  right: standardSeparation / 1.5,
                  child: Container(
                    padding: const EdgeInsets.only(
                      left: 4,
                      right: 4,
                      top: 2,
                      bottom: 2,
                    ),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(standardSeparation),
                      color: Colors.white.withAlpha(200),
                    ),
                    child: Row(
                      children: [
                        Text(
                          rating.toStringAsFixed(1),
                          style: const TextStyle(
                            fontSize: standardSeparation - 6,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(width: standardSeparation / 4),
                        RatingBarIndicator(
                          rating: rating,
                          itemCount: 5,
                          itemSize: standardSeparation - 4,
                          unratedColor: Colors.white,
                          itemBuilder: (context, index) {
                            return const Icon(
                              Icons.star,
                              color: Colors.amber,
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  child: Container(
                    margin: const EdgeInsets.only(
                      left: standardSeparation / 2,
                      bottom: standardSeparation / 2,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: const EdgeInsets.only(
                              left: standardSeparation / 4),
                          child: Text(
                            restaurantName,
                            style: GoogleFonts.playfairDisplay().copyWith(
                              fontWeight: FontWeight.bold,
                              fontSize: standardSeparation * 2,
                              color: Colors.white,
                            ),
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: chipList,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
