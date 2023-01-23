import 'package:flutter/material.dart';
import 'package:food_recipe/Model/feed_to_id.dart';
import 'package:food_recipe/cards/recipe_card_detail.dart';
import 'package:food_recipe/constants.dart';
import 'package:provider/provider.dart';
import '../Model/show_nutrition.dart';

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
      children: [
        SizedBox(
          height: 150,
          width: 150,
          child: InkWell(
            onTap: () {
              Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) => MultiProvider(
                        providers: [
                          ChangeNotifierProvider(create: (_) => FeedToId()),
                          ChangeNotifierProvider(
                              create: (_) => ShowNutrition()),
                        ],
                        child: RecipeCard(id: recipeid),
                      )));
            },
            child: Image.network(
              src,
              fit: BoxFit.fill,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 150,
          height: 70,
          // decoration: BoxDecoration(
          //   borderRadius: BorderRadius.circular(15),
          //   color: kContainerColor
          // ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Text(
              name,
              style: const TextStyle(
                  color: kTextColor, fontSize: 17, fontWeight: FontWeight.w500
              ),
            ),
          ),
        ),
      ],
    );
  }
}
