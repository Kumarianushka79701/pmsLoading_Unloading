import 'package:flutter/material.dart';
import 'package:project/app_drawer.dart';
import 'package:project/modules/auth/provider/auth_provider.dart';
import 'package:project/modules/lodingScreen/loading_screen/loading.dart';
import 'package:project/modules/databseReport/views/table.dart';
import 'package:project/modules/mis_report/views/mis_report.dart';
import 'package:project/modules/prrStatus/views/prr_status.dart';
import 'package:project/modules/reports/views/report_view.dart';
import 'package:project/modules/unLoading/views/unloading_view.dart';
import 'package:project/utils/app_icons.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common_app_bar.dart';
import 'package:project/widgets/text_widget.dart';
import 'package:provider/provider.dart';

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
    final authProvider = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size;
    final loginApiResponse =
        Provider.of<AuthProvider>(context).loginApiResponse;

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
              // loginApiResponse == null
              //     ? Text('No response available yet.')
              //     : Text(
              //         'Response: ${loginApiResponse == null.toString()}',
              //         style: TextStyle(fontSize: 16),
              //       ),

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
                        // border: Border.all(
                        //     color: ParcelColors.babyBlueEyes, width: 2),
                        color: ParcelColors.babyBlueEyes,
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: const TextSpan(
                            text: '(Un)\Loading Clerk Id: ',
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                                color: ParcelColors.brandeisblue),
                            children: [
                              TextSpan(
                                text: '\nAT ',
                                style: TextStyle(
                                    fontSize: 22,
                                    fontWeight: FontWeight.w700,
                                    color: ParcelColors.brandeisblue),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Container(
                      padding: const EdgeInsets.all(14),
                      height: size.height * 0.12,
                      width: size.width * 0.43,
                      decoration: BoxDecoration(
                          // border: Border.all(
                          //     color:
                          //         ParcelColors.cornFlowerblue.withOpacity(0.45),
                          //     width: 1),
                          color: ParcelColors.cornFlowerblue.withOpacity(0.45),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16))),
                      child: Align(
                        alignment: Alignment.center,
                        child: RichText(
                          text: const TextSpan(
                            text: 'Station Code ',
                            style: TextStyle(
                                fontSize: 10.0,
                                fontWeight: FontWeight.w600,
                                color: ParcelColors.brandeisblue),
                            children: [
                              TextSpan(
                                text: '\nNDLS',
                                style: TextStyle(
                                  fontSize: 22,
                                  fontWeight: FontWeight.w700,
                                  color: ParcelColors.brandeisblue,
                                ),
                              ),
                            ],
                          ),
                        ),
                      )),
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
                        // border: Border.all(
                        //     color: ParcelColors.paleCornflowerBlue, width: 1),
                        color:
                            ParcelColors.paleCornflowerBlue.withOpacity(0.45),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: const TextSpan(
                          text: 'Loading Sync Pending',
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                              color: ParcelColors.brandeisblue),
                          children: [
                            TextSpan(
                              text: '\n0',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: ParcelColors.brandeisblue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(14),
                    height: size.height * 0.12,
                    width: size.width * 0.43,
                    decoration: BoxDecoration(
                        color: ParcelColors.richElectricBlue.withOpacity(0.37),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16))),
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        text: const TextSpan(
                          text: 'UnLoading Sync Pending',
                          style: TextStyle(
                              fontSize: 10.0,
                              fontWeight: FontWeight.w600,
                              color: ParcelColors.brandeisblue),
                          children: [
                            TextSpan(
                              text: '\n0',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                color: ParcelColors.brandeisblue,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
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
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const LoadigScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      height: size.height * 0.12,
                      width: size.width * 0.43,
                      decoration: BoxDecoration(
                          color: ParcelColors.paleCerulean.withOpacity(0.5),
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16))),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Icon(
                                Icons.add_box,
                                size: 29,
                              ),
                              TextWidget(label: "Loading"),
                            ],
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => UnloadingSummaryScreen(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      height: size.height * 0.12,
                      width: size.width * 0.43,
                      decoration: BoxDecoration(
                        // border: Border.all(
                        //   color: ParcelColors.richElectricBlue.withOpacity(0.5),
                        //   width: 2,
                        // ),
                        color: ParcelColors.richElectricBlue.withOpacity(0.50),
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Icon(
                                Icons.inventory,
                                size: 29,
                              ),
                              TextWidget(
                                label: "Unloading",
                              ),
                            ],
                          )),
                    ),
                  )
                ],
              ),
              SizedBox(
                height: size.height * 0.01,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PRRStatusPage(),
                        ),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      height: size.height * 0.12,
                      width: size.width * 0.43,
                      decoration: BoxDecoration(
                          // border: Border.all(color: ParcelColors.areo, width: 2),
                          color: ParcelColors.areo,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16))),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Icon(
                                Icons.search,
                                size: 29,
                              ),
                              TextWidget(
                                label: "PRR Status",
                              ),
                            ],
                          )),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MisReportScreen()),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      height: size.height * 0.12,
                      width: size.width * 0.43,
                      decoration: BoxDecoration(
                          // border: Border.all(
                          //     color: ParcelColors.colambiaBlue, width: 2),
                          color: ParcelColors.colambiaBlue,
                          borderRadius:
                              const BorderRadius.all(Radius.circular(16))),
                      child: const Align(
                          alignment: Alignment.center,
                          child: Column(
                            children: [
                              Icon(
                                Icons.description,
                                size: 29,
                              ),
                              TextWidget(label: "Reports"),
                            ],
                          )),
                    ),
                  ),
                ],
              ),
              // buildInfoText('Loading/Unloading Clerk Id: AT'),
              // buildInfoText('Station Code: NDLS'),
              // buildInfoText('Loading Sync Pending: 0'),
              // buildInfoText('UnLoading Sync Pending: 0'),
            ],
          ),
        ),
      ),
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
