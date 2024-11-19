import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:project/modules/lodingScreen/loading_screen/scan_data.dart';
import 'package:project/utils/app_icons.dart';
import 'collapsible_form.dart'; // Import your collapsible form here



class LoadigScreen extends StatefulWidget {
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

  // Method to validate and submit the form
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      // if (_showGuidance && !_isCollapsibleFormValid) {
      //   // Show validation error for the collapsible form
      //   ScaffoldMessenger.of(context).showSnackBar(
      //     SnackBar(content: Text('Please complete the collapsible form')),
      //   );
      //   return;
      // }

      _formKey.currentState!.save();

      // Combine the main form data and collapsible form data
      Map<String, dynamic> formData = {
        'scheduledDepDate': _scheduledDepDate,
        'vehicleType': _vehicleType,
        'trainNo': _trainNo,
        'actualLoadDate': _actualLoadDate,
        ..._collapsibleFormData // Merging collapsible form data
      };

      // Print the combined form data (this can be used for saving to a database, API call, etc.)
      print(formData);

      // Navigate to ScanDataScreen after successful form submission
      Navigator.push(
        context,
        MaterialPageRoute(builder: (context) => ScanDataScreen()),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final size =MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        title: Text('Loading Summary',),
        backgroundColor: Colors.green[700],
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Image.asset(AppIcons.pmsLogoTwo), // Replace with your logo asset
          ),
        ],
      ),
      body: Stack(
        children: [
           Positioned.fill(
          child: Opacity(
            opacity: 0.1, // Adjust opacity here
            child: Image.asset(
              AppIcons.pmsLogoTwo, // Ensure this path is correct
              fit: BoxFit.cover,
            ),
          ),
        ),
        SizedBox(height:size.height*0.5 ,),
         Padding(
          padding: const EdgeInsets.all(16.0),
          child: Container(
            height:size.height*0.5,
            color: Colors.white,
            padding: EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Scheduled Departure
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Scheduled Dep.',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () => _selectDate(context, true),
                        child: Text(formatDate(_scheduledDepDate)),
                      ),
                    ],
                  ),
                       
                  // Vehicle Type Dropdown
                  DropdownButtonFormField<String>(
                    decoration: InputDecoration(
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
                  SizedBox(height: 5),
                       
                  // Train No Input
                  TextFormField(
                    decoration: InputDecoration(
                      labelText: 'Train No.',
                      border: OutlineInputBorder(),
                    ),
                    keyboardType: TextInputType.number,
                    onSaved: (value) => _trainNo = value,
                    validator: (value) =>
                        value!.isEmpty ? 'Please enter a train number' : null,
                  ),
                  SizedBox(height: 10),
                       
                  // Show Guidance Toggle
                  SwitchListTile(
                    title: Text('Show Guidance '),
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
                      Text(
                        'Actual Load Date',
                        style: TextStyle(fontSize: 18),
                      ),
                      TextButton(
                        onPressed: () => _selectDate(context, false),
                        child: Text(formatDate(_actualLoadDate)),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                       
                  // Submit and Cancel Buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton(
                        onPressed: _submitForm,
                        child: const Row(
                          children: [
                            Icon(Icons.check),
                            SizedBox(width: 5),
                            Text('SUBMIT'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.green,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          // Reset or Cancel functionality
                          Navigator.pop(context);
                        },
                        child: Row(
                          children: [
                            Icon(Icons.cancel),
                            SizedBox(width: 5),
                            Text('CANCEL'),
                          ],
                        ),
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.red,
                        ),
                      ),
                    ],
                  ),
                ],
            
            ),
          ),
                   ),
             
        
            
        ],
          ),
    );
  }
}
