import 'package:flutter/material.dart';
import 'package:project/app_drawer.dart';
import 'package:project/modules/lodingScreen/loading_screen/loading.dart';
import 'package:project/modules/databseReport/views/table.dart';
import 'package:project/modules/prrStatus/views/prr_status.dart';
import 'package:project/modules/reports/views/report_view.dart';
import 'package:project/utils/app_icons.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common_app_bar%20copy.dart';
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
    return Scaffold(
      key: _scaffoldKey, // Assign the GlobalKey to the Scaffold
      appBar: getAppBar(
        context,
        title: getParcelHomeAppBarTitle(context),
        actions: [
          Align(
            alignment: Alignment.topLeft,
            child: IconButton(
              icon: Icon(Icons.menu),
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
      drawer: Drawer(child: AppDrawer()),
      body: Stack(
        children: [
          Positioned.fill(
            child: Opacity(
              opacity: 0.1, // Adjust opacity here
              child: Image.asset(
                AppIcons.pmsLogoTwo, // Ensure this path is correct
                fit: BoxFit.cover,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildInfoText('Loading/Unloading Clerk Id: AT'),
                  _buildInfoText('Station Code: NDLS'),
                  _buildInfoText('Loading Sync Pending: 0'),
                  _buildInfoText('UnLoading Sync Pending: 0'),
                  const SizedBox(height: 40),
                 
                   _buildImageRow(
                    context,
                    'Loading',
                    AppIcons.loading,
                    () {
                       Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoadigScreen()),
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
                        MaterialPageRoute(builder: (context) => ReportView()),
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
        ],
      ),
    );
  }

  Widget _buildInfoText(String text) {
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
