import 'package:flutter/material.dart';

import '../services/networking.dart';

class Recipe extends ChangeNotifier {
  Map<String, List<dynamic>> _totalResults = {};

  Map<String, List<dynamic>> getTotalResults() => _totalResults;

  Future<Map<String, List<dynamic>>> getData(String tag, String q) async {
    Map<String, List<dynamic>> totalFeedMap = {};
    var url =
        "https://tasty.p.rapidapi.com/recipes/list?from=0&size=20&tags=$tag&q=$q";
    NetworkHelper networkHelper = NetworkHelper(url);
    var recipeData = await networkHelper.getData();
    List<Map<String, dynamic>> tagsList = [];
    for(int i=0;i < recipeData['results'].length ; i++){
      if(recipeData['results'][i].length > 50){
        Map<String, dynamic> tempMap = {};
        Map <String , dynamic> recipes = recipeData['results'][i];
        String recipeName = recipes['name'] ?? "";
        String posterUrl = recipes['thumbnail_url'] ?? "";
        int recipeId = recipes['id'] ?? "";
        tempMap["title"] = recipeName;
        tempMap["poster_url"] = posterUrl;
        tempMap["recipe_id"] = recipeId;
        tagsList.add(tempMap);
      }
    }
    totalFeedMap[tag] = tagsList;
    return totalFeedMap;
  }

  changeData(String tag, String q) async {
    Map<String, List<dynamic>> tempMap = await getData(tag,q);
    _totalResults = tempMap;
    notifyListeners();
  }
}
