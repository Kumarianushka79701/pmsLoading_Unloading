import 'package:flutter/material.dart';
import 'package:project/modules/form.dart';
import 'package:project/modules/home/views/home.dart';
import 'package:project/modules/scan.dart';
import 'package:project/modules/tabScreen/prvider/tabs_provider.dart';
import 'package:project/modules/table.dart';
import 'package:project/utils/color_extensions.dart';
import 'package:project/widgets/app_drawer.dart';
import 'package:provider/provider.dart';

/// TabsProvider to manage the selected tab index
class TabsScreen extends StatelessWidget {
  const TabsScreen({super.key});

  // List of widgets corresponding to each screen
  static const List<Widget> _screens = <Widget>[
    HomeScreen(),
    TableScreen(),
    ScanScreen(),
    FormScreen(),
  ];

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => TabsProvider(),
      child: Consumer<TabsProvider>(
        builder: (context, tabsProvider, child) {
          return Scaffold(
            drawer: const AppDrawer(),
            body: _screens[tabsProvider.selectedIndex],
            bottomNavigationBar: Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    spreadRadius: 1,
                    blurRadius: 10,
                    offset: const Offset(0, -1),
                  ),
                ],
              ),
              child: BottomNavigationBar(
                onTap: (index) => tabsProvider.setTabIndex(index,4),
                currentIndex: tabsProvider.selectedIndex,
                selectedItemColor: AppColors.black,
                unselectedItemColor: AppColors.lightGrey,
                items: const [
                  BottomNavigationBarItem(
                    icon: Icon(Icons.home),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.data_object),
                    label: 'Table',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.qr_code_2_outlined),
                    label: 'Scan',
                  ),
                  BottomNavigationBarItem(
                    icon: Icon(Icons.edit),
                    label: 'Manual',
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}





// import 'package:flutter/material.dart';
// import 'package:project/modules/form.dart';
// import 'package:project/modules/home/views/home.dart';
// import 'package:project/modules/scan.dart';
// import 'package:project/modules/tabScreen/prvider/tabs_provider.dart';
// import 'package:project/modules/table.dart';
// import 'package:project/utils/color_extensions.dart';
// import 'package:project/widgets/app_drawer.dart';
// import 'package:provider/provider.dart';

// /// TabsProvider to manage the selected tab index


// class TabsScreen extends StatelessWidget {
//   const TabsScreen({super.key});

//   // List of widgets corresponding to each screen
//   static const List<Widget> _screens = <Widget>[
//     HomeScreen(),
//      TableScreen(),
//      ScanScreen(),
//      FormScreen(),
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return ChangeNotifierProvider(
//       create: (_) => TabsProvider(),
//       child: Scaffold(
//         drawer: const AppDrawer(),
//         body: Consumer<TabsProvider>(
//           builder: (context, tabsProvider, child) {
//             return _screens[tabsProvider.selectedIndex];
//           },
//         ),
//         bottomNavigationBar: Consumer<TabsProvider>(
//           builder: (context, tabsProvider, child) {
//             return Container(
//               decoration: BoxDecoration(
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black.withOpacity(0.1),
//                     spreadRadius: 1,
//                     blurRadius: 10,
//                     offset: const Offset(0, -1),
//                   ),
//                 ],
//               ),
//               child: BottomNavigationBar(
//                 onTap: (index) => tabsProvider.setTabIndex(index,4),
//                 currentIndex: tabsProvider.selectedIndex,
//                 selectedItemColor: AppColors.black,
//                 unselectedItemColor: AppColors.lightGrey,
//                 items: const [
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.home),
//                     label: 'Home',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.data_object),
//                     label: 'Table',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.qr_code_2_outlined),
//                     label: 'Scan',
//                   ),
//                   BottomNavigationBarItem(
//                     icon: Icon(Icons.edit),
//                     label: 'Manual',
//                   ),
//                 ],
//               ),
//             );
//           },
//         ),
//       ),
//     );
//   }
// }
