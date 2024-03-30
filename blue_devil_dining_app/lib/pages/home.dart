import 'dart:math';

import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/themes.dart';
import 'package:blue_devil_dining_app/util.dart';
import 'package:blue_devil_dining_app/widgets/restaurant_card.dart';
import 'package:blue_devil_dining_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:pocketbase/pocketbase.dart';

final pb = PocketBase(pocketbaseUrl);
final avatarUrl = pb.authStore.model?.avatar;

class _TopRowWidget extends StatelessWidget {
  final RecordModel recordModel;

  const _TopRowWidget({required this.recordModel});

  @override
  Widget build(BuildContext context) {
    final Uri avatarUri = pb.getFileUrl(
      recordModel,
      recordModel.data["avatar"],
    );
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.location_on_outlined),
            SizedBox(width: standardSeparation / 4),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Brodhead Center",
                  style: TextStyle(
                    fontSize: standardSeparation,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  "0.2 miles away",
                  style: TextStyle(fontSize: standardSeparation - 2),
                )
              ],
            )
          ],
        ),
        Expanded(child: Container()),
        GestureDetector(
          onTap: () => intentCallPhoneNumber("(919)-660-1765"),
          child: const Tooltip(
            message: "Report Lost & Found",
            child: Icon(
              Icons.flag_outlined,
              size: standardSeparation * 1.5,
            ),
          ),
        ),
        const SizedBox(width: standardSeparation),
        const Icon(Icons.insights_outlined, size: standardSeparation * 1.5),
        const SizedBox(width: standardSeparation),
        CircleAvatar(
          radius: standardSeparation * 1.5,
          child: Image.network(avatarUri.toString()),
        ),
      ],
    );
  }
}

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Future<List<RecordModel>>? restaurantsFuture;

  onChatbotButtonPressed() {
    final recordModel =
        ModalRoute.of(context)!.settings.arguments as RecordModel;
    final userFullName = recordModel.data["name"];
    Navigator.pushNamed(
      context,
      PageNames.CHATBOT_PAGE.name,
      arguments: userFullName,
    );
  }

  @override
  void didChangeDependencies() {
    setState(() {
      restaurantsFuture = pb.collection("restaurants").getFullList();
    });
    super.didChangeDependencies();
  }

  Widget getRestaurantCards() {
    return FutureBuilder(
      future: restaurantsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: primaryColor,
          ));
        }

        if (snapshot.hasError) {
          return const Center(child: Text("An error occurred"));
        }

        final records = snapshot.data as List<RecordModel>;

        return ListView.builder(
          itemBuilder: (context, index) {
            final recData = records[index].data;
            final tagsString = (recData["tags"] as String).trim();
            List<String> tagsList = tagsString.split(";");
            // Filter tagsList if _ in string
            tagsList = tagsList
                .where((tag) =>
                    !tag.contains("_") &&
                    !tag.contains("dining") &&
                    !tag.contains("mobile"))
                .toList();

            // Generate a random number for ratings between 3.5 and 5.0
            final random = Random();
            double rating = (random.nextDouble() * 1.5) + 3.2;

            return Container(
              margin: const EdgeInsets.only(bottom: standardSeparation),
              child: RestaurantCard(
                restaurantName: recData["name"],
                imageUrl: recData["image_url"],
                tags: tagsList,
                rating: rating,
                latitude: recData["latitude"],
                longitude: recData["longitude"],
              ),
            );
          },
          itemCount: records.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final recordModel =
        ModalRoute.of(context)!.settings.arguments as RecordModel;

    return Scaffold(
      floatingActionButton: FloatingActionButton.extended(
        onPressed: onChatbotButtonPressed,
        icon: const Icon(
          Icons.support_agent,
          size: standardSeparation * 2,
        ),
        label: const Text(
          "blue bot",
          style: TextStyle(fontSize: standardSeparation),
        ),
      ),
      body: SingleChildScrollView(
        padding: standardPadding,
        child: Column(
          children: [
            _TopRowWidget(recordModel: recordModel),
            const SizedBox(height: standardSeparation),
            const CustomSearchBar(),
            const SizedBox(height: standardSeparation * 2),
            getRestaurantCards(),
            const SizedBox(height: standardSeparation),
          ],
        ),
      ),
    );
  }
}
