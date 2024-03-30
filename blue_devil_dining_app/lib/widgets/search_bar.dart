import 'dart:async';

import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/pages/search_results.dart';
import 'package:flutter/material.dart';

final List<String> hintOptions = [
  "search restaurants",
  "search \"vegetarian food under \$10\"",
  "search items",
  "search \"vegan food\"",
  "search \"food near me\"",
  "search \"gluten free food\"",
];

class CustomSearchBar extends StatefulWidget {
  const CustomSearchBar({super.key});

  @override
  State<CustomSearchBar> createState() => _CustomSearchBarState();
}

class _CustomSearchBarState extends State<CustomSearchBar> {
  final TextEditingController controller = TextEditingController();

  String currentHint = hintOptions[0];

  @override
  void didChangeDependencies() {
    // Repeat Every 2 seconds change the hint text
    Timer.periodic(const Duration(seconds: 2), (timer) {
      final randomIndex = DateTime.now().second % hintOptions.length;
      setState(() {
        currentHint = hintOptions[randomIndex];
      });
    });
    super.didChangeDependencies();
  }

  onSearchSubmitted(String query) {
    query = query.trim();
    showModalBottomSheet(
      isDismissible: true,
      context: context,
      builder: (dialogContext) {
        return SearchResultsContainer(
          query: query,
          dialogContext: dialogContext,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return SearchBar(
      onSubmitted: onSearchSubmitted,
      backgroundColor: const MaterialStatePropertyAll<Color>(Colors.white),
      surfaceTintColor: const MaterialStatePropertyAll<Color>(Colors.white),
      controller: controller,
      padding: const MaterialStatePropertyAll<EdgeInsets>(
        EdgeInsets.symmetric(horizontal: standardSeparation),
      ),
      textInputAction: TextInputAction.search,
      leading: const Icon(Icons.search, size: standardSeparation + 4),
      hintText: currentHint,
      hintStyle: const MaterialStatePropertyAll<TextStyle>(
        TextStyle(
          color: Colors.grey,
          fontSize: standardSeparation - 2,
        ),
      ),
      textStyle: const MaterialStatePropertyAll<TextStyle>(
        TextStyle(
          color: Colors.black,
          fontSize: standardSeparation - 2,
        ),
      ),
      trailing: const <Widget>[
        Tooltip(
          message: 'Voice Search',
          child: Icon(
            Icons.mic_outlined,
            size: standardSeparation + 4,
          ),
        )
      ],
    );
  }
}
