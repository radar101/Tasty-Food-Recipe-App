import 'package:flutter/material.dart';
import 'package:food_recipe/Model/recipe.dart';
import 'package:food_recipe/constants.dart';
import 'package:provider/provider.dart';
import '../cards/feed_recipe_card.dart';

class SearchResult extends StatefulWidget {
  const SearchResult({Key? key, required this.tag , required this.q}) : super(key: key);
  final String tag;
  final String q;
  @override
  State<SearchResult> createState() => _SearchResultState();
}

class _SearchResultState extends State<SearchResult> {
  @override
  void initState() {
    // TODO: implement initState
    var feedProvider = Provider.of<Recipe>(context, listen: false);
    feedProvider.changeData(widget.tag, widget.q);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
       appBar: AppBar(
         backgroundColor: kAppBackground,
         title: Text(widget.tag.isEmpty ? widget.q : widget.tag),
       ),
      body: Consumer<Recipe>(
        builder: (context, data, child){
          return SingleChildScrollView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
                children: [
                  SizedBox(
                    height: 800,
                      width: double.infinity,
                      child: GridView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                          itemCount:
                          data.getTotalResults()[widget.tag]!.length,
                          gridDelegate:
                          const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 10.0,
                              mainAxisSpacing: 20.0),
                          itemBuilder: (context, index) {
                            List totalRecipes =
                            data.getTotalResults()[widget.tag]!;
                            Map<String, dynamic> tempData =
                            totalRecipes[index];
                            return FeedRecipeCard(
                                src: tempData["poster_url"],
                                name: tempData["title"],
                                recipeid: tempData["recipe_id"]);
                          })),
                ],
              ),
          );
        },
      ),
    );
  }
}
