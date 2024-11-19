import 'package:flutter/material.dart';
import 'package:project/modules/auth/provider/auth_provider.dart';
import 'package:project/modules/home/provider/homeProvider.dart';
import 'package:project/modules/providers/local_database_provider.dart';
import 'package:project/modules/providers/parcel_provider.dart';
import 'package:project/modules/providers/scan_activity_provider.dart';
import 'package:project/modules/splash.dart';
import 'package:project/modules/tabScreen/prvider/tabs_provider.dart';
import 'package:project/modules/tabScreen/views/tabs.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ScanActivityProvider()),
        ChangeNotifierProvider(create: (_) => LocalDatabaseProvider()),
        ChangeNotifierProvider(create: (_) => TabsProvider()),
        ChangeNotifierProvider(create: (_) => ParcelProvider()),
        

        
// Provide AuthProvider
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const TabsScreen(),
      ),
    );
  }
}
