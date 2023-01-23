import 'package:flutter/material.dart';

import '../services/networking.dart';

class Search extends ChangeNotifier{
  List<String> _recipeNames = [];
  List<String> getRecipeNames() => _recipeNames;

  Future<List<String>> getData(String prefix) async {
    List<String> resultList = [];
    var url =
        "https://tasty.p.rapidapi.com/recipes/auto-complete?prefix=$prefix";
    NetworkHelper networkHelper = NetworkHelper(url);
    var recipeData = await networkHelper.getData();
    List recipes = recipeData['results'];
    for(int i=0;i<recipes.length;i++){
        String name = recipes[i]['search_values'] ?? recipes[i]['display'];
        resultList.add(name);
    }
    print(resultList);
    return resultList;
  }

  changeData(String prefix)
  async {
    List<String> result = await getData(prefix);
    _recipeNames = result;
    notifyListeners();
  }
}