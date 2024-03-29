import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/widgets/search_bar.dart';
import 'package:flutter/material.dart';
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
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const Row(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              Icons.location_on_outlined,
              size: standardSeparation * 2,
            ),
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
  onChatbotButtonPressed() {}

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
          ],
        ),
      ),
    );
  }
}
