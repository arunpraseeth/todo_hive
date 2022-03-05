import 'package:flutter/material.dart';

class ObscureController with ChangeNotifier {
  bool _obscure = false;
  visibity({required bool obscure}) {
    _obscure = obscure;
    notifyListeners();
  }

  bool get visibityData => _obscure;
}
