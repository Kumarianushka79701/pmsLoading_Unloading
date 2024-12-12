import 'package:flutter/material.dart';
import 'package:project/app_drawer.dart';
import 'package:project/modules/lodingScreen/loading_screen/loading.dart';
import 'package:project/modules/databseReport/views/table.dart';
import 'package:project/utils/app_icons.dart';
import 'package:project/utils/colors.dart';
import 'package:project/widgets/common_app_bar%20copy.dart';
import 'package:project/widgets/text_widget.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: getAppBar(context,
          title: getParcelHomeAppBarTitle(context),
          actions: [
            Align(
              alignment: Alignment.topLeft,
              child: IconButton(
                icon: Icon(Icons.menu),
                color: ParcelColors.white,
                onPressed: () {
                  Scaffold.of(context).openDrawer();
                },
              ),
            ),
          ], onTap: () {
      }),
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
          // Content
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Loading/Unloading Clerk Id: AT',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    'Station Code: NDLS',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    'Loading Sync Pending: 0',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  Text(
                    'UnLoading Sync Pending: 0',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.black),
                  ),
                  SizedBox(height: 40),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => LoadigScreen()),
                              );
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Adjust the radius for smooth corners
                              child: Image.asset(
                                AppIcons.loading,
                                height: 120,
                                width: 120, // Ensure this path is correct
                                fit: BoxFit
                                    .cover, // Optional: to make the image fill the box
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Loading',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Action for Unloading
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Adjust the radius for smooth corners
                              child: Image.asset(
                                AppIcons.unloading,
                                height: 120,
                                width: 120, // Ensure this path is correct
                                fit: BoxFit
                                    .cover, // Optional: to make the image fill the box
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Unloading',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => TableScreen(),
                                ),
                              );
                              // Action for Reports
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Adjust the radius for smooth corners
                              child: Image.asset(
                                AppIcons.database,
                                height: 120,
                                width: 120, // Ensure this path is correct
                                fit: BoxFit
                                    .cover, // Optional: to make the image fill the box
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'Reports',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          GestureDetector(
                            onTap: () {
                              // Action for PRR Status
                            },
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  16.0), // Adjust the radius for smooth corners
                              child: Image.asset(
                                AppIcons.prr,
                                height: 120,
                                width: 120, // Ensure this path is correct
                                fit: BoxFit
                                    .cover, // Optional: to make the image fill the box
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          Text(
                            'PRR Status',
                            style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Colors.black),
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
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
