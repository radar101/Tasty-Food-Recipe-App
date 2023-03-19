import 'package:flutter/material.dart';
import 'package:food_recipe/Model/show_nutrition.dart';
import 'package:food_recipe/cards/category_card.dart';
import 'package:food_recipe/screens/search_result.dart';
import 'package:provider/provider.dart';
import '../Model/feed_to_id.dart';
import '../Model/recipe.dart';
import '../Model/search_recipes.dart';
import '../constants.dart';

class SearchScreen extends StatelessWidget {
  const SearchScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBackground,
        title: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: Colors.white12,
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 14),
            child: TextField(
              style: const TextStyle(
                color: Colors.white
              ),
              onTap: (){
                var isActive = Provider.of<ShowNutrition>(context, listen: false);
                isActive.onTapped();
              },
              onChanged: (String prefix){
                var result = Provider.of<Search>(context, listen: false);
                result.changeData(prefix);
              },
              controller: TextEditingController(),
              textAlign: TextAlign.left,
              autofocus: false,
              decoration: const InputDecoration(
                focusedBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white12),
                ),
                enabledBorder: UnderlineInputBorder(
                    borderSide: BorderSide(color: Colors.white12)),
                alignLabelWithHint: false,
                icon: Icon(
                  Icons.search,
                  color: Colors.white,
                ),
                hintText: "  Search for recipes",
                hintStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Consumer2<Search, ShowNutrition>(
            builder: (context, search, showNutrition, child){
              return showNutrition.getActive() ? ListView.builder(
                itemCount: search.getRecipeNames().length,
                  shrinkWrap: true,
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index){
                return InkWell(
                  onTap: (){
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => MultiProvider(
                          providers: [
                            ChangeNotifierProvider(create: (_) => Recipe()),
                            ChangeNotifierProvider(create: (_) => FeedToId())
                          ],
                          child: SearchResult(
                            tag: '',
                            q: search.getRecipeNames()[index],
                          ),
                        ),
                      ),
                    );
                  },
                  child: ListTile(
                    title: Text(search.getRecipeNames()[index], style: const TextStyle(color: Colors.white),),
                  ),
                );
              }) : Column(
                children: const [
                  CategoryCard(categoryName: 'Difficulty', listName: kDifficulty),
                  CategoryCard(categoryName: 'Meal', listName: kMeal),
                  CategoryCard(categoryName: 'Occasion', listName: kOccasion),
                  CategoryCard(categoryName: 'Diet', listName: kDiet),
                  CategoryCard(categoryName: 'Cuisine', listName: kCuisine),
                  CategoryCard(categoryName: 'Cooking Style', listName: kCookingStyle),
                ],
              );
            }
          ),
        ),
      ),
    );
  }
}

// ListView.builder(
//   scrollDirection: Axis.vertical,
//   shrinkWrap: true,
//   itemCount: kDifficulty.length,
//     itemBuilder: (BuildContext context, int index){
//   return Padding(
//     padding: const EdgeInsets.all(8.0),
//     child: PinkTextButton(category: kDifficulty[index]),
//   );
// }),