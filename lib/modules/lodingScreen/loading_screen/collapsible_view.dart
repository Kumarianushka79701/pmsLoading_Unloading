import 'package:flutter/material.dart';
import 'package:project/modules/lodingScreen/provider/collapsible_form.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class CollapsibleForm extends StatefulWidget {
  final Function(Map<String, dynamic>) onSaveData;
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
  late CollapsibleFormProvider provider;

  @override
  void initState() {
    super.initState();
    provider = Provider.of<CollapsibleFormProvider>(context, listen: false);
  }

  void _saveForm() {
    if (provider.validateForm()) {
      provider.saveForm();
      widget.onSaveData(provider.getFormData());
      widget.onValidationChange(true);
    } else {
      widget.onValidationChange(false);
    }
  }

  Widget _textWidget(String text) =>
      Text(text, style: const TextStyle(fontSize: 16));

  @override
  Widget build(BuildContext context) {
    return Form(
      key: provider.formKey,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Platform No',
              border: OutlineInputBorder(),
            ),
            items: ['Platform 1', 'Platform 2', 'Platform 3']
                .map((platform) => DropdownMenuItem<String>(
                      value: platform,
                      child: _textWidget(platform),
                    ))
                .toList(),
            value: provider.platformNo,
            onChanged: (value) {
              provider.platformNo = value;
              _saveForm();
            },
            validator: (value) =>
                value == null ? 'Please select a platform' : null,
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            value: provider.acceptIcsmWagon,
            title: TextWidget(
              label: 'Accept ICMS Wagon',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textColor: ParcelColors.catalinaBlue,
            ),
            onChanged: (value) {
              provider.acceptIcsmWagon = value ?? false;
              _saveForm();
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Wagon-Rly-No.',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              provider.wagonRlyNo = value;
            },
            validator: (value) =>
                value!.isEmpty ? 'Please enter the Wagon Rly No.' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'RPF',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              provider.rpf = value;
            },
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Guard Mobile No.',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.phone,
            onSaved: (value) {
              provider.guardMobileNo = value;
            },
            validator: (value) => value!.isEmpty
                ? 'Please enter the Guard\'s mobile number'
                : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            decoration: const InputDecoration(
              labelText: 'Remarks',
              border: OutlineInputBorder(),
            ),
            onSaved: (value) {
              provider.remarks = value;
            },
          ),
          const SizedBox(height: 10),
          CheckboxListTile(
            value: provider.sealed,
            title: const TextWidget(
              label: 'Sealed',
              fontSize: 14,
              fontWeight: FontWeight.w600,
              textColor: ParcelColors.catalinaBlue,
            ),
            onChanged: (value) {
              provider.sealed = value ?? false;
              _saveForm();
            },
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Seal to Station',
              border: OutlineInputBorder(),
            ),
            items: ['Station A', 'Station B', 'Station C']
                .map((station) => DropdownMenuItem<String>(
                      value: station,
                      child: _textWidget(station),
                    ))
                .toList(),
            value: provider.sealToStation,
            onChanged: (value) {
              provider.sealToStation = value;
              _saveForm();
            },
          ),
          const SizedBox(height: 10),
          DropdownButtonFormField<String>(
            decoration: const InputDecoration(
              labelText: 'Nil Loading/Unloading Reason',
              border: OutlineInputBorder(),
            ),
            items: ['Reason A', 'Reason B', 'Reason C']
                .map((reason) => DropdownMenuItem<String>(
                      value: reason,
                      child: _textWidget(reason),
                    ))
                .toList(),
            value: provider.nilLoadingReason,
            onChanged: (value) {
              provider.nilLoadingReason = value;
              _saveForm();
            },
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
