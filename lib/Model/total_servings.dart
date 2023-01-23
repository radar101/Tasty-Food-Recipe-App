import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/Model/feed_to_id.dart';
import 'package:food_recipe/Model/recipe.dart';

class TotalServings extends ChangeNotifier{
  FeedToId feedToId = FeedToId();
  int _totalServings = 0;
  TotalServings(){
    // _totalServings = feedToId.getTotalServings()!;
  }


  int getTotalServings() => _totalServings;

  increaseServings()
  {
    _totalServings++;
    notifyListeners();
  }

  decreaseServings()
  {
    _totalServings--;
    notifyListeners();
  }
}