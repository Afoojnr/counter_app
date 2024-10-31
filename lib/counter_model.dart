import 'package:flutter/material.dart';

class CounterState extends ChangeNotifier {
  int count = 0;
  bool limit = false;
  int max = 10;

  Color? countColor;

  void increment() {
    limit && count == max ? count : count++;
    notifyListeners();
  }

  void decrement() {
    count > 0 ? count-- : count = 0;
    notifyListeners();
  }

  void refresh() {
    count = 0;
    notifyListeners();
  }

  void setLimit(bool value) {
    limit = value;
    notifyListeners();
  }

  void setMax(int value) {
    value > 0 ? max = value : 0;
    notifyListeners();
  }

  void setCount(int value) {
    limit && count > max ? count = max : count = value;

    // count = value;
    notifyListeners();
  }

  void setCountColor(Color color) {
    countColor = color;
    notifyListeners();
  }
}
