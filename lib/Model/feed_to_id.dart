import 'package:flutter/material.dart';
import '../services/networking.dart';

class FeedToId extends ChangeNotifier {
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


  increaseServings()
  {
    int initialServings = _totalServings;
    for(int i=0;i < _ingredientData.length ; i++){
      // double oldQuantity = int.parse(_ingredientData[i]![1].replaceAll(RegExp(r'[^0-9]'),'')).toDouble();
      // double newQuantity = (initialServings.toDouble()+1) / initialServings.toDouble();
      // newQuantity = newQuantity * oldQuantity;
      // newQuantity.toString();
    }
    _totalServings++;
    notifyListeners();
  }

  decreaseServings()
  {
    int initialServings = _totalServings;
    for(int i=0;i < _ingredientData.length ; i++){
      int oldQuantity = int.parse(_ingredientData[i]![1].replaceAll(RegExp(r'\D'),''));
      double newQuantity = (initialServings.toDouble() - 1) / initialServings.toDouble();
      newQuantity = newQuantity * oldQuantity;
      newQuantity.toString();
    }
    _totalServings--;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getData(int id) async {
    var url =
        "https://tasty.p.rapidapi.com/recipes/get-more-info?id=$id";
    NetworkHelper networkHelper = NetworkHelper(url);
    var recipeData = await networkHelper.getData();
    List instructionList = [];
    for (int i = 0; i < recipeData['instructions'].length; i++) {
      instructionList.add(recipeData['instructions'][i]['display_text']);
    }
    Map<int , List<dynamic>> tempIngredients= {};
    List section = recipeData['sections'][0]['components'];
    for(int j = 0; j<section.length; j++){
      if(section[j]['measurements'].length!=2){
        String ingredient = section[j]['ingredient']['name'] ?? section[j]['ingredient']['display_singular'];
        ingredient+= ', ';
        ingredient += section[j]['extra_comment'];
        String quantity = section[j]['measurements'][0]['quantity'];
        String unit = section[j]['measurements'][0]['unit']['name'];
        tempIngredients[j] = [ingredient,quantity, unit];
      }else{
        String ingredient = section[j]['ingredient']['name'] ?? section[j]['ingredient']['display_singular'];
        ingredient+= ', ';
        ingredient += section[j]['extra_comment'];
        String quantity = section[j]['measurements'][0]['unit']['system'] == "imperial" ? section[j]['measurements'][0]['quantity'] : section[j]['measurements'][1]['quantity'];
        String unit = section[j]['measurements'][0]['unit']['system'] == "imperial" ? section[j]['measurements'][0]['unit']['name'] : section[j]['measurements'][1]['unit']['name'];
        tempIngredients[j] = [ingredient,quantity, unit];
      }
    }

    Map<String, dynamic> finalResult = {
      "title": recipeData['name'],
      "description": recipeData['description'],
      "instruction_list": instructionList,
      "thumbnail_url": recipeData['thumbnail_url'],
      "video_url": recipeData['original_video_url'],
      "total_servings": recipeData['num_servings'],
      "nutrition_data": recipeData['nutrition'],
      "ingredients" : tempIngredients,
    };

    return finalResult;
  }

  changeData(int id) async {
    Map<String, dynamic>? result = await getData(id);
    _recipeTitle = result["title"] ?? "";
    _recipeDescription = result["description"] ?? "";
    _instructions = result["instruction_list"] ?? [];
    _thumbnailUrl = result["thumbnail_url"] ?? "";
    _videoUrl = result["video_url"] ?? "";
    _totalServings = result["total_servings"] ?? 0;
    _nutritionData = result["nutrition_data"] ?? {};
    _ingredientData = result["ingredients"] ?? {};
    notifyListeners();
  }
}
