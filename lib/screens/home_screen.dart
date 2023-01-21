import 'package:flutter/material.dart';
import 'package:food_recipe/Model/feed_recipes.dart';
import 'package:food_recipe/cards/feed_recipe_card.dart';
import 'package:food_recipe/constants.dart';
import 'package:provider/provider.dart';

import '../Model/feed_to_id.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    // TODO: implement initState
    var feedProvider = Provider.of<FeedRecipes>(context, listen: false);
    feedProvider.changeData();

    var idRecipeProvider = Provider.of<FeedToId>(context, listen: false);
    idRecipeProvider.getData(8578);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: kAppBackground,
        title: Container(
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30), color: Colors.white12),
          child: TextField(
            controller: TextEditingController(),
            textAlign: TextAlign.start,
            autofocus: false,
            decoration: const InputDecoration(
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: Colors.white12),
              ),
              enabledBorder: UnderlineInputBorder(
                  borderSide: BorderSide(color: Colors.white12)),
              alignLabelWithHint: false,
              prefix: Icon(
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
      body: Consumer<FeedRecipes>(
        builder: (context, data, child) {
          return data
                  .getTotalResults()["Weekly Meal Planning Made Easy"]!
                  .isNotEmpty
              ? ListView(
                  shrinkWrap: false,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 15,
                          ),
                          const Text(
                            'Easy to Cook Menu',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.bold),
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: Color(0xFF1A120B)
                            ),
                            child:  const Padding(
                              padding: EdgeInsets.symmetric(horizontal: 10, vertical:8),
                              child: Text(
                                'Weekly Meal Planning Made Easy 🍴',
                                style: kSubHeading,
                              ),
                            ),
                          ),
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: false,
                                itemCount: data
                                    .getTotalResults()[
                                        "Weekly Meal Planning Made Easy"]!
                                    .length,
                                itemBuilder: (context, index) {
                                  List totalRecipes = data.getTotalResults()[
                                      "Weekly Meal Planning Made Easy"]!;
                                  Map<String, dynamic> tempData =
                                      totalRecipes[index];
                                  return Row(
                                    children: [
                                      FeedRecipeCard(
                                        src: tempData["poster_url"],
                                        name: tempData["title"],
                                        recipeid: tempData["recipe_id"],
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Trending 🔥🔥🔥',
                            style: kSubHeading,
                          ),
                          SizedBox(
                            height: 240,
                            child: ListView.builder(
                                scrollDirection: Axis.horizontal,
                                shrinkWrap: false,
                                itemCount:
                                    data.getTotalResults()["Trending"]!.length,
                                itemBuilder: (context, index) {
                                  List totalRecipes =
                                      data.getTotalResults()["Trending"]!;
                                  Map<String, dynamic> tempData =
                                      totalRecipes[index];
                                  return Row(
                                    children: [
                                      FeedRecipeCard(
                                        src: tempData["poster_url"],
                                        name: tempData["title"],
                                        recipeid: tempData["recipe_id"],
                                      ),
                                      const SizedBox(
                                        width: 15,
                                      )
                                    ],
                                  );
                                }),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          const Text(
                            'Recents ⌛',
                            style: kSubHeading,
                          ),
                          SizedBox(
                              height: 500,
                              width: double.infinity,
                              child: GridView.builder(
                                  itemCount:
                                      data.getTotalResults()["Recents"]!.length,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisCount: 2,
                                          crossAxisSpacing: 30.0,
                                          mainAxisSpacing: 80.0),
                                  itemBuilder: (context, index) {
                                    List totalRecipes =
                                        data.getTotalResults()["Recents"]!;
                                    Map<String, dynamic> tempData =
                                        totalRecipes[index];
                                    return FeedRecipeCard(
                                        src: tempData["poster_url"],
                                        name: tempData["title"],
                                        recipeid: tempData["recipe_id"]);
                                  }))
                        ],
                      ),
                    ),
                  ],
                )
              : const CircularProgressIndicator(
                  color: Colors.white,
                );
        },
      ),
    );
  }
}

// return Row(
//   children: [
//     Column(
//       children: [
//         FeedRecipeCard(
//           src: tempData["poster_url"],
//           name: tempData["title"],
//           recipeid: tempData["recipe_id"],
//         ),
//       ],
//     ),
//     const SizedBox(
//       width: 15,
//     ),
//     Column(
//       children: [
//         FeedRecipeCard(
//           src: tempData2["poster_url"],
//           name: tempData2["title"],
//           recipeid: tempData2["recipe_id"],
//         ),
//       ],
//     )
//   ],
// );
//           src: tempData["poster_url"],
