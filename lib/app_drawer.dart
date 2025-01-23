import 'package:flutter/material.dart';
import 'package:project/routes/app_routes.dart';
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
          _buildDrawerHeader(),
          _buildDrawerItem(
            context,
            icon: Icons.home,
            title: 'Home',
            route: Routes.HOME,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.report,
            title: 'Mis Report',
            route: Routes.HOME,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.check_circle,
            title: 'RR Status',
            route: Routes.DATABSE_TABLE_SCREEN,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.print,
            title: 'Print Barcode',
            route: Routes.HOME,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.delete,
            title: 'Delete Old Data',
            route: Routes.HOME,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.refresh,
            title: 'Reload Masters',
            route: Routes.HOME,
          ),
          _buildDrawerItem(
            context,
            icon: Icons.exit_to_app,
            title: 'Logout',
            route: null, // Add logout functionality if needed
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerHeader() {
    return DrawerHeader(
      decoration: BoxDecoration(
        color: AppColors.primaryLight,
      ),
      child: Column(
        children: [
          Text(
            'Parcel Services',
            style: TextStyle(
              color: AppColors.white,
              fontSize: 24,
            ),
          ),
          Image.asset(
            AppIcons.logopms,
            height: 90,
          ),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    String? route,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      onTap: route != null
          ? () {
              Navigator.pushNamed(context, route);
            }
          : () {
              // Add logout logic or other functionality if needed
            },
    );
  }
}
