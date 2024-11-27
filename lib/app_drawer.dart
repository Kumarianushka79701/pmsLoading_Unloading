import 'package:flutter/material.dart';
import 'package:project/utils/app_icons.dart';
import 'package:project/utils/color_extensions.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer( 
  child: ListView(
    padding: EdgeInsets.zero,
    children: <Widget>[
      DrawerHeader(
        decoration: BoxDecoration(
          color: AppColors.primary,
        ),
        child: Column(
          children: [
            Text(
              'Menu',
              style: TextStyle(
                color: AppColors.white,
                fontSize: 24,
              ),
            ),

             Image.asset(
                AppIcons.logopms,
                height: 70,
              ),
          ],

        ),
      ),
      ListTile(
        leading: Icon(Icons.home),  
        title: Text('Home'),
        onTap: () {
        },
      ),
      ListTile(
        leading: Icon(Icons.report),  // Add the report icon here
        title: Text('Mis Report'),
        onTap: () {
        },
      ),
      ListTile(
        leading: Icon(Icons.check_circle),  // Add the RR status icon here
        title: Text('RR Status'),
        onTap: () {
        },
      ),
      ListTile(
        leading: Icon(Icons.print),  // Add the print barcode icon here
        title: Text('Print barcode'),
        onTap: () {
        },
      ),
      ListTile(
        leading: Icon(Icons.delete),  // Add the delete icon here
        title: Text('Delete old data'),
        onTap: () {
        },
      ),
      ListTile(
        leading: Icon(Icons.refresh),  // Add the reload icon here
        title: Text('Reload Masters'),
        onTap: () {
        },
      ),
      ListTile(
        leading: Icon(Icons.exit_to_app),  // Add the logout icon here
        title: Text('Logout'),
        onTap: () {
        },
      ),
    ],
  ),
);}
}
