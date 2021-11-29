import 'package:flutter/material.dart';

class History with ChangeNotifier{
  List _history = []; 
  List get history => _history;
  void updatelist (List history) {
    _history = history;
    notifyListeners();
  }
}