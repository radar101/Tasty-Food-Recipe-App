import 'package:flutter/material.dart';
import 'package:flutter_tts/flutter_tts.dart';
import 'package:translator/translator.dart';
import '../services/networking.dart';

class FeedToId extends ChangeNotifier {
  final FlutterTts flutterTts = FlutterTts();
  GoogleTranslator translator = GoogleTranslator();
  String _recipeTitle = '';

  String _recipeDescription = '';

  String _thumbnailUrl = '';

  String _videoUrl = '';

  int _totalServings = 0;

  List _instructions = [];

  List _ingredients = [];

  List? getIngredients() => _ingredients;
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

  voiceOver() async {
    await flutterTts.setLanguage("en-US");
    await flutterTts.setPitch(1.0);

    for (int i = 0; i < _instructions.length; i++) {
      String str = _instructions[i];
      await flutterTts.speak(str);
      await flutterTts.awaitSpeakCompletion(true);
    }
  }

  isSpeaking() async {
    flutterTts.pause();
    flutterTts.stop();
  }

  translate() async {
    var english = RegExp(r'[a-zA-Z]');
    String language;
    if (english.hasMatch(_ingredientData[0]![0])) {
      language = 'hi';
    } else {
      language = 'en';
    }
    for (int i = 0; i < _ingredientData.length; i++) {
      String ingredient = _ingredientData[i]![0];
      _ingredientData[i]![0] = await translator
          .translate(ingredient, to: language)
          .then((value) => value.text);
      print(_ingredientData[i]![0]);
    }

    for (int i = 0; i < _instructions.length; i++) {
      String instruction = _instructions[i];
      _instructions[i] = await translator
          .translate(instruction, to: language)
          .then((value) => value.text);
      print(_instructions[i]);
    }
    notifyListeners();
  }

  String double_to_fraction(double x, {double error = 0.000000001}){
    int n = x.toInt();
    x-=n;
    if(x<error){
      return n.toString();
    }else if(1-error < x){
      return (n+1).toString();
    }

  //  The lower fraction is 0/1
    int lowerN = 0;
    int lowerD = 1;

  //  The uppper fraction is 1/1
    int upperN = 1;
    int upperD = 1;

    while(true){
    //  The middle fraction is (lower_n + upper_n) / (upper_d + lower_d)
      int middleN = lowerN + upperN;
      int middleD = lowerD + upperD;

    //  if x + error < middle
      if(middleD * (x+error) < middleN){
      //  middle is our new upper
        upperD = middleD;
        upperN = middleN;
      }else if(middleN < (x-error) * middleD){
        lowerD = middleD;
        lowerN = middleN;
      }else{
        String up = (n*middleD+middleN).toString();
        print("The upper is $up");
        String low = (middleD).toString();
        print("The lower is $low");
        return "$up / $low";
      }
    }
  }

  increaseServings() {
    int initialServings = _totalServings;
    for (int i = 0; i < _ingredients.length; i++) {
      try {
        if (_ingredients[i][0] == 'Â') {
          _ingredients[i] = _ingredients[i].substring(1);
        } else {
          double oldQuantity = double.parse(_ingredients[i]).toDouble();
          double newQuantity =
              (initialServings.toDouble() + 1) / initialServings.toDouble();
          newQuantity = newQuantity * oldQuantity;
          _ingredients[i] = double_to_fraction(newQuantity);
        }
      } catch (e) {
        print(e.toString());
      }
    }
    _totalServings++;
    notifyListeners();
  }

  decreaseServings() {
    int initialServings = _totalServings;
    for (int i = 0; i < _ingredients.length; i++) {
      try {
        if (_ingredients[i][0] == 'Â') {
          _ingredients[i] = _ingredients[i].substring(1);
        } else {
          print(_ingredients[i].toString());
          double oldQuantity = double.parse(_ingredients[i]).toDouble();
          print("The old quantity $oldQuantity");
          double newQuantity =
              (initialServings.toDouble() - 1) / initialServings.toDouble();
          print("The new quantity $newQuantity");
          newQuantity = newQuantity * oldQuantity;
          print("The updated new quantity $newQuantity");
          _ingredients[i] = newQuantity.toString();
        }
      } catch (e) {
        print(e.toString());
      }
    }
    _totalServings--;
    notifyListeners();
  }

  Future<Map<String, dynamic>> getData(int id) async {
    var url = "https://tasty.p.rapidapi.com/recipes/get-more-info?id=$id";
    NetworkHelper networkHelper = NetworkHelper(url);
    var recipeData = await networkHelper.getData();
    List instructionList = [];
    for (int i = 0; i < recipeData['instructions'].length; i++) {
      instructionList.add(recipeData['instructions'][i]['display_text']);
    }
    Map<int, List<dynamic>> tempIngredients = {};
    List section = recipeData['sections'][0]['components'];
    for (int j = 0; j < section.length; j++) {
      if (section[j]['measurements'].length != 2) {
        String ingredient = section[j]['ingredient']['name'] ??
            section[j]['ingredient']['display_singular'];
        ingredient += ', ';
        ingredient += section[j]['extra_comment'];
        String quantity = section[j]['measurements'][0]['quantity'];
        String unit = section[j]['measurements'][0]['unit']['name'];
        tempIngredients[j] = [ingredient, quantity, unit];
        _ingredients.add(quantity);
      } else {
        String ingredient = section[j]['ingredient']['name'] ??
            section[j]['ingredient']['display_singular'];
        ingredient += ', ';
        ingredient += section[j]['extra_comment'];
        String quantity =
            section[j]['measurements'][0]['unit']['system'] == "imperial"
                ? section[j]['measurements'][0]['quantity']
                : section[j]['measurements'][1]['quantity'];
        String unit =
            section[j]['measurements'][0]['unit']['system'] == "imperial"
                ? section[j]['measurements'][0]['unit']['name']
                : section[j]['measurements'][1]['unit']['name'];
        tempIngredients[j] = [ingredient, quantity, unit];
        _ingredients.add(quantity);
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
      "ingredients": tempIngredients,
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
