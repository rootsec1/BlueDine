import 'package:blue_devil_dining_app/pages/chatbot_page.dart';
import 'package:blue_devil_dining_app/pages/home.dart';
import 'package:blue_devil_dining_app/pages/restaurant_detail_page.dart';
import 'package:blue_devil_dining_app/pages/sign_in.dart';
import 'package:flutter/material.dart';
// Local
import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/pages/splash_page.dart';

final Map<String, Widget Function(BuildContext context)> appRoutes =
    <String, Widget Function(BuildContext)>{
  PageNames.SPLASH_PAGE.name: (_) => const SplashPage(),
  PageNames.SIGN_IN_PAGE.name: (_) => const SignInPage(),
  PageNames.HOME_PAGE.name: (_) => const HomePage(),
  PageNames.CHATBOT_PAGE.name: (_) => const ChatBotPage(),
  PageNames.RESTAURANT_DETAIL_PAGE.name: (_) => const RestaurantDetailPage(),
};
