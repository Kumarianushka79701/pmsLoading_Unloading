import 'package:flutter/material.dart';
import 'package:project/model/parcel.dart';

class ParcelProvider extends ChangeNotifier {
  ParcelData _parcelData = ParcelData(
    weightOfConsignment: null,
    prrNumber: null,
    totalPackages: null,
    currentPackageNumber: null,
    destinationStationCode: null,
    sourceStationCode: null,
    totalWeight: null,
    commodityTypeCode: null,
    bookingDate: null,
    chargeableWeightForCurrentPackage: null,
    totalChargeableWeight: null,
    packagingDescriptionCode: null,
    trainScaleCode: null,
    rajdhaniFlag: null,
    estimatedUnloadingTime: null,
    transhipmentStation: null,
  );

  ParcelData get parcelData => _parcelData;

  ParcelData readableParcelData(String qrString) {
    _parcelData = ParcelData(
      weightOfConsignment: '${_safeSubstring(qrString, 0, 6)} grams',
      prrNumber: _safeSubstring(qrString, 6, 16),
      totalPackages: _safeSubstring(qrString, 16, 20),
      currentPackageNumber: _safeSubstring(qrString, 20, 24),
      destinationStationCode: _getStringFromAscii(_safeSubstring(qrString, 24, 32)),
      sourceStationCode: _getStringFromAscii(_safeSubstring(qrString, 32, 40)),
      totalWeight: '${_safeSubstring(qrString, 40, 45)} KG',
      commodityTypeCode: _safeSubstring(qrString, 45, 46),
      bookingDate: _convertToReadableDateTime(_safeSubstring(qrString, 46, 58)),
      chargeableWeightForCurrentPackage: _safeSubstring(qrString, 58, 63),
      totalChargeableWeight: '${_safeSubstring(qrString, 63, 68)} KG',
      packagingDescriptionCode: _safeSubstring(qrString, 68, 70),
      trainScaleCode: _safeSubstring(qrString, 70, 71),
      rajdhaniFlag: _safeSubstring(qrString, 71, 72) == '1' ? 'true' : 'false',
      estimatedUnloadingTime: int.parse(_safeSubstring(qrString, 72, 74) ?? '0') > 1
          ? '${_safeSubstring(qrString, 72, 74)} hours'
          : '${_safeSubstring(qrString, 72, 74)} hour',
      transhipmentStation: _getStringFromAscii(_safeSubstring(qrString, 74, 82)),
    );
    notifyListeners();
    return _parcelData;
  }

  ParcelData unReadableParcelData(String qrString) {
    _parcelData = ParcelData(
      weightOfConsignment: _originalSubstring(qrString, 0, 6),
      prrNumber: _originalSubstring(qrString, 6, 16),
      totalPackages: _originalSubstring(qrString, 16, 20),
      currentPackageNumber: _originalSubstring(qrString, 20, 24),
      destinationStationCode: _originalSubstring(qrString, 24, 32),
      sourceStationCode: _originalSubstring(qrString, 32, 40),
      totalWeight: _originalSubstring(qrString, 40, 45),
      commodityTypeCode: _originalSubstring(qrString, 45, 46),
      bookingDate: _originalSubstring(qrString, 46, 58),
      chargeableWeightForCurrentPackage: _originalSubstring(qrString, 58, 63),
      totalChargeableWeight: _originalSubstring(qrString, 63, 68),
      packagingDescriptionCode: _originalSubstring(qrString, 68, 70),
      trainScaleCode: _originalSubstring(qrString, 70, 71),
      rajdhaniFlag: _originalSubstring(qrString, 71, 72),
      estimatedUnloadingTime: _originalSubstring(qrString, 72, 74),
      transhipmentStation: _originalSubstring(qrString, 74, 82),
    );
    notifyListeners();
    return _parcelData;
  }

  String? _safeSubstring(String string, int start, int end) {
    if (start >= string.length) return ''; // Return empty if start is out of bounds
    if (end > string.length) end = string.length; // Adjust end if it exceeds bounds

    String result = string.substring(start, end);

    if (RegExp(r'^\d+$').hasMatch(result) && result != "0") {
      result = result.replaceFirst(RegExp(r'^0+'), '');
    }
    return result;
  }

  String? _originalSubstring(String string, int start, int end) {
    if (start >= string.length) return '';
    if (end > string.length) end = string.length;
    return string.substring(start, end);
  }

  String? _getStringFromAscii(String? asciiString) {
    if (asciiString == null || asciiString.length != 8) return null;

    String data = '';
    for (int i = 0; i < asciiString.length; i += 2) {
      int asciiCode = int.parse(asciiString.substring(i, i + 2));
      data += String.fromCharCode(asciiCode);
    }
    return data.toUpperCase();
  }

  String? _convertToReadableDateTime(String? dateTimeStr) {
    if (dateTimeStr == null || dateTimeStr.length != 12) {
      throw const FormatException("The date-time string must be exactly 12 characters long.");
    }

    String day = dateTimeStr.substring(0, 2);
    String month = dateTimeStr.substring(2, 4);
    String year = dateTimeStr.substring(4, 8);
    String hour = dateTimeStr.substring(8, 10);
    String minute = dateTimeStr.substring(10, 12);

    return "$day-$month-$year $hour:$minute";
  }
}
