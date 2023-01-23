import 'package:flutter/material.dart';

import '../services/networking.dart';

class FeedRecipes extends ChangeNotifier {
  Map<String, List<dynamic>> totalResults = {};

  Map<String, List<dynamic>> getTotalResults() => totalResults;

  Future<Map<String, List<dynamic>>> getData() async {
    List<Map<String, dynamic>> recentsList = [];
    var url =
        "https://tasty.p.rapidapi.com/feeds/list?size=20&vegetarian=false&timezone=+0530&from=0";
    NetworkHelper networkHelper = NetworkHelper(url);
    var recipeData = await networkHelper.getData();

    Map<String, List<dynamic>> totalFeedMap = {};

    for (int i = 0; i < recipeData['results'].length; i++) {
      if (recipeData['results'][i].length == 5) {
        if (recipeData['results'][i]['name'] ==
            "Weekly Meal Planning Made Easy") {
          List<Map<String, dynamic>> weeklyList = [];

          List recipeList = recipeData['results'][i]['items'];
          for (int j = 0; j < recipeList.length; j++) {
            List particularRecipe = recipeList[j]['recipes'];
            for (int k = 0; k < particularRecipe.length; k++) {
              Map<String, dynamic> tempMap = {};
              String recipeName = particularRecipe[k]['name'];
              String posterUrl = particularRecipe[k]['thumbnail_url'];
              int recipeId = particularRecipe[k]['id'];
              tempMap["title"] = recipeName;
              tempMap["poster_url"] = posterUrl;
              tempMap["recipe_id"] = recipeId;
              weeklyList.add(tempMap);
            }
          }
          totalFeedMap["Weekly Meal Planning Made Easy"] = weeklyList;
        }
        if (recipeData['results'][i]['name'] == "Trending") {
          List<Map<String, dynamic>> weeklyList = [];

          List recipeList = recipeData['results'][i]['items'];
          for (int j = 0; j < recipeList.length; j++) {
            Map<String, dynamic> tempMap = {};
            String recipeName = recipeList[j]['name'];
            String posterUrl = recipeList[j]['thumbnail_url'];
            int recipeId = recipeList[j]['id'];
            tempMap["title"] = recipeName;
            tempMap["poster_url"] = posterUrl;
            tempMap["recipe_id"] = recipeId;
            weeklyList.add(tempMap);
          }
          totalFeedMap["Trending"] = weeklyList;
        }

        if (recipeData['results'][i]['name'] == "Japanese Inspired") {
          List<Map<String, dynamic>> weeklyList = [];

          List recipeList = recipeData['results'][i]['items'];
          for (int j = 0; j < recipeList.length; j++) {
            Map<String, dynamic> tempMap = {};
            String recipeName = recipeList[j]['name'];
            String posterUrl = recipeList[j]['thumbnail_url'];
            int recipeId = recipeList[j]['id'];
            tempMap["title"] = recipeName;
            tempMap["poster_url"] = posterUrl;
            tempMap["recipe_id"] = recipeId;
            weeklyList.add(tempMap);
          }
          totalFeedMap["Japanese Inspired"] = weeklyList;
        }

        if (recipeData['results'][i]['name'] == "Japanese Inspired") {}
      } else if (recipeData['results'][i].length == 2) {
        if (recipeData['results'][i]['item'].length == 52) {
          Map<String, dynamic> tempMap = {};
          String recipeName = recipeData['results'][i]['item']['name'];
          String posterUrl = recipeData['results'][i]['item']['thumbnail_url'];
          int recipeId = recipeData['results'][i]['item']['id'];
          tempMap["title"] = recipeName;
          tempMap["poster_url"] = posterUrl;
          tempMap["recipe_id"] = recipeId;
          recentsList.add(tempMap);
        } else if (recipeData['results'][i]['item'].length == 28) {
          List recipeList = recipeData['results'][i]['item']['recipes'];
          for (int j = 0; j < recipeList.length; j++) {
            Map<String, dynamic> tempMap = {};
            var recipe = recipeData['results'][i]['item']['recipes'][j];
            String recName = recipe['name'];
            String posterUrl = recipe['thumbnail_url'];
            int recipeId = recipe['id'];
            tempMap["title"] = recName;
            tempMap["poster_url"] = posterUrl;
            tempMap["recipe_id"] = recipeId;
            recentsList.add(tempMap);
          }
        }
        print(totalFeedMap["Recents"]);
      }
    }
    totalFeedMap["Recents"] = recentsList;
    return totalFeedMap;
  }

  changeData() async {
    Map<String, List<dynamic>> tempMap = await getData();
    totalResults = tempMap;
    notifyListeners();
  }
}
