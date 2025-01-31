import 'package:flutter/material.dart';
import 'package:project/modules/lodingScreen/provider/collapsible_form.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/custon_dropDown_feild.dart';
import 'package:project/widgets/label_text_form_feild.dart';
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
          const SizedBox(height: 10),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(30),
            ),
            child: CheckboxListTile(
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
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: 'Wagon-Rly-No.',
            labelColor: ParcelColors.catalinaBlue,
            textColor: ParcelColors.catalinaBlue,
            borderColor: ParcelColors.gray,
            textSize: 15,
            width: double.infinity,
            fontWeight: FontWeight.w600,
            onSaved: (value) {
              provider.wagonRlyNo = value;
            },
            validator: (value) =>
                value!.isEmpty ? 'Please enter the Wagon Rly No.' : null,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: 'RPF',
            labelColor: ParcelColors.catalinaBlue,
            textColor: ParcelColors.catalinaBlue,
            borderColor: ParcelColors.gray,
            textSize: 15,
            width: double.infinity,
            fontWeight: FontWeight.w600,
            onSaved: (value) {
              provider.rpf = value;
            },
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: 'Guard Mobile No.',
            labelColor: ParcelColors.catalinaBlue,
            textColor: ParcelColors.catalinaBlue,
            borderColor: ParcelColors.gray,
            textSize: 15,
            width: double.infinity,
            fontWeight: FontWeight.w600,
            keyboardType: TextInputType.phone,
            onSaved: (value) {
              provider.guardMobileNo = value;
            },
            validator: (value) => value!.isEmpty
                ? 'Please enter the Guard\'s mobile number'
                : null,
          ),
          const SizedBox(height: 10),
          CustomTextField(
            label: 'Remarks',
            labelColor: ParcelColors.catalinaBlue,
            textColor: ParcelColors.catalinaBlue,
            borderColor: ParcelColors.gray,
            textSize: 15,
            width: double.infinity,
            fontWeight: FontWeight.w600,
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
          CustomDropdown(
            label: 'Seal to Station',
            items: ['Station A', 'Station B', 'Station C'],
            value: provider.sealToStation,
            onChanged: (value) {
              provider.sealToStation = value;
              _saveForm();
            },
            validator: (value) =>
                value == null ? 'Please select a station' : null,
            labelColor: Colors.blue, // Example label color
            textColor: Colors.black, // Example text color
            fontWeight: FontWeight.bold, // Example font weight
            fontSize: 16, // Example font size
            borderColor: Colors.blue, // Example border color
            borderRadius: BorderRadius.circular(20), // Optional border radius
          ),
          const SizedBox(height: 10),
          CustomDropdown(
            label: 'Nil Loading/Unloading Reason',
            items: ['Reason A', 'Reason B', 'Reason C'],
            value: provider.nilLoadingReason,
            onChanged: (value) {
              provider.nilLoadingReason = value;
              _saveForm();
            },
            validator: (value) =>
                value == null ? 'Please select a reason' : null,
            labelColor: Colors.blue, // Example label color
            textColor: Colors.black, // Example text color
            fontWeight: FontWeight.bold, // Example font weight
            fontSize: 16, // Example font size
            borderColor: Colors.blue, // Example border color
            borderRadius: BorderRadius.circular(20), // Optional border radius
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
