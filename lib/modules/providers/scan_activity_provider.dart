import 'package:flutter/material.dart';
import 'package:project/model/parcel.dart';
import 'package:project/model/scan_state.dart';

class ScanActivityProvider extends ChangeNotifier {
  DataStatus _status = DataStatus.initial;
  DataStatus get status => _status;

  ParcelData? _scannedData;
  ParcelData? get scannedData => _scannedData;

  void processScannedData(String rawData) {
    _status = DataStatus.loading;
    notifyListeners();

    try {
      // Parse raw data into `ParcelData` object
      _scannedData = parseQRData(rawData);
      _status = DataStatus.success;
    } catch (e) {
      _status = DataStatus.error;
    }
    notifyListeners();
  }

  ParcelData? parseQRData(String qrCode) {
    if (qrCode.isEmpty) {
      return null;
    }
    // Simulate parsing logic (adjust based on actual QR code format)
    return ParcelData(
      weightOfConsignment: '25kg',
      prrNumber: qrCode, // Use QR code as PRR number
      totalPackages: '10',
      currentPackageNumber: '1',
      destinationStationCode: 'ABC',
      sourceStationCode: 'XYZ',
      totalWeight: '250kg',
      commodityTypeCode: 'Food',
      bookingDate: DateTime.now().toString(),
      chargeableWeightForCurrentPackage: '25kg',
      totalChargeableWeight: '250kg',
      packagingDescriptionCode: 'Standard',
      trainScaleCode: 'Express',
      rajdhaniFlag: 'No',
      estimatedUnloadingTime: '2 Hours',
      transhipmentStation: 'None',
    );
  }

  void setErrorState(String errorMessage) {
    _status = DataStatus.error;
    notifyListeners();
  }

  void resetScanner() {
    _status = DataStatus.initial;
    _scannedData = null;
    notifyListeners();
  }
}
