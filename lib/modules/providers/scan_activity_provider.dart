import 'package:flutter/material.dart';
import 'package:project/model/scan_state.dart';

class ScanActivityProvider extends ChangeNotifier {
  // Example state
  DataStatus _status = DataStatus.initial;
  DataStatus get status => _status;

  void scanQR() {
    _status = DataStatus.loading;
    notifyListeners();
    // Simulate scanning
    Future.delayed(Duration(seconds: 2), () {
      _status = DataStatus.success;
      notifyListeners();
    });
  }

  void addParcelDataToTable() {
    // Logic to add parcel data
    notifyListeners();
  }


  
}

// enum DataStatus { initial, loading, success, error }
