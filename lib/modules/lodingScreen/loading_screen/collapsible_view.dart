import 'package:flutter/material.dart';
import 'package:project/modules/lodingScreen/provider/loading_provider.dart';
import 'package:project/widgets/label_text_form_feild.dart';
import 'package:provider/provider.dart';
import 'package:project/modules/lodingScreen/provider/collapsible_form.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/drop_down.dart';
import 'package:project/widgets/text_widget.dart';

class CollapsibleForm extends StatelessWidget {
  final Function(Map<String, dynamic>) onSaveData;
  final Function(bool) onValidationChange;

  const CollapsibleForm({
    Key? key,
    required this.onSaveData,
    required this.onValidationChange,
  }) : super(key: key);

  void _saveForm(BuildContext context) {
    final provider =
        Provider.of<CollapsibleFormProvider>(context, listen: false);

    if (provider.validateForm()) {
      provider.saveForm();
      onSaveData(provider.getFormData());
      onValidationChange(true);
    } else {
      onValidationChange(false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<CollapsibleFormProvider>(context);
    final loadingProvider =
        Provider.of<LoadingProvider>(context, listen: false);

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
              activeColor: ParcelColors.catalinaBlue,
              title: const TextWidget(
                label: 'Accept ICMS Wagon',
                fontSize: 14,
                fontWeight: FontWeight.w600,
                textColor: ParcelColors.catalinaBlue,
              ),
              onChanged: (value) {
                provider.acceptIcsmWagon = value ?? false;
                _saveForm(context);
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
            onSaved: (value) => provider.wagonRlyNo = value,
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
            onSaved: (value) => provider.rpf = value,
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
            onSaved: (value) => provider.guardMobileNo = value,
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
            onSaved: (value) => provider.remarks = value,
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
              _saveForm(context);
            },
          ),
          const SizedBox(height: 10),
          DropdownRadioWidget(
            validator: (value) =>
                value == null ? 'Please select a station' : null,
            title: 'Seal to Station',
            fontSize: 15,
            options: ['Station A', 'Station B', 'Station C'],
            controller: loadingProvider.sealToStation, // Pass the controller
          ),
          const SizedBox(height: 10),
          DropdownRadioWidget(
            title: 'Nil Loading/Unloading Reason',
            fontSize: 15,
            validator: (value) =>
                value == null ? 'Please select a reason' : null,
            options: ['Reason A', 'Reason B', 'Reason C'],
            controller: loadingProvider.nilLoadingReason, // Pass the controller
          ),
          const SizedBox(height: 10),
          const SizedBox(height: 10),
        ],
      ),
    );
  }
}
