import 'package:blue_devil_dining_app/constants.dart';
import 'package:blue_devil_dining_app/routes.dart';
import 'package:blue_devil_dining_app/themes.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> _runPreRenderOperations() async {
  WidgetsFlutterBinding.ensureInitialized();
  await SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersive);
}

final MaterialApp materialApp = MaterialApp(
  debugShowCheckedModeBanner: false,
  title: appName,
  theme: appTheme,
  darkTheme: appTheme,
  color: backgroundColor,
  initialRoute: PageNames.SPLASH_PAGE.name,
  routes: appRoutes,
);

void main() async {
  await _runPreRenderOperations();
  runApp(materialApp);
}
