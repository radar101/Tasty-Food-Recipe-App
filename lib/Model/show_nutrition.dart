import 'package:flutter/foundation.dart';

class ShowNutrition extends ChangeNotifier{
  bool _toShow = false;
  bool getShow() => _toShow;
  bool _isActive = false;
  bool getActive() => _isActive;

  onPress()
  {
    _toShow = !_toShow;
    notifyListeners();
  }

  onTapped()
  {
    _isActive = !_isActive;
    notifyListeners();
  }
}