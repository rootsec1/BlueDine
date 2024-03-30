import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/themes.dart';
import 'package:flutter/material.dart';

class SpendAnalysisPage extends StatefulWidget {
  const SpendAnalysisPage({super.key});

  @override
  State<SpendAnalysisPage> createState() => _SpendAnalysisPageState();
}

class _SpendAnalysisPageState extends State<SpendAnalysisPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        foregroundColor: Colors.white,
        title: const Text(
          "Spend Analysis",
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: primaryColor,
      ),
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              left: standardSeparation,
              right: standardSeparation,
              top: standardSeparation,
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Chip(
                  label: const Text(
                    "DukeCard",
                    style: TextStyle(fontSize: standardSeparation),
                  ),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(standardSeparation),
                  ),
                ),
                const SizedBox(height: standardSeparation * 2),
                const Text(
                  "Account Balance",
                  style: TextStyle(
                    fontSize: standardSeparation,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: standardSeparation / 2),
                const Text(
                  "\$22,021.36",
                  style: TextStyle(
                    fontSize: standardSeparation * 3,
                    fontWeight: FontWeight.bold,
                    color: primaryColor,
                  ),
                ),
                const SizedBox(height: standardSeparation),
                const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SizedBox(
                        height: 110,
                        child: Card(
                          color: Colors.green,
                          child: Center(
                            child: Text(
                              "Amount credited\n\$16092.32",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: standardSeparation,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 110,
                        child: Card(
                          color: Colors.red,
                          child: Center(
                            child: Text(
                              "Amount debited\n\$5393.16",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: standardSeparation,
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: standardSeparation * 1.5),
                Image.asset(
                  "assets/images/2024_monthy.png",
                  height: 256,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: standardSeparation * 1.5),
                Image.asset(
                  "assets/images/2023_monthy.png",
                  height: 256,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: standardSeparation * 1.5),
                Image.asset(
                  "assets/images/2022_monthy.png",
                  height: 256,
                  width: double.infinity,
                  fit: BoxFit.fill,
                ),
                const SizedBox(height: standardSeparation * 1.5),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
