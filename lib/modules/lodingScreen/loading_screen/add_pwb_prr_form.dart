import 'package:flutter/material.dart';

class AddPwbPrrForm extends StatefulWidget {
  @override
  _AddPwbPrrFormState createState() => _AddPwbPrrFormState();
}

class _AddPwbPrrFormState extends State<AddPwbPrrForm> {
  final _formKey = GlobalKey<FormState>();

  // Form field controllers or variables
  String? _prrNo;
  String? _sourceStnCode;
  String? _destStnCode;
  String? _itemType;
  String? _bookingType = "PWB"; // Default to "PWB"
  String? _pwbPrrNo;
  String? _srcStn;
  String? _destStn;
  String? _commodityType;
  String? _pkgCondn;
  String? _pkgDesc;
  String? _remarks;
  String? _rackNo;

  // Method to reset the form
  void _resetForm() {
    _formKey.currentState!.reset();
    setState(() {
      _bookingType = "PWB"; // Reset booking type to PWB
    });
  }

  // Method to save form data
  void _saveForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();

      // For demo purposes, showing a success message
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Form Saved Successfully!')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add PWB/PRR'),
        backgroundColor: Colors.green[700],
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child:
                Image.asset('assets/logo.png'), // Replace with your logo asset
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Search Section (PRR, Source, Destination)
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Search PRR NO.',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _prrNo = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter PRR Number' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Source Stn Code',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _sourceStnCode = value,
                validator: (value) =>
                    value!.isEmpty ? 'Please enter Source Station Code' : null,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Destination Stn Code',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _destStnCode = value,
                validator: (value) => value!.isEmpty
                    ? 'Please enter Destination Station Code'
                    : null,
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  // Search Action for demo
                },
                icon: Icon(Icons.search),
                label: Text('SEARCH'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 20),

              // Booking Type Section
              DropdownButtonFormField<String>(
                value: _bookingType,
                decoration: InputDecoration(
                  labelText: 'Booking Type',
                  border: OutlineInputBorder(),
                ),
                items: ['PWB', 'PRR']
                    .map((type) => DropdownMenuItem<String>(
                          value: type,
                          child: Text(type),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _bookingType = value;
                  });
                },
              ),
              SizedBox(height: 10),

              // PWB/PRR No, Source, and Destination
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'PWB/PRR No.',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _pwbPrrNo = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'SRC STN',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _srcStn = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'DEST STN',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _destStn = value,
              ),
              SizedBox(height: 10),

              // BKD/LD PKG and WT Section
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'BKD PKG',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        // Save BKD PKG value
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'LD PKG',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        // Save LD PKG value
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'BKD WT (kg)',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        // Save BKD WT value
                      },
                    ),
                  ),
                  SizedBox(width: 10),
                  Expanded(
                    child: TextFormField(
                      decoration: InputDecoration(
                        labelText: 'LD WT (kg)',
                        border: OutlineInputBorder(),
                      ),
                      onSaved: (value) {
                        // Save LD WT value
                      },
                    ),
                  ),
                ],
              ),
              SizedBox(height: 10),

              // Commodity Type, Fare, Package Condition
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'Commodity Type',
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
                    _commodityType = value;
                  });
                },
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Fare',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) {
                  // Save fare value
                },
              ),
              SizedBox(height: 10),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(
                  labelText: 'PKG CONDN',
                  border: OutlineInputBorder(),
                ),
                items: ['Condition A', 'Condition B', 'Condition C']
                    .map((condition) => DropdownMenuItem<String>(
                          value: condition,
                          child: Text(condition),
                        ))
                    .toList(),
                onChanged: (value) {
                  setState(() {
                    _pkgCondn = value;
                  });
                },
              ),
              SizedBox(height: 10),

              // Remarks, Rack No
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Remarks',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _remarks = value,
              ),
              SizedBox(height: 10),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'RACK No.',
                  border: OutlineInputBorder(),
                ),
                onSaved: (value) => _rackNo = value,
              ),
              SizedBox(height: 20),

              // Buttons: Save, Reset, Cancel
              ElevatedButton.icon(
                onPressed: _saveForm,
                icon: Icon(Icons.save),
                label: Text('SAVE'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.green,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: _resetForm,
                icon: Icon(Icons.refresh),
                label: Text('RESET'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.blue,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
              SizedBox(height: 10),
              ElevatedButton.icon(
                onPressed: () {
                  Navigator.pop(context); // Go back to the previous screen
                },
                icon: Icon(Icons.cancel),
                label: Text('CANCEL'),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.red,
                  minimumSize: Size(double.infinity, 50),
                  textStyle: TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
