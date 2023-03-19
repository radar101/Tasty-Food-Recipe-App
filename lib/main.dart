import 'dart:io';

import 'package:flutter/material.dart';
import 'package:food_recipe/Screens/testing.dart';
import 'package:food_recipe/constants.dart';
import 'package:food_recipe/screens/start_screen.dart';
void main() {
  HttpOverrides.global = new MyHttpOverrides();
  runApp(const MyApp());
}

class MyHttpOverrides extends HttpOverrides{
  @override
  HttpClient createHttpClient(SecurityContext? context){
    return super.createHttpClient(context)
      ..badCertificateCallback = (X509Certificate cert, String host, int port)=> true;
  }
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Food Recipe and Order Grocery',
      theme: ThemeData(
        scaffoldBackgroundColor: kAppBackground,
      ),
      home : const StartScreen(),

          /// These are the providers for the RecipeCard
          // ChangeNotifierProvider(create: (_) => TotalServings()),
          // ChangeNotifierProvider(create: (_) => Recipe()),
          // ChangeNotifierProvider(create: (_) => ShowNutrition()),

          /// These are the providers for the FeedCard & HomeScreen
          // ChangeNotifierProvider(create: (_) => FeedRecipes()),
          // ChangeNotifierProvider(create: (_) => FeedToId())


      );
  }
}
