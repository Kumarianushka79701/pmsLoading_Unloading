import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/routes/app_routes.dart';
import 'package:project/widgets/custom_toggle_button.dart';

class LoadingProvider extends ChangeNotifier {
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  DateTime? _scheduledDepDate;
  DateTime? _actualLoadDate;
  String? _vehicleType;
  String? _trainNo;
  bool _showGuidance = false;
  bool _isCollapsibleFormValid = false;
  Map<String, dynamic> _collapsibleFormData = {};
  TextEditingController vehicleTypeController = TextEditingController();
  TextEditingController platformController = TextEditingController();
  TextEditingController titleController =
      TextEditingController(text: "Select Plateform"); // Added title controller

  DateTime? get scheduledDepDate => _scheduledDepDate;
  DateTime? get actualLoadDate => _actualLoadDate;
  String? get vehicleType => _vehicleType;
  String? get trainNo => _trainNo;
  bool get showGuidance => _showGuidance;
  bool get isCollapsibleFormValid => _isCollapsibleFormValid;
  Map<String, dynamic> get collapsibleFormData => _collapsibleFormData;
  GlobalKey<FormState> get getFormKey => formKey;
  String? selectedVehicleType;
  String? selectPlatform;

  // Date Formatting
  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return DateFormat('dd-MMM-yyyy HH:mm').format(date);
  }

  String? _selectedValue;

  String? get selectedValue => _selectedValue;

  void selectValue(String value) {
    _selectedValue = value;
    notifyListeners();
  }

  void resetValue() {
    _selectedValue = null;
    notifyListeners();
  }

  // Select Date Function
  Future<void> selectDate(BuildContext context, bool isScheduled) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      final TimeOfDay? pickedTime = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.now(),
      );
      if (pickedTime != null) {
        DateTime fullDateTime = DateTime(
          picked.year,
          picked.month,
          picked.day,
          pickedTime.hour,
          pickedTime.minute,
        );
        if (isScheduled) {
          _scheduledDepDate = fullDateTime;
        } else {
          _actualLoadDate = fullDateTime;
        }
        notifyListeners();
      }
    }
  }

  void setTrainNo(String? trainNo) {
    _trainNo = trainNo;
    notifyListeners();
  }

  void toggleShowGuidance(bool value) {
    _showGuidance = value;
    notifyListeners();
  }

  void updateCollapsibleFormData(Map<String, dynamic> data) {
    _collapsibleFormData = data;
    notifyListeners();
  }

  void updateCollapsibleFormValidity(bool isValid) {
    _isCollapsibleFormValid = isValid;
    notifyListeners();
  }

//  void setVehicleType(String? type) {
//     selectedVehicleType = type;
//     notifyListeners();
//   }

  void toggleGuidance(bool value) {
    _showGuidance = value;
    notifyListeners();
  }

  void setLoadDate(DateTime date) {
    _actualLoadDate = date;
    notifyListeners();
  }

  // Form Submission
  void submitForm(BuildContext context) {
    if (formKey.currentState!.validate()) {
      if (_showGuidance && !_isCollapsibleFormValid) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Please complete the collapsible form')),
        );
        return;
      }

      formKey.currentState!.save();

      Map<String, dynamic> formData = {
        'scheduledDepDate': _scheduledDepDate ?? "Not provided",
        'vehicleType': _vehicleType ?? "Not selected",
        'trainNo': _trainNo ?? "Not entered",
        'actualLoadDate': _actualLoadDate ?? "Not provided",
        ..._collapsibleFormData
      };

      print(formData);

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Form submitted successfully!')),
      );
      Navigator.pushNamed(context, Routes.SCAN_DATA_SCREEN);
      // Navigator.pushNamed(context, '/scanDataScreen');
    }
  }

  void setVehicleType(String? type) {
    if (selectedVehicleType != type) {
      selectedVehicleType = type;
      notifyListeners(); // Notify only when there's a change
    }
  }

  void setPlateformType(String? type) {
    if (selectPlatform != type) {
      selectPlatform = type;
      notifyListeners(); // Notify only when there's a change
    }
  }
}
