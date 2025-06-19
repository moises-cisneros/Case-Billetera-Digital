import 'package:flutter/material.dart';

class NavigationState extends ChangeNotifier {
  int _selectedIndex = 0;
  bool _showBottomBar = true;

  int get selectedIndex => _selectedIndex;
  bool get showBottomBar => _showBottomBar;

  void setSelectedIndex(int index) {
    _selectedIndex = index;
    notifyListeners();
  }

  void setShowBottomBar(bool show) {
    _showBottomBar = show;
    notifyListeners();
  }
}
