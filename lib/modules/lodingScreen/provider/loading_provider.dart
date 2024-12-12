import 'package:flutter/material.dart';

class LoadingProvider with ChangeNotifier {
    final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController mobileNumberController = TextEditingController();

  String? platformNo;
  bool acceptIcsmWagon = false;
  bool sealed = false;
  String? wagonRlyNo;
  String? rpf;
  String? guardMobileNo;
  String? remarks;
  String? sealToStation;
  String? nilLoadingReason;

  bool validateForm() {
    return platformNo != null &&
        guardMobileNo != null &&
        guardMobileNo!.isNotEmpty;
  }

  void updatePlatformNo(String? value) {
    platformNo = value;
    notifyListeners();
  }

  void updateAcceptIcsmWagon(bool value) {
    acceptIcsmWagon = value;
    notifyListeners();
  }

  void updateSealed(bool value) {
    sealed = value;
    notifyListeners();
  }

  void updateWagonRlyNo(String? value) {
    wagonRlyNo = value;
    notifyListeners();
  }

  void updateRpf(String? value) {
    rpf = value;
    notifyListeners();
  }

  void updateGuardMobileNo(String? value) {
    guardMobileNo = value;
    notifyListeners();
  }

  void updateRemarks(String? value) {
    remarks = value;
    notifyListeners();
  }

  void updateSealToStation(String? value) {
    sealToStation = value;
    notifyListeners();
  }

  void updateNilLoadingReason(String? value) {
    nilLoadingReason = value;
    notifyListeners();
  }
}
