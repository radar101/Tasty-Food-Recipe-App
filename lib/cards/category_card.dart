import 'package:flutter/material.dart';
import 'package:food_recipe/Model/feed_to_id.dart';
import 'package:food_recipe/Model/recipe.dart';
import 'package:food_recipe/screens/search_result.dart';
import 'package:group_button/group_button.dart';
import 'package:provider/provider.dart';

import '../constants.dart';

class CategoryCard extends StatelessWidget {
  const CategoryCard(
      {Key? key, required this.categoryName, required this.listName})
      : super(key: key);
  final String categoryName;
  final List<String> listName;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const SizedBox(
          height: 20,
        ),
        Text(
          categoryName,
          style: kSubHeading,
        ),
        const SizedBox(
          height: 10,
        ),
        GroupButton(
          onSelected: (String str, int index, bool isSelected) {
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) => MultiProvider(
                  providers: [
                    ChangeNotifierProvider(create: (_) => Recipe()),
                    ChangeNotifierProvider(create: (_) => FeedToId())
                  ],
                  child: SearchResult(
                    tag: listName[index],
                    q: '',
                  ),
                ),
              ),
            );
          },
          enableDeselect: true,
          isRadio: true,
          buttons: listName,
          options: GroupButtonOptions(
              spacing: 5,
              runSpacing: 5,
              elevation: 7,
              unselectedShadow: [],
              borderRadius: BorderRadius.circular(30),
              unselectedColor: kButtonColor,
              unselectedTextStyle: const TextStyle(color: kTextColor, fontSize: 15)),
        ),
      ],
    );
  }
}
