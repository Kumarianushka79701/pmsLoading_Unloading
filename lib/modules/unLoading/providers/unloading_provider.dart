import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class UnloadingProvider with ChangeNotifier {
  String vehicleType = 'Select Vehicle Type';
  String trainNumber = '';
  bool showGuidance = false;

  void updateVehicleType(String type) {
    vehicleType = type;
    notifyListeners();
  }

  void updateTrainNumber(String number) {
    trainNumber = number;
    notifyListeners();
  }

  void toggleShowGuidance() {
    showGuidance = !showGuidance;
    notifyListeners();
  }
}
