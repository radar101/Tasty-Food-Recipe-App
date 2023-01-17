import 'package:flutter/material.dart';

class Recipe{
  final String recipeName;
  final String recipeDescription;
  final List instructions;
  final List ingredients;

  Recipe({
    required this.recipeName,
    required this.recipeDescription,
    required this.ingredients,
    required this.instructions
});

  factory Recipe.from
}