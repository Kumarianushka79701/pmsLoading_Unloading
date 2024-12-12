import 'package:flutter/material.dart';

class CollapsibleFormProvider with ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String? platformNo;
  bool acceptIcsmWagon = false;
  String? wagonRlyNo;
  String? rpf;
  String? guardMobileNo;
  String? remarks;
  bool sealed = false;
  String? sealToStation;
  String? nilLoadingReason;

  bool validateForm() {
    return formKey.currentState?.validate() ?? false;
  }

  void saveForm() {
    if (formKey.currentState?.validate() ?? false) {
      formKey.currentState?.save();
      notifyListeners();
    }
  }

  /// Add this method
  Map<String, dynamic> getFormData() {
    return {
      'platformNo': platformNo,
      'acceptIcsmWagon': acceptIcsmWagon,
      'wagonRlyNo': wagonRlyNo,
      'rpf': rpf,
      'guardMobileNo': guardMobileNo,
      'remarks': remarks,
      'sealed': sealed,
      'sealToStation': sealToStation,
      'nilLoadingReason': nilLoadingReason,
    };
  }
}
