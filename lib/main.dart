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

void main() async {
  // Ensure all Flutter bindings are initialized before calling async methods.
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize the LocalDatabaseProvider
  final localDatabaseProvider = LocalDatabaseProvider();
  await localDatabaseProvider.init(); // Ensure database is initialized before running the app

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ScanActivityProvider()),
        ChangeNotifierProvider(create: (_) => localDatabaseProvider), // Use the initialized provider
        ChangeNotifierProvider(create: (_) => TabsProvider()),
        ChangeNotifierProvider(create: (_) => ParcelProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const TabsScreen(),
    );
  }
}
