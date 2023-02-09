import 'package:flutter/material.dart';

class HomeScreenViewModel extends ChangeNotifier {
  bool radioButtonGroupValue = false;

  void changeRadioButtonGroupValue(bool value) {
    radioButtonGroupValue = value;
    notifyListeners();
  }
}