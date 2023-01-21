import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:food_recipe/Model/recipe.dart';

class TotalServings extends ChangeNotifier{
  Recipe recipe = Recipe();
  int _totalServings = 0;
  TotalServings() {
    _totalServings =  recipe.getTotalServings()!;
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