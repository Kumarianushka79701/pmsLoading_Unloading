import 'package:flutter/material.dart';
import 'package:project/modules/prrStatus/provider/prr_status_Provider.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common/RoundButton.dart';
import 'package:project/widgets/custom_button.dart';
import 'package:project/widgets/custom_text_feild.dart';
import 'package:project/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class PRRStatusPage extends StatelessWidget {
  const PRRStatusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final prrStatusProvider =
        Provider.of<PrrStatusProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: EdgeInsets.symmetric(horizontal: 20, vertical: 30),
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
                          border: Border.all(color: ParcelColors.water, width: 2),
                          shape: BoxShape.circle,
                          color: ParcelColors.white,
                        ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 3, vertical: 3),
                        decoration: BoxDecoration(
                          border: Border.all(color: ParcelColors.brandeisblue, width: 2),
                          shape: BoxShape.circle,
                          color: ParcelColors.white,
                        ),
                        child: Icon(
                          Icons.close,
                          color: ParcelColors.brandeisblue,
                          size: 12,
                        ),
                      ),
                    ),
                  ),
                ),
                
                Align(
                  alignment: Alignment.center,
                  child: TextWidget(
                    label: "PRR Status",
                    textColor: ParcelColors.catalinaBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            CustomTextFormField(
              controller: prrStatusProvider.prrController,
              labelText: 'PRR No.',
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: prrStatusProvider.sourceController,
              labelText: 'Source Stn.',
            ),
            const SizedBox(height: 16),
            CustomTextFormField(
              controller: prrStatusProvider.destController,
              labelText: 'Dest. Stn.',
            ),
            const SizedBox(height: 16),
            GestureDetector(
              onTap: () => _showBookingTypePopup(context, prrStatusProvider),
              child: AbsorbPointer(
                child: CustomTextFormField(
                  controller: prrStatusProvider.bookingTypeController,
                  labelText: 'Booking Type',
                ),
              ),
            ),
            const SizedBox(height: 30),
            RoundButton(
              title: Text(
                'Submit',
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              onPressed: () {
                prrStatusProvider.submitForm();
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showBookingTypePopup(BuildContext context, PrrStatusProvider provider) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          contentPadding: const EdgeInsets.all(16.0),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Booking Type',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const Divider(),
              RadioListTile<String>(
                value: 'PWB',
                groupValue: provider.selectedBookingType,
                onChanged: (value) {
                  provider.updateBookingType(value!);
                  Navigator.pop(context);
                },
                title: const Text('PWB'),
              ),
              RadioListTile<String>(
                value: 'LT',
                groupValue: provider.selectedBookingType,
                onChanged: (value) {
                  provider.updateBookingType(value!);
                  Navigator.pop(context);
                },
                title: const Text('LT'),
              ),
              RadioListTile<String>(
                value: 'VPB',
                groupValue: provider.selectedBookingType,
                onChanged: (value) {
                  provider.updateBookingType(value!);
                  Navigator.pop(context);
                },
                title: const Text('VPB'),
              ),
            ],
          ),
        );
      },
    );
  }
}
