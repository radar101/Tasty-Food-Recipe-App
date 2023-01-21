import 'package:flutter/material.dart';

import '../services/networking.dart';

class Recipe extends ChangeNotifier {
  String _recipeTitle = '';

  String _recipeDescription = '';

  String _thumbnailUrl = '';

  String _videoUrl = '';

  int _totalServings = 0;

  List _instructions = [];

  Map<String, dynamic> _nutritionData = {};
  Map<int, List<dynamic>> _ingredientData = {};

  String? getTitle() => _recipeTitle;

  String? getDescription() => _recipeDescription;

  String? getThumbnailUrl() => _thumbnailUrl;

  String? getVideoUrl() => _videoUrl;

  int? getTotalServings() => _totalServings;

  List? getInstructions() => _instructions;


  Map<int, List<dynamic>>? getIngredientData() => _ingredientData;
  Map<String, dynamic>? getNutritionData() => _nutritionData;

  Future<Map<String, dynamic>?> getData() async {
    var url =
        "https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&q=bread";
    NetworkHelper networkHelper = NetworkHelper(url);
    var recipeData = await networkHelper.getData();
    List tempRecipes = [];
    Map<int , List<dynamic>> tempIngredients= {};
    print('getdata Called');
    for (int i = 0; i < 200; i++) {
      if (recipeData['results'][i]['id'] == 8578) {
        List recipes = recipeData['results'][i]['instructions'];
        for (int j = 0; j < recipes.length; j++) {
          tempRecipes.add(recipes[j]['display_text']);
        }
        List section = recipeData['results'][i]['sections'][0]['components'];
        for(int j = 0; j<section.length; j++){
          if(section[j]['measurements'].length!=2){
            String ingredient = section[j]['ingredient']['name'] ?? section[j]['ingredient']['display_singular'];
            ingredient+= ', ';
            ingredient += section[j]['extra_comment'];
            String quantity = section[j]['measurements'][0]['quantity'];
            tempIngredients[j] = [ingredient,quantity];
          }else{
            String ingredient = section[j]['ingredient']['name'] ?? section[j]['ingredient']['display_singular'];
            ingredient+= ', ';
            ingredient += section[j]['extra_comment'];
            String quantity = section[j]['measurements'][1]['quantity'];
            String unit = section[j]['measurements'][1]['unit']['name'] ?? section[j]['measurements'][1]['unit']['display_singular'];
            tempIngredients[j] = [ingredient,quantity, unit];
          }
        }

        print(tempIngredients);

        Map<String, dynamic> result = {
          "title": recipeData['results'][i]['name'],
          "description": recipeData['results'][i]['description'],
          "instruction_list": tempRecipes,
          "thumbnail_url": recipeData['results'][i]['thumbnail_url'],
          "video_url": recipeData['results'][i]['original_video_url'],
          "total_servings": recipeData['results'][i]['num_servings'],
          "nutrition_data": recipeData['results'][i]['nutrition'],
          "ingredients" : tempIngredients,
        };
        return result;
      }
    }
  }

  changeData() async {
    Map<String, dynamic>? result = await getData();
    _recipeTitle = result!["title"];
    _recipeDescription = result["description"];
    _instructions = result["instruction_list"];
    _thumbnailUrl = result["thumbnail_url"];
    _videoUrl = result["video_url"];
    _totalServings = result["total_servings"];
    _nutritionData = result["nutrition_data"];
    _ingredientData = result["ingredients"];
    notifyListeners();
  }
}
