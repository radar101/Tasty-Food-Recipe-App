import 'package:flutter/foundation.dart';

class ShowNutrition extends ChangeNotifier{
  bool _toShow = false;
  bool getShow() => _toShow;

  onPress()
  {
    _toShow = !_toShow;
    notifyListeners();
  }
}