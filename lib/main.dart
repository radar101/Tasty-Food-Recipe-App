import 'package:flutter/material.dart';
import 'package:food_recipe/cards/recipe_card_detail.dart';
import 'package:food_recipe/constants.dart';
import 'package:food_recipe/screens/home_screen.dart';
import 'package:food_recipe/screens/start_screen.dart';

void main() {
  runApp(const MyApp());
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
      home : const RecipeCard()
    );
  }
}
