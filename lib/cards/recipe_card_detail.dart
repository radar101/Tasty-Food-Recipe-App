import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:food_recipe/cards/instruction_card.dart';
import 'package:food_recipe/constants.dart';

import '../services/networking.dart';

class RecipeCard extends StatefulWidget {
  const RecipeCard({Key? key}) : super(key: key);

  @override
  State<RecipeCard> createState() => _RecipeCardState();
}

class _RecipeCardState extends State<RecipeCard> {
  Map<String, String> ingrediendts = {
    "bread flour, plus more dusting": "2 cups",
    "shredded sharp cheddar cheese": "1 cup",
    "jalapeno, seeded and coarsely chopped": "1 1/2",
    "jalapeno sliced into wings": "3/4",
    "koshar salt": "3/4 tablespoon",
    "warm water": "1 1/2 cups",
  };

  String recipeTitle = "The title of the recipe";
  String recipeDescription = 'In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before final copy is available.';



  Future<List> getData() async {
    var url = "https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&q=egg";
    NetworkHelper networkHelper = NetworkHelper(url);
    var recipeData = await networkHelper.getData();
    return recipeData;
    // var recipeName =  recipeData['results'][0]['name'];
    // recipeTitle = recipeName;
    // print(recipeName);
    // recipeDescription = recipeData['results'][0]['description'];
    // print(recipeDescription);
    //
    // for (dynamic recipe in recipeData['results'][0]['instructions']) {
    //   print(recipe['display_text']);
    // }
    //
    // setState(() {
    //
    // });
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
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
          icon: Icon(Icons.arrow_back_outlined),
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
              padding: EdgeInsets.only(left: 15),
              child: Text(
                recipeTitle,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 30,
                  fontWeight: FontWeight.bold,
                ),
                textAlign: TextAlign.left,
              ),
            ),
             Padding(
              padding: EdgeInsets.symmetric(vertical: 8, horizontal: 14),
              child: Text(
                recipeDescription,
                style: const TextStyle(
                  fontSize: 15,
                  color: Colors.grey,
                  overflow: TextOverflow.fade,
                ),
              ),
            ),
            Container(
              child: Column(
                children: [
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Ingredients for',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Container(
                          /*decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            border: Border.symmetric(vertical: BorderSide(width: 1, color: Colors.grey), horizontal: BorderSide(width: 1, color: Colors.grey))
                          ),*/
                          child: Row(
                            children: [
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.remove,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                              const Text(
                                '4',
                                style: TextStyle(color: Colors.white),
                              ),
                              IconButton(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.add,
                                  color: Colors.pinkAccent,
                                ),
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  ),

                  /// Code to display the ingredients of the recipe
                  /*ListView.separated(itemBuilder: (context, index){
                    return Container(
                      child: Text(ingrediendts[index]!, style: TextStyle(color: Colors.white),),
                    );
                  }, separatorBuilder: (BuildContext context, int index) => const Divider(),
                      itemCount: ingrediendts.length
                  )*/
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const Text(
                          'Nutrition Info',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold),
                        ),
                        Row(
                          children: [
                            const Text(
                              'View Info',
                              style: TextStyle(color: Colors.pinkAccent),
                            ),
                            IconButton(
                              onPressed: () {},
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
                ],
              ),
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
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 20),
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
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          ),
                        ),
                      ),
                    ),
                    FutureBuilder<List>(
                      future: getData(),
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          return ListView.builder(
                              itemCount: snapshot.data!.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  height: 75,
                                  color: Colors.white,
                                  child: Center(
                                    child: Text(snapshot.data![index]['results'][index]['name'], style: TextStyle(color: Colors.white),),
                                  ),
                                );
                              });
                        } else if (snapshot.hasError) {
                          return Text(snapshot.error.toString());
                        }
                        // By default show a loading spinner.
                        return const CircularProgressIndicator();
                      },
                    )

                    /*InstructionCard(
                        srNo: '1',
                        instruction:
                            'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.'),
                    InstructionCard(
                        srNo: '1',
                        instruction:
                            'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.'),
                    InstructionCard(
                        srNo: '1',
                        instruction:
                            'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.'),
                    InstructionCard(
                        srNo: '1',
                        instruction:
                            'Lorem ipsum is placeholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.'),
                    InstructionCard(
                        srNo: '1',
                        instruction:
                            'Lorem ipsum is p*//*laceholder text commonly used in the graphic, print, and publishing industries for previewing layouts and visual mockups.'),*/
                  ],
                ),
              ),
            )
          ],
        ),
      ]),
    );
  }
}
