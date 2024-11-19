import 'package:flutter/material.dart';

class TabsProvider extends ChangeNotifier {
  int _selectedIndex = 0;

  int get selectedIndex => _selectedIndex;

  void setTabIndex(int index, int totalTabs) {
    if (index >= 0 && index < totalTabs) { // Validate index
      _selectedIndex = index;
      notifyListeners();
    } else {
      debugPrint('Invalid tab index: $index');
    }
  }
}
