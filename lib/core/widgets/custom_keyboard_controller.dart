import 'package:flutter/material.dart';

enum CustomKeyboardMode { numeric, reps }

class CustomKeyboardController extends ChangeNotifier {
  CustomKeyboardController._();
  static final CustomKeyboardController instance = CustomKeyboardController._();

  TextEditingController? _activeController;
  CustomKeyboardMode _mode = CustomKeyboardMode.numeric;
  CustomKeyboardMode get mode => _mode;
  TextEditingController? get activeController => _activeController;
    static const double keyboardHeight = 180;


  bool get isVisible => _activeController != null;



  void open(
    TextEditingController controller, {
    CustomKeyboardMode mode = CustomKeyboardMode.numeric,
  }) {
    if (_activeController == controller && _mode == mode) return;
    _activeController = controller;
    _mode = mode;
    notifyListeners();
  }

  void close() {
    if (_activeController == null) return;
    _activeController = null;
    _mode = CustomKeyboardMode.numeric;
    notifyListeners();
  }
}