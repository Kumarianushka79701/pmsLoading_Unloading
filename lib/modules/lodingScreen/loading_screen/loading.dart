import 'package:flutter/material.dart';
import 'package:project/modules/lodingScreen/provider/loading_provider.dart';
import 'package:project/widgets/drop_down.dart';
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

    return WillPopScope(
      onWillPop: () async {
        context.read<LoadingProvider>().resetValue(); // Reset selected value
        return true; // Allow back navigation
      },
      child: Scaffold(
        backgroundColor: Colors.white,
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
                        child: Text(
                            provider.formatDate(provider.scheduledDepDate)),
                      ),
                    ],
                  ),
                  const SizedBox(height: 10),

                  DropdownRadioWidget(
                    title: "Vehicle Type",
                    fontSize: 15,
                    options: [
                      "VP-16.8T",
                      "DOGBOX-OT",
                      "FCRSLR-4T",
                      "FCFSLR-4T"
                    ],
                    controller:
                        provider.vehicleTypeController, // Pass the controller
                  ),

                  const SizedBox(height: 15),
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
                          label: 'Train No.',
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          textColor: ParcelColors.catalinaBlue,
                        ),
                        SizedBox(
                          width: MediaQuery.of(context).size.width * 0.35,
                        ),
                        const Expanded(
                          child: TextField(
                            decoration: InputDecoration(
                              hintText: 'Enter Train No.',
                              hintStyle: TextStyle(
                                fontSize: 15,
                                fontWeight: FontWeight.w600,
                                color: ParcelColors.gray,
                              ),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 15),
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
                  DropdownRadioWidget(
                    title: "Plateform Type",
                    fontSize: 15,
                    options: ['Plateform1', 'Plateform2', 'Plateform3'],
                    controller:
                        provider.platformController, // Pass the controller
                  ),

                  // DropdownRadioWidget(
                  //   title: "Select Platform",

                  //   options: ["Platform 1", "Platform 2", "Platform 3"],
                  //   fontSize: 16,
                  //   fontWeight: FontWeight.w500,
                  //   textColor: ParcelColors.catalinaBlue,
                  //   radioColor: ParcelColors.catalinaBlue,
                  //   controller: provider
                  //       .platformController, // Passing separate controller
                  // ),

                  // DropdownButtonFormField<String>(
                  //   value: provider.selectPlatform,
                  //   hint: const TextWidget(
                  //     label: 'Plateform Number',
                  //     fontSize: 15,
                  //     fontWeight: FontWeight.w600,
                  //     textColor: ParcelColors.catalinaBlue,
                  //   ),
                  //   onChanged: (value) => provider.setPlateformType(value),
                  //   items: ['Plateform1', 'Plateform2', 'Plateform3'].map((type) {
                  //     return DropdownMenuItem<String>(
                  //       value: type,
                  //       child: TextWidget(
                  //         label: type,
                  //         fontSize: 15,
                  //         fontWeight: FontWeight.w600,
                  //         textColor: ParcelColors.catalinaBlue,
                  //       ),
                  //     );
                  //   }).toList(),
                  //   decoration: InputDecoration(
                  //     border: OutlineInputBorder(
                  //         borderRadius: BorderRadius.circular(30)),
                  //     contentPadding: const EdgeInsets.symmetric(
                  //         horizontal: 15, vertical: 10),
                  //   ),
                  // ),
                  if (provider.showGuidance)
                    CollapsibleForm(
                      onSaveData: provider.updateCollapsibleFormData,
                      onValidationChange:
                          provider.updateCollapsibleFormValidity,
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
