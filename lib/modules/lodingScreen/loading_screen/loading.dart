import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/modules/lodingScreen/loading_screen/collapsible_view.dart';
import 'package:project/modules/lodingScreen/loading_screen/scan_data.dart';
import 'package:project/utils/app_icons.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/button.dart';
import 'package:project/widgets/common_app_bar%20copy.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:project/widgets/text_widget.dart';
import '../provider/collapsible_form.dart'; // Import your collapsible form here

class LoadigScreen extends StatefulWidget {
  const LoadigScreen({super.key});

  @override
  _LoadigScreenState createState() => _LoadigScreenState();
}

class _LoadigScreenState extends State<LoadigScreen> {
  final _formKey = GlobalKey<FormState>();

  // Main form field variables
  DateTime? _scheduledDepDate;
  DateTime? _actualLoadDate;
  String? _vehicleType;
  String? _trainNo;
  bool _showGuidance = false;
  bool _isCollapsibleFormValid = false;

  // Collapsible form data storage
  Map<String, dynamic> _collapsibleFormData = {};

  // Helper method for date formatting
  String formatDate(DateTime? date) {
    if (date == null) return "Select Date";
    return DateFormat('dd-MMM-yyyy HH:mm').format(date);
  }

  // Method to select a date
  Future<void> _selectDate(BuildContext context, bool isScheduled) async {
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
        setState(() {
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
        });
      }
    }
  }

void _submitForm() {
  if (_formKey.currentState!.validate()) {
    if (_showGuidance && !_isCollapsibleFormValid) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Please complete the collapsible form')),
      );
      return;
    }

    _formKey.currentState!.save();

    Map<String, dynamic> formData = {
      'scheduledDepDate': _scheduledDepDate ?? "Not provided",
      'vehicleType': _vehicleType ?? "Not selected",
      'trainNo': _trainNo ?? "Not entered",
      'actualLoadDate': _actualLoadDate ?? "Not provided",
      ..._collapsibleFormData
    };

    print(formData);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Form submitted successfully!')),
    );

    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  ScanDataScreen()),
    );
  }
}

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      appBar: getAppBar(context,
          title: getLoadingSummaryAppBarTitle(context),
          actions: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: const Icon(Icons.menu),
                color: ParcelColors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ],
          onTap: () {}),
      body: SingleChildScrollView(
        child: Stack(
          children: [
            Positioned.fill(
              child: Opacity(
                opacity: 0.1, // Adjust opacity here
                child: Image.asset(
                  AppIcons.pmsLogoTwo,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            SizedBox(
              height: size.height * 0.5,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(
                        label: "Scheduled Dep.",
                        fontSize: 16,
                        fontWeight: FontWeight.w700,
                        textColor: ParcelColors.black,
                      ),
                      TextButton(
                        onPressed: () => _selectDate(context, true),
                        child: Text(formatDate(_scheduledDepDate)),
                      ),
                    ],
                  ),

                  DropdownButtonFormField<String>(
                    decoration: const InputDecoration(
                      labelText: 'Vehicle Type',
                      border: OutlineInputBorder(),
                    ),
                    items: ['Type A', 'Type B', 'Type C']
                        .map((type) => DropdownMenuItem<String>(
                              value: type,
                              child: Text(type),
                            ))
                        .toList(),
                    onChanged: (value) {
                      setState(() {
                        _vehicleType = value;
                      });
                    },
                    validator: (value) =>
                        value == null ? 'Please select a vehicle type' : null,
                  ),
                  const SizedBox(height: 5),

                  // Train No Input
                  TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Train No.',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _trainNo = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a train number' : null,
                  ),
                  const SizedBox(height: 10),

                  // Show Guidance Toggle
                  SwitchListTile(
                    title: TextWidget(
                      label: "Show Guidance",
                      fontSize: 16,
                      fontWeight: FontWeight.w700,
                    ),
                    // title: const Text('Show Guidance '),
                    value: _showGuidance,
                    onChanged: (value) {
                      setState(() {
                        _showGuidance = value;
                      });
                    },
                  ),

                  // Collapsible Form when Toggle is ON
                  if (_showGuidance)
                    CollapsibleForm(
                      onSaveData: (formData) {
                        setState(() {
                          _collapsibleFormData = formData;
                        });
                      },
                      onValidationChange: (isValid) {
                        setState(() {
                          _isCollapsibleFormValid = isValid;
                        });
                      },
                    ),

                  // Actual Load Date
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(
                        label: 'Actual Load Date',
                        textColor: ParcelColors.catalinaBlue,
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                      TextButton(
                        onPressed: () => _selectDate(context, false),
                        child: TextWidget(
                          label: formatDate(_actualLoadDate),
                          fontWeight: FontWeight.w400,
                          textColor: ParcelColors.catalinaBlue,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButtonWidget(
                        text: 'Submit',
                        onPressed: () {
                          _submitForm;
                        },
                        suffixIcon: Icons.check,
                        color: Colors.green,
                      ),
                      CustomButtonWidget(
                        text: 'CANCEL',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        suffixIcon: Icons.cancel,
                        color: ParcelColors.redPigment,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

Widget getLoadingSummaryAppBarTitle(BuildContext context) {
  return const TextWidget(
    label: "Loading Summary",
    textColor: ParcelColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}
