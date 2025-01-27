import 'package:flutter/material.dart';
import 'package:project/app_drawer.dart';
import 'package:project/modules/lodingScreen/loading_screen/loading.dart';
import 'package:project/modules/databseReport/views/table.dart';
import 'package:project/modules/prrStatus/views/prr_status.dart';
import 'package:project/modules/reports/views/report_view.dart';
import 'package:project/utils/app_icons.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common_app_bar.dart';
import 'package:project/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  // Create a GlobalKey for the Scaffold
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: getAppBar(
        context,
        title: getParcelHomeAppBarTitle(context),
        actions: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: const Icon(Icons.menu),
              color: ParcelColors.white,
              onPressed: () {
                // Use the GlobalKey to open the drawer
                _scaffoldKey.currentState?.openDrawer();
              },
            ),
          ),
        ],
        onTap: () {},
      ),
      drawer: const Drawer(child: AppDrawer()),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const TextWidget(
                label: "Hi Aditi,\nGood Morning!",
                textColor: ParcelColors.catalinaBlue,
                fontSize: 18,
                fontWeight: FontWeight.w700,
              ),
              const SizedBox(
                height: 10,
              ),
              const TextWidget(
                label: "Important Information",
                textColor: ParcelColors.catalinaBlue,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: size.height * 0.02,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: size.height * 0.12,
                    width: size.width * 0.43,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ParcelColors.babyBlueEyes, width: 2),
                        color: ParcelColors.babyBlueEyes,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: const Align(
                        alignment: Alignment.center,
                        child: TextWidget(label: "(Un)\Loading Clerk Id:")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: size.height * 0.12,
                    width: size.width * 0.43,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                ParcelColors.cornFlowerblue.withOpacity(0.45),
                            width: 2),
                        color: ParcelColors.cornFlowerblue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: const Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          label: "Station Code",
                        )),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: size.height * 0.12,
                    width: size.width * 0.43,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ParcelColors.paleCornflowerBlue, width: 2),
                        color: ParcelColors.paleCornflowerBlue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: const Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          label: "Loading Sync Pending",
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: size.height * 0.12,
                    width: size.width * 0.43,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color:
                                ParcelColors.richElectricBlue.withOpacity(0.3),
                            width: 2),
                        color: ParcelColors.richElectricBlue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: const Align(
                        alignment: Alignment.center,
                        child: TextWidget(label: "UnLoading Sync Pending")),
                  ),
                ],
              ),

              SizedBox(
                height: size.height * 0.03,
              ),
              const TextWidget(
                label: "Services",
                textColor: ParcelColors.catalinaBlue,
                fontSize: 18,
                fontWeight: FontWeight.w500,
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: size.height * 0.12,
                    width: size.width * 0.43,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ParcelColors.paleCerulean.withOpacity(0.5),
                            width: 2),
                        color: ParcelColors.paleCerulean.withOpacity(0.5),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: const Align(
                        alignment: Alignment.center,
                        child: TextWidget(label: "Loading")),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: size.height * 0.12,
                    width: size.width * 0.43,
                    decoration: BoxDecoration(
                      border: Border.all(
                        color: ParcelColors.richElectricBlue
                            .withOpacity(0.5),
                        width: 2,
                      ),
                      color: ParcelColors.richElectricBlue
                          .withOpacity(0.5), 
                      borderRadius: const BorderRadius.all(Radius.circular(16)),
                    ),
                    child: const Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          label: "Unloading",
                        )),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: size.height * 0.12,
                    width: size.width * 0.43,
                    decoration: BoxDecoration(
                        border: Border.all(color: ParcelColors.areo, width: 1),
                        color: ParcelColors.areo,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: const Align(
                        alignment: Alignment.center,
                        child: TextWidget(
                          label: "PRR Status",
                        )),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: size.height * 0.12,
                    width: size.width * 0.43,
                    decoration: BoxDecoration(
                        border: Border.all(
                            color: ParcelColors.colambiaBlue, width: 2),
                        color: ParcelColors.colambiaBlue,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: const Align(
                        alignment: Alignment.center,
                        child: TextWidget(label: "Reports")),
                  ),
                ],
              ),
              // buildInfoText('Loading/Unloading Clerk Id: AT'),
              // buildInfoText('Station Code: NDLS'),
              // buildInfoText('Loading Sync Pending: 0'),
              // buildInfoText('UnLoading Sync Pending: 0'),
              const SizedBox(height: 40),
              _buildImageRow(
                context,
                'Loading',
                AppIcons.loading,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const LoadigScreen()),
                  );
                },
                secondTitle: 'UnLoading',
                secondIcon: AppIcons.unloading,
                secondOnTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PRRStatusPage(),
                    ),
                  );
                },
              ),
              const SizedBox(height: 24),
              _buildImageRow(
                context,
                'Reports',
                AppIcons.database,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => const ReportView()),
                  );
                },
                secondTitle: 'PRR Status',
                secondIcon: AppIcons.prr,
                secondOnTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const PRRStatusPage(),
                    ),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildInfoText(String text) {
    return Text(
      text,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    );
  }

  Widget _buildImageRow(
    BuildContext context,
    String title,
    String icon,
    VoidCallback onTap, {
    String? secondTitle,
    String? secondIcon,
    VoidCallback? secondOnTap,
  }) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        _buildImageColumn(context, title, icon, onTap),
        if (secondTitle != null && secondIcon != null && secondOnTap != null)
          _buildImageColumn(context, secondTitle, secondIcon, secondOnTap),
      ],
    );
  }

  Widget _buildImageColumn(
    BuildContext context,
    String title,
    String icon,
    VoidCallback onTap,
  ) {
    return Column(
      children: [
        GestureDetector(
          onTap: onTap,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(16.0),
            child: Image.asset(
              icon,
              height: 120,
              width: 120,
              fit: BoxFit.cover,
            ),
          ),
        ),
        const SizedBox(height: 10),
        Text(
          title,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ],
    );
  }
}

Widget getParcelHomeAppBarTitle(BuildContext context) {
  return const TextWidget(
    label: "PARCEL MANAGEMENT SYSTEM",
    textColor: ParcelColors.white,
    fontSize: 18,
    fontWeight: FontWeight.w700,
  );
}
