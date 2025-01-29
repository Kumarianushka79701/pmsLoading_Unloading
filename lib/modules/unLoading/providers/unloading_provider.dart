import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';

// class UnloadingProvider with ChangeNotifier {
//   String vehicleType = 'Select Vehicle Type';
//   String trainNumber = '';
//   bool showGuidance = false;

//   void updateVehicleType(String type) {
//     vehicleType = type;
//     notifyListeners();
//   }

//   void updateTrainNumber(String number) {
//     trainNumber = number;
//     notifyListeners();
//   }

//   void toggleShowGuidance() {
//     showGuidance = !showGuidance;
//     notifyListeners();
//   }
// }
class UnloadingSummaryProvider extends ChangeNotifier {
  String? _selectedVehicleType;
  bool _showGuidance = false;
  DateTime? _actualLoadDate;

  String? get selectedVehicleType => _selectedVehicleType;
  bool get showGuidance => _showGuidance;
  DateTime? get actualLoadDate => _actualLoadDate;

  void setVehicleType(String? type) {
    _selectedVehicleType = type;
    notifyListeners();
  }

  void toggleGuidance(bool value) {
    _showGuidance = value;
    notifyListeners();
  }

  void setLoadDate(DateTime date) {
    _actualLoadDate = date;
    notifyListeners();
  }

  
}
