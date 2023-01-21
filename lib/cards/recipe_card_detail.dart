import 'package:flutter/material.dart';
import 'package:food_recipe/Model/feed_to_id.dart';
import 'package:food_recipe/Model/show_nutrition.dart';
import 'package:food_recipe/Model/total_servings.dart';
import 'package:food_recipe/cards/instruction_card.dart';
import 'package:food_recipe/constants.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';


class RecipeCard extends StatefulWidget {
  const RecipeCard({Key? key, required this.id}) : super(key: key);
  final int id;

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  @override
  void initState() {
    // var recipeProvider = Provider.of<Recipe>(context, listen: false);
    // recipeProvider.changeData();
    FeedToId feedToId = FeedToId();
    feedToId.getData(widget.id);
    var recipeProvider = Provider.of<FeedToId>(context, listen: false);
    recipeProvider.changeData(widget.id);
    TotalServings servings = TotalServings();
    print("no of servings are: ${servings.getTotalServings()}");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<String> nutritionType = [
      'carbohydrates',
      'fiber',
      'protein',
      'fat',
      'calories'
    ];

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.share,
              color: Colors.pinkAccent,
            ),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(
              Icons.favorite_outline,
              color: Colors.pinkAccent,
            ),
          ),
        ],
        iconTheme: const IconThemeData(
          color: Colors.pinkAccent,
        ),
        leading: IconButton(
          onPressed: () => Navigator.of(context).pop(),
          icon: const Icon(Icons.arrow_back_outlined),
        ),
        centerTitle: true,
        backgroundColor: kAppBackground,
      ),
      body: ListView(shrinkWrap: false, children: [
        Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 15),
              child: Consumer<FeedToId>(builder: (context, data, child) {
                return Text(
                  data.getTitle()!,
                  style: kLargeHeading,
                  textAlign: TextAlign.left,
                );
              }),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              child: Consumer<FeedToId>(builder: (context, data, child) {
                return Text(
                  data.getDescription()!,
                  style: kDescriptionText,
                );
              }),
            ),
            Consumer<FeedToId>(
              builder: (context, data, child) {
                return Stack(
                  children: [
                    SizedBox(
                        width: double.infinity,
                        height: 350,
                        child: Image.network(data.getThumbnailUrl()!)),
                    Positioned(
                      left: 150,
                      top: 150,
                      child: TextButton(
                        onPressed: () async {
                          String url = data.getVideoUrl()!;
                          final uri = Uri.parse(url);
                          if (await canLaunchUrl(uri)) {
                            await launchUrl(uri);
                          } else {
                            throw 'Could not launch $url';
                          }
                        },
                        style: ButtonStyle(
                          backgroundColor: MaterialStatePropertyAll(
                              Colors.pinkAccent.shade200.withOpacity(0.5)),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(90),
                            ),
                          ),
                        ),
                        child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 12, vertical: 12),
                            child: Icon(
                              Icons.play_arrow_outlined,
                              color: Colors.white,
                            )),
                      ),
                    ),
                  ],
                );
              },
            ),
            Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Ingredients for',
                        style: kSubHeading,
                      ),
                      Row(
                        children: [
                          IconButton(
                            onPressed: () {
                              var servingInfo = Provider.of<TotalServings>(
                                  context,
                                  listen: false);
                              servingInfo.decreaseServings();
                            },
                            icon: const Icon(
                              Icons.remove,
                              color: Colors.pinkAccent,
                            ),
                          ),
                          Consumer<TotalServings>(
                            builder: (context, totalServings, child) {
                              return Text(
                                totalServings.getTotalServings().toString(),
                                style: const TextStyle(color: Colors.white),
                              );
                            },
                          ),
                          IconButton(
                            onPressed: () {
                              var servingInfo = Provider.of<TotalServings>(
                                  context,
                                  listen: false);
                              servingInfo.increaseServings();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.pinkAccent,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),

                /// Code to display the ingredients of the recipe
                Consumer<FeedToId>(builder: (context, list, child) {
                  return ListView.builder(
                      scrollDirection: Axis.vertical,
                      shrinkWrap: true,
                      itemCount: list.getIngredientData()!.length,
                      itemBuilder: (BuildContext context, int index) {
                        return Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                list.getIngredientData()![index]![0],
                                style: const TextStyle(color: Colors.white),
                              ),
                              Text(
                                list.getIngredientData()![index]!.length == 3
                                    ? "${list.getIngredientData()![index]![1]}  ${list.getIngredientData()![index]![2]}"
                                    : "${list.getIngredientData()![index]![1]}",
                                style: const TextStyle(color: Colors.white),
                              ),
                            ],
                          ),
                        );
                      });
                }),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Nutrition Info',
                        style: kSubHeading,
                      ),
                      Row(
                        children: [
                          Consumer<ShowNutrition>(
                              builder: (context, nutrition, child) {
                            return Text(
                              nutrition.getShow() ? 'Hide Info' : 'View Info',
                              style: const TextStyle(color: Colors.pinkAccent),
                            );
                          }),
                          IconButton(
                            onPressed: () {
                              var showNutrition = Provider.of<ShowNutrition>(
                                  context,
                                  listen: false);
                              showNutrition.onPress();
                            },
                            icon: const Icon(
                              Icons.add,
                              color: Colors.pinkAccent,
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                Consumer2<FeedToId, ShowNutrition>(
                    builder: (context, list, show, child) {
                  return show.getShow()
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: nutritionType.length,
                          itemBuilder: (BuildContext context, int index) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 10),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    nutritionType[index].toUpperCase(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                  Text(
                                    list
                                        .getNutritionData()![
                                            nutritionType[index]]
                                        .toString(),
                                    style: const TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            );
                          })
                      : const SizedBox(
                          height: 0,
                        );
                })
              ],
            ),
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white12),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Preparation',
                      style: kSubHeading,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 12),
                      child: TextButton(
                        onPressed: () {},
                        style: ButtonStyle(
                          backgroundColor:
                              MaterialStatePropertyAll(kButtonColor),
                          shape: MaterialStatePropertyAll(
                            RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                          ),
                        ),
                        child: const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Text(
                            'Step by Step mode',
                            style: kSubHeading,
                          ),
                        ),
                      ),
                    ),
                    Consumer<FeedToId>(builder: (context, list, child) {
                      return ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: list.getInstructions()!.length,
                          itemBuilder: (BuildContext context, int index) {
                            return SizedBox(
                              height: 75,
                              // color: kAppBackground,

                              child: Center(
                                child: InstructionCard(
                                  srNo: (index + 1).toString(),
                                  instruction: list.getInstructions()![index],
                                ),
                              ),
                            );
                          });
                    })
                  ],
                ),
              ),
            ),
          ],
        ),
      ]),
    );
  }
}
