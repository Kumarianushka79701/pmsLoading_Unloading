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
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    final authProvider = Provider.of<AuthProvider>(context);
    final size = MediaQuery.of(context).size;
    final loginApiResponse =
        Provider.of<AuthProvider>(context).loginApiResponse;

    return Scaffold(
      key: _scaffoldKey,
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
              GridView.builder(
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: (size.width * 0.43) / (size.height * 0.12),
                ),
                itemCount: authProvider.gridItems.length,
                itemBuilder: (context, index) {
                  final item = authProvider.gridItems[index];
                  return Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: item['color'],
                      borderRadius: BorderRadius.all(Radius.circular(16)),
                    ),
                    child: Align(
                      alignment: Alignment.center,
                      child: RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: item['title'],
                          style: TextStyle(
                            fontSize: 10.0,
                            fontWeight: FontWeight.w600,
                            color: ParcelColors.brandeisblue,
                          ),
                          children: [
                            TextSpan(
                              text: '\n${item['subtitle']}',
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
                  );
                },
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

              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: authProvider.services.length,
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 1.8,
                ),
                itemBuilder: (context, index) {
                  final service = authProvider.services[index];
                  return InkWell(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => service["screen"]),
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(14),
                      decoration: BoxDecoration(
                        color: service["color"],
                        borderRadius:
                            const BorderRadius.all(Radius.circular(16)),
                      ),
                      child: Align(
                        alignment: Alignment.center,
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(service["icon"], size: 29),
                            TextWidget(label: service["label"]),
                          ],
                        ),
                      ),
                    ),
                  );
                },
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
