import 'package:flutter/material.dart';
import 'package:food_recipe/screens/home_screen.dart';
import 'package:food_recipe/constants.dart';
import 'package:provider/provider.dart';

import '../Model/feed_recipes.dart';
import '../Model/feed_to_id.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {

  @override
  Widget build(BuildContext context) {
    return Container(
      color: const Color(0xFFF4eee8),
      child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Container(
              decoration: BoxDecoration(
                color: kAppBackground,
              ),
              child: Image.asset("images/Cook Like a Chef.png"),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 20),
              child: TextButton(
                onPressed: () {
                  Navigator.of(context).pushReplacement(
                    MaterialPageRoute(
                      builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(create: (_) => FeedRecipes()),
                          ChangeNotifierProvider(create: (_) => FeedToId())
                        ],
                          child: const HomeScreen()),
                    ),
                  );
                },
                style: ButtonStyle(
                  backgroundColor: MaterialStatePropertyAll(kButtonColor),
                  shape: MaterialStatePropertyAll(
                    RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                  ),
                ),
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 30, vertical: 12),
                  child: Text(
                    'Get Started',
                    style: kSubHeading,
                  ),
                ),
              ),
            ),
          ]),
    );
  }
}
