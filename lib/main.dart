import 'package:flutter/material.dart';
import 'package:shop_app/screens/splash/splash_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'routes.dart';
import 'screens/init_screen.dart';
import 'theme.dart';

late SharedPreferences sharedPref;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sharedPref = await SharedPreferences.getInstance();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'TOP GALLERY',
      theme: AppTheme.lightTheme(context),
      initialRoute: sharedPref.getString("CUSTOMERID") == null
          ? SplashScreen.routeName
          : InitScreen.routeName,
      // InitScreen.routeName
      // SplashScreen.routeName
      routes: routes,
    );
  }
}
