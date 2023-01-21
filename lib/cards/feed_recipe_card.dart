import 'package:flutter/material.dart';
import 'package:food_recipe/Model/feed_to_id.dart';
import 'package:food_recipe/cards/recipe_card_detail.dart';
import 'package:provider/provider.dart';

import '../Model/show_nutrition.dart';
import '../Model/total_servings.dart';

class FeedRecipeCard extends StatelessWidget {
  const FeedRecipeCard(
      {Key? key, required this.src, required this.name, required this.recipeid})
      : super(key: key);
  final String src;
  final String name;
  final int recipeid;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: 160,
          width: 150,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(
                              create: (_) => TotalServings()),
                          // ChangeNotifierProvider(create: (_) => Recipe()),
                          ChangeNotifierProvider(create: (_) => FeedToId()),
                          ChangeNotifierProvider(
                              create: (_) => ShowNutrition()),
                        ],
                        child: RecipeCard(id: recipeid),
                      )));
            },
            child: Container(
              decoration:
                  BoxDecoration(borderRadius: BorderRadius.circular(50)),
              child: Image.network(
                src,
                fit: BoxFit.fill,
              ),
            ),
          ),
        ),
        const SizedBox(
          height: 15,
        ),
        SizedBox(
          width: 150,
          child: Text(
            name,
            style: const TextStyle(
                color: Colors.white, fontSize: 17, fontWeight: FontWeight.w500
            ),
          ),
        ),
      ],
    );
  }
}
