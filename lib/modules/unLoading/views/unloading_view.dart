

import 'package:flutter/material.dart';
import 'package:project/modules/unLoading/providers/unloading_provider.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/text_widget.dart';
import 'package:provider/provider.dart';



class UnloadingSummaryScreen extends StatelessWidget {
  const UnloadingSummaryScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<UnloadingSummaryProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          backgroundColor: ParcelColors.white,
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 40),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Stack(
                  alignment: Alignment.center,
                  children: [
                    Align(
                      alignment: Alignment.centerLeft,
                      child: InkWell(
                        onTap: () => Navigator.pop(context),
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 3, vertical: 3),
                          decoration: BoxDecoration(
                            border:
                                Border.all(color: ParcelColors.water, width: 2),
                            shape: BoxShape.circle,
                            color: ParcelColors.white,
                          ),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 3, vertical: 3),
                            decoration: BoxDecoration(
                              border: Border.all(
                                  color: ParcelColors.brandeisblue, width: 2),
                              shape: BoxShape.circle,
                              color: ParcelColors.white,
                            ),
                            child: const Icon(
                              Icons.close,
                              color: ParcelColors.brandeisblue,
                              size: 12,
                            ),
                          ),
                        ),
                      ),
                    ),
                    const Align(
                      alignment: Alignment.center,
                      child: TextWidget(
                        label: "Unloading Summary",
                        textColor: ParcelColors.catalinaBlue,
                        fontWeight: FontWeight.w700,
                        fontSize: 18,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 40),
                const SizedBox(height: 20),

                // Scheduled Dep.
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
                          label: 'Schedule Load Date:', // Label text
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          textColor: ParcelColors.catalinaBlue,
                        ),
                        TextWidget(
                          label: provider.actualLoadDate != null
                              ? '${provider.actualLoadDate!.day}-${provider.actualLoadDate!.month}-${provider.actualLoadDate!.year}'
                              : 'Select Date', // Selected or default text
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          textColor: ParcelColors.catalinaBlue,
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 15),

                // Dropdown Field
                DropdownButtonFormField<String>(
                  value: provider.selectedVehicleType,
                  hint: const TextWidget(
                    label: 'Vehicle Type',
                    fontSize: 15,
                    fontWeight: FontWeight.w600,
                    textColor: ParcelColors.catalinaBlue,
                  ),
                  onChanged: (value) => provider.setVehicleType(value),
                  items: ['Truck', 'Van', 'Bike'].map((type) {
                    return DropdownMenuItem<String>(
                      value: type,
                      child: TextWidget(
                        label: type,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        textColor: ParcelColors.catalinaBlue,
                      ),
                    );
                  }).toList(),
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(30)),
                    contentPadding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                  ),
                ),
                const SizedBox(height: 15),

                // Train No.

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
                        width: MediaQuery.of(context).size.width * 0.3,
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
                            border: InputBorder
                                .none, // No border to keep it consistent with your container design
                          ),
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors
                                .black, // You can change the text color as needed
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 15),

                // Switch Field
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
                                    ? TextWidget(label: 
                                        'On',
                                        key: ValueKey('On'),
                                       fontSize: 12,
                        fontWeight: FontWeight.w600,
                        textColor: ParcelColors.catalinaBlue,
                                      )
                                    : TextWidget(label: 
                                        'Off',
                                        key: ValueKey('Off'),
                                         fontSize: 12,
                        fontWeight: FontWeight.w600,
                        textColor: ParcelColors.catalinaBlue,
                                      ),
                              ),
                              Transform.scale(
                                scale: 0.8, // Make the switch smaller
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

                const SizedBox(height: 5),
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
                          label: 'Actual Load Date:', // Label text
                          fontSize: 15,
                          fontWeight: FontWeight.w600,
                          textColor: ParcelColors.catalinaBlue,
                        ),
                        Text(
                          provider.actualLoadDate != null
                              ? '${provider.actualLoadDate!.day}-${provider.actualLoadDate!.month}-${provider.actualLoadDate!.year}'
                              : 'Select Date', // Selected or default text
                          style: const TextStyle(
                              fontSize: 16, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: 25),

                // Submit Button
                ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(30)),
                    padding: const EdgeInsets.symmetric(
                        vertical: 14, horizontal: 80),
                  ),
                  child: const Text('Submit', style: TextStyle(fontSize: 16)),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
