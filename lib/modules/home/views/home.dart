import 'package:flutter/material.dart';
import 'package:project/modules/lodingScreen/loading_screen/loading.dart';
import 'package:project/utils/app_icons.dart';
import 'package:project/utils/color_extensions.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        leading: Builder(
          builder: (BuildContext context) {
            return IconButton(
              icon: Icon(Icons.menu),
              onPressed: () {
                
                Scaffold.of(context).openDrawer();  // This will open the drawer
              },
            );
          },
        ),
        title: Text(
          'Parcel Management System'.toUpperCase(),
          style: TextStyle(
            color: AppColors.white,
            fontWeight: FontWeight.bold,
            fontSize: 18,
          ),
        ),
        centerTitle: true,
      ),
      drawer: Drawer(  // Add this line to define the drawer
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: AppColors.primary,
        ),
        child: Text(
          'Menu',
          style: TextStyle(
            color: AppColors.white,
            fontSize: 24,
          ),
        ),
      ),
      ListTile(
        leading: Icon(Icons.home),  
        // Add the home icon here
        title: Text('Home'),
        onTap: () {

          // Handle navigation
        },
      ),
      ListTile(
        leading: Icon(Icons.report),  // Add the report icon here
        title: Text('Mis Report'),
        onTap: () {
          // Handle navigation
        },
      ),
      ListTile(
        leading: Icon(Icons.check_circle),  // Add the RR status icon here
        title: Text('RR Status'),
        onTap: () {
          // Handle navigation
        },
      ),
      ListTile(
        leading: Icon(Icons.print),  // Add the print barcode icon here
        title: Text('Print barcode'),
        onTap: () {
          // Handle navigation
        },
      ),
      ListTile(
        leading: Icon(Icons.delete),  // Add the delete icon here
        title: Text('Delete old data'),
        onTap: () {
          // Handle navigation
        },
      ),
      ListTile(
        leading: Icon(Icons.refresh),  // Add the reload icon here
        title: Text('Reload Masters'),
        onTap: () {
          // Handle navigation
        },
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app),  // Add the logout icon here
        title: Text('Logout'),
        onTap: () {
          // Handle navigation
        },
      ),
    ],
  ),
),
 body: Stack(
        children: [
          // Background Image with Opacity
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
                          child:ClipRRect(
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
        ],
      ),
    );
  }
}
