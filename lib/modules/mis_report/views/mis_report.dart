import 'package:flutter/material.dart';
import 'package:project/modules/mis_report/provider/mis_report_provider.dart';
import 'package:project/modules/reports/provider/report_provider.dart';
import 'package:project/modules/reports/views/report_view.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common/RoundButton.dart';
import 'package:project/widgets/custom_outLined_buttom.dart';
import 'package:project/widgets/text_widget.dart';
import 'package:provider/provider.dart';

class MisReportScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final misReportProvider =
        Provider.of<MisReportProvider>(context, listen: false);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
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
                    label: "MIS Reort",
                    textColor: ParcelColors.catalinaBlue,
                    fontWeight: FontWeight.w700,
                    fontSize: 18,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 40),
            TextField(
              controller: misReportProvider.sourceController,
              decoration: InputDecoration(
                labelText: 'Source Station',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: misReportProvider.trainNoController,
              decoration: InputDecoration(
                labelText: 'Train No',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: misReportProvider.summaryController,
              decoration: InputDecoration(
                labelText: 'Summary',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
            ),
            const SizedBox(height: 15),
            TextField(
              controller: misReportProvider.dateController,
              decoration: InputDecoration(
                labelText: 'From Date (DD/MM/YYYY)',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_today),
                  onPressed: () {
                    misReportProvider.setDateTime(context);
                  },
                ),
              ),
              readOnly: true,
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CustomButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ReportView()),
                    );
                  },
                  label: "Submit",
                ),

                // CustomButton(
                //   width: 150,
                //   title: Text(
                //     'Submit',
                //     style: const TextStyle(
                //       color: Colors.white,
                //       fontSize: 20,
                //       fontWeight: FontWeight.bold,
                //     ),
                //   ),
                //   onPressed: () {
                //     Navigator.push(
                //       context,
                //       MaterialPageRoute(
                //           builder: (context) => const ReportView()),
                //     );
                //     // ScaffoldMessenger.of(context).showSnackBar(
                //     //   const SnackBar(content: Text('Submitted')),
                //     // );
                //   },
                // ),
                CustomOutlinedButton(
                  title: 'Exit',
                  textColor: ParcelColors.brandeisblue,
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  width: 140,
                  height: 50,
                ),
              ],
            ),

            // Container(
            // padding: const EdgeInsets.all(20),
            // width: 360,
            // decoration: BoxDecoration(
            //   color: Colors.white,
            //   borderRadius: BorderRadius.circular(20),
            //   boxShadow: [
            // BoxShadow(
            //   color: Colors.grey.withOpacity(0.3),
            //   spreadRadius: 5,
            //   blurRadius: 10,
            //   offset: const Offset(0, 5),
            // ),
            //     ],
            //   ),
            //  ),
          ],
        ),
      ),
    );
  }
}
