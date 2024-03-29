import 'package:blue_devil_dining_app/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
// Local
import 'package:blue_devil_dining_app/themes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  @override
  void didChangeDependencies() {
    // After 5 seconds, navigate to the sign in page
    Future.delayed(const Duration(seconds: 5), () {
      Navigator.pushNamed(context, PageNames.SIGN_IN_PAGE.name);
    });

    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Lottie.asset("assets/lottie/splash_animation.json"),
          Text(
            appName,
            style: GoogleFonts.playfairDisplay().copyWith(
              color: backgroundColor,
              fontSize: standardSeparation * 3,
              fontWeight: FontWeight.bold,
            ),
          ),
        ],
      ),
    );
  }
}
