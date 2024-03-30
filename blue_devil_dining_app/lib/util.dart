import 'dart:io';

import 'package:android_intent_plus/flag.dart';
import 'package:android_intent_plus/android_intent.dart';
import 'package:flutter/material.dart';

void alertUser(String content, BuildContext context, {int seconds = 5}) {
  Future<void>.microtask(() {
    final SnackBar snackBar = SnackBar(
      content: Text(content),
      duration: Duration(seconds: seconds),
    );
    ScaffoldMessenger.of(context).removeCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  });
}

void intentGoogleMaps(double latitude, double longitude, BuildContext context) {
  if (Platform.isAndroid) {
    final intent = AndroidIntent(
      action: 'action_view',
      data: Uri.encodeFull('google.navigation:q=$latitude,$longitude'),
      package: 'com.google.android.apps.maps',
    );
    intent.launch();
  } else {
    alertUser(
      'Google Maps is not available on this device.',
      context,
    );
  }
}

void intentCallPhoneNumber(String phoneNumber) {
  final AndroidIntent intent = AndroidIntent(
    action: 'action_view',
    data: Uri.encodeFull('tel:$phoneNumber'),
    flags: <int>[Flag.FLAG_ACTIVITY_NEW_TASK],
  );
  intent.launch();
}
