import 'package:flutter/material.dart';

class CollapsibleForm extends StatefulWidget {
  final Function(Map<String, dynamic>)
      onSaveData; // Callback to pass data back to parent
  final Function(bool) onValidationChange;

  const CollapsibleForm({
    Key? key,
    required this.onSaveData,
    required this.onValidationChange,
  }) : super(key: key);

  @override
  _CollapsibleFormState createState() => _CollapsibleFormState();
}

class _CollapsibleFormState extends State<CollapsibleForm> {
  final _collapsibleFormKey = GlobalKey<FormState>();

  // Collapsible form field variables
  String? _platformNo;
  bool _acceptIcsmWagon = false;
  bool _sealed = false;
  String? _wagonRlyNo;
  String? _rpf;
  String? _guardMobileNo;
  String? _remarks;
  String? _sealToStation;
  String? _nilLoadingReason;

  // Validate collapsible form fields
  bool _validateForm() {
    return _collapsibleFormKey.currentState!.validate();
  }

  // Save and pass the data back to the parent widget
  void _saveForm() {
    if (_collapsibleFormKey.currentState!.validate()) {
      _collapsibleFormKey.currentState!.save();

      // Pass the data back to parent through callback
      widget.onSaveData({
        'platformNo': _platformNo,
        'acceptIcsmWagon': _acceptIcsmWagon,
        'wagonRlyNo': _wagonRlyNo,
        'rpf': _rpf,
        'guardMobileNo': _guardMobileNo,
        'remarks': _remarks,
        'sealed': _sealed,
        'sealToStation': _sealToStation,
        'nilLoadingReason': _nilLoadingReason,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _collapsibleFormKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Platform No',
              border: OutlineInputBorder(),
            ),
            items: ['Platform 1', 'Platform 2', 'Platform 3']
                .map((platform) => DropdownMenuItem<String>(
                      value: platform,
                      child: Text(platform),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _platformNo = value;
              });
              widget.onValidationChange(_validateForm());
              _saveForm();
            },
            validator: (value) =>
                value == null ? 'Please select a platform' : null,
          ),
          SizedBox(height: 10),

          // Accept ICMS Wagon Checkbox
          CheckboxListTile(
            value: _acceptIcsmWagon,
            title: Text('Accept ICMS Wagon'),
            onChanged: (value) {
              setState(() {
                _acceptIcsmWagon = value ?? false;
              });
              _saveForm();
            },
          ),
          SizedBox(height: 10),

          // Wagon Rly No. Input
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Wagon-Rly-No.',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              _wagonRlyNo = value;
              _saveForm();
            },
            validator: (value) =>
                value!.isEmpty ? 'Please enter the Wagon Rly No.' : null,
          ),
          SizedBox(height: 10),

          // RPF Input
          TextFormField(
            decoration: InputDecoration(
              labelText: 'RPF',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              _rpf = value;
              _saveForm();
            },
          ),
          SizedBox(height: 10),

          // Guard Mobile No. Input
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Guard Mobile No.',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            onSaved: (value) {
              _guardMobileNo = value;
              _saveForm();
            },
            validator: (value) => value!.isEmpty
                ? 'Please enter the Guard\'s mobile number'
                : null,
          ),
          SizedBox(height: 10),

          // Remarks Input
          TextFormField(
            decoration: InputDecoration(
              labelText: 'Remarks',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              _remarks = value;
              _saveForm();
            },
          ),
          SizedBox(height: 10),

          // Sealed Checkbox
          CheckboxListTile(
            value: _sealed,
            title: Text('Sealed'),
            onChanged: (value) {
              setState(() {
                _sealed = value ?? false;
              });
              _saveForm();
            },
          ),
          SizedBox(height: 10),

          // Seal to Station Dropdown
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Seal to Station',
              border: OutlineInputBorder(),
            ),
            items: ['Station A', 'Station B', 'Station C']
                .map((station) => DropdownMenuItem<String>(
                      value: station,
                      child: Text(station),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _sealToStation = value;
              });
              _saveForm();
            },
          ),
          SizedBox(height: 10),

          // Nil Loading/Unloading Reason Dropdown
          DropdownButtonFormField<String>(
            decoration: InputDecoration(
              labelText: 'Nil Loading/Unloading Reason',
              border: OutlineInputBorder(),
            ),
            items: ['Reason A', 'Reason B', 'Reason C']
                .map((reason) => DropdownMenuItem<String>(
                      value: reason,
                      child: Text(reason),
                    ))
                .toList(),
            onChanged: (value) {
              setState(() {
                _nilLoadingReason = value;
              });
              _saveForm();
            },
          ),
          SizedBox(height: 10),
        ],
      ),
    );
  }
}
