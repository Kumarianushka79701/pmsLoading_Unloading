import 'package:flutter/material.dart';
import 'package:project/modules/lodingScreen/provider/loading_provider.dart';
import 'package:provider/provider.dart';
import 'package:project/modules/lodingScreen/loading_screen/collapsible_view.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common_app_bar.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:project/widgets/text_widget.dart';

class LoadigScreen extends StatelessWidget {
  const LoadigScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.watch<LoadingProvider>();
    final scaffoldKey = GlobalKey<ScaffoldState>();

    return Scaffold(
      key: scaffoldKey,
      appBar: getAppBar(
        context,
        title: getLoadingSummaryAppBarTitle(context),
        actions: [
          IconButton(
            icon: const Icon(Icons.menu),
            color: ParcelColors.white,
            onPressed: () {
              print("Menu button pressed");
              scaffoldKey.currentState?.openDrawer();
            },
          ),
        ],
        onTap: () {
          print("AppBar tapped");
        },
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: provider.getFormKey,
            child: Column(
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
                      onPressed: () {
                        print("Scheduled Dep Date Selected");
                        provider.selectDate(context, true);
                      },
                      child:
                          Text(provider.formatDate(provider.scheduledDepDate)),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Consumer<LoadingProvider>(
                  builder: (context, provider, child) {
                    return DropdownButtonFormField<String>(
                      key: UniqueKey(),
                      decoration: const InputDecoration(
                        labelText: 'Vehicle Type',
                        border: OutlineInputBorder(),
                      ),
                      value: provider.selectedVehicleType,
                      items: ['Type A', 'Type B', 'Type C']
                          .map((type) => DropdownMenuItem<String>(
                                value: type,
                                child: Text(type),
                              ))
                          .toList(),
                      onChanged: (value) => provider.setVehicleType(value),
                    );
                  },
                ),
                const SizedBox(height: 5),
                TextFormField(
                  decoration: const InputDecoration(
                    labelText: 'Train No.',
                    border: OutlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                  onSaved: provider.setTrainNo,
                ),
                const SizedBox(height: 10),
                Container(
                  width: double.infinity,
                  padding:
                      const EdgeInsets.symmetric(vertical: 2, horizontal: 15),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(30),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const TextWidget(
                        label: 'Show Guidance',
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: ParcelColors.catalinaBlue,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              AnimatedSwitcher(
                                duration: const Duration(milliseconds: 300),
                                child: provider.showGuidance
                                    ? const TextWidget(
                                        label: 'On',
                                        key: ValueKey('On'),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        textColor: ParcelColors.catalinaBlue,
                                      )
                                    : const TextWidget(
                                        label: 'Off',
                                        key: ValueKey('Off'),
                                        fontSize: 12,
                                        fontWeight: FontWeight.w600,
                                        textColor: ParcelColors.catalinaBlue,
                                      ),
                              ),
                              Transform.scale(
                                scale: 0.8,
                                child: Switch(
                                  value: provider.showGuidance,
                                  onChanged: (value) =>
                                      provider.toggleGuidance(value),
                                  activeColor: Colors.blue,
                                  inactiveThumbColor: Colors.grey,
                                  inactiveTrackColor:
                                      Colors.grey.withOpacity(0.5),
                                ),
                              ),
                            ],
                          ),
                        ],
                      )
                    ],
                  ),
                ),
                const SizedBox(height: 15),
                if (provider.showGuidance)
                  CollapsibleForm(
                    onSaveData: provider.updateCollapsibleFormData,
                    onValidationChange: provider.updateCollapsibleFormValidity,
                  ),
                const SizedBox(height: 10),
                GestureDetector(
                  onTap: () async {
                    DateTime? pickedDate = await showDatePicker(
                      context: context,
                      initialDate: provider.actualLoadDate ?? DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (pickedDate != null) {
                      provider.setLoadDate(pickedDate);
                    }
                  },
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                        vertical: 12, horizontal: 15),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey),
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        const TextWidget(
                          label: 'Actual Load Date:',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          textColor: ParcelColors.catalinaBlue,
                        ),
                        Text(
                          provider.actualLoadDate != null
                              ? '${provider.actualLoadDate!.day}-${provider.actualLoadDate!.month}-${provider.actualLoadDate!.year}'
                              : 'Select Date',
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 25),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    CustomButtonWidget(
                      text: 'Submit',
                      onPressed: () {
                        print("Submit button pressed");
                        provider.submitForm(context);
                      },
                      suffixIcon: Icons.check,
                      color: Colors.green,
                    ),
                    CustomButtonWidget(
                      text: 'CANCEL',
                      onPressed: () {
                        print("Cancel button pressed");
                        Navigator.pop(context);
                      },
                      suffixIcon: Icons.cancel,
                      color: ParcelColors.gray,
                    ),
                  ],
                ),
              ],
            ),
          ),
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
