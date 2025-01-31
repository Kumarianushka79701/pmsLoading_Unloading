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
  bool _showGuidance = false;
  String? _trainNo;
  String? selectedVehicleType;

  DateTime? _actualLoadDate;

  bool get showGuidance => _showGuidance;
  DateTime? get actualLoadDate => _actualLoadDate;
  String? get trainNo => _trainNo;

  void toggleGuidance(bool value) {
    _showGuidance = value;
    notifyListeners();
  }

  void setLoadDate(DateTime date) {
    _actualLoadDate = date;
    notifyListeners();
  }

  void setTrainNo(String? trainNo) {
    _trainNo = trainNo;
    notifyListeners();
  }

  void setVehicleType(String? type) {
    if (selectedVehicleType != type) {
      selectedVehicleType = type;
      notifyListeners(); // Notify only when there's a change
    }
  }
}
