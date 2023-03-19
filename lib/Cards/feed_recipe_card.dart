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
    String shortText(String s){
      s = s.substring(0, 35);
      s = s + '...';
      return s;
    }
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Expanded(
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
              width: 150,
              // height: 150,
            ),
          ),
        ),
        const SizedBox(
          height: 8,
        ),
        SizedBox(
          width: 150,
          height: 50,
          child: Text(
            name.length < 35 ? name : shortText(name),
            style: const TextStyle(
                color: kTextColor, fontSize: 15, fontWeight: FontWeight.w500
            ),
          ),
        ),
      ],
    );
  }
}
