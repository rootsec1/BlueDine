// ignore_for_file: constant_identifier_names

// Strings
import 'package:flutter/material.dart';

const String appName = "BlueDine";
const String pocketbaseUrl = "http://192.168.1.18:8090";
const String apiUrl = "http://192.168.1.18:8000";

const List<String> foodTypes = ["All", "Vegetarian", "Vegan"];

// numbers
const double standardSeparation = 16.0;

// Enums
enum PageNames {
  SPLASH_PAGE,
  SIGN_IN_PAGE,
  HOME_PAGE,
  CHATBOT_PAGE,
  RESTAURANT_DETAIL_PAGE,
  SPEND_ANALYSIS_PAGE,
}

// Padding
const standardPadding = EdgeInsets.only(
  left: standardSeparation,
  right: standardSeparation,
  top: standardSeparation,
);
