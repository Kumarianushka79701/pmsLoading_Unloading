import 'package:flutter/material.dart';
import 'package:project/modules/auth/provider/auth_provider.dart';
import 'package:project/modules/auth/views/auth.dart';
import 'package:project/modules/forgot_account_page/provider/forgot_account_provider.dart';
import 'package:project/modules/home/provider/homeProvider.dart';
import 'package:project/modules/lodingScreen/provider/collapsible_form.dart';
import 'package:project/modules/lodingScreen/provider/loading_provider.dart';
import 'package:project/modules/providers/local_database_provider.dart';
import 'package:project/modules/providers/parcel_provider.dart';
import 'package:project/modules/providers/scan_activity_provider.dart';
import 'package:project/modules/splash.dart';
import 'package:project/modules/tabScreen/prvider/tabs_provider.dart';
import 'package:project/routes/app_pages.dart';
import 'package:project/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  // Ensure all Flutter bindings are initialized before calling async methods.
  WidgetsFlutterBinding.ensureInitialized();

 // Ensure database is initialized before running the app
  WidgetsFlutterBinding.ensureInitialized();
  final databaseProvider = LocalDatabaseProvider();
  await databaseProvider.initDatabase();

  // Print all table names
  await databaseProvider.verifyTables();

  // Print data from tables
  await databaseProvider.printTableData('parcels');
  await databaseProvider.printTableData('login_info');
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => AuthProvider()),
        ChangeNotifierProvider(create: (_) => HomeProvider()),
        ChangeNotifierProvider(create: (_) => ScanActivityProvider()),
        ChangeNotifierProvider(create: (_) => LocalDatabaseProvider()), 
        ChangeNotifierProvider(create: (_) => TabsProvider()),
        ChangeNotifierProvider(create: (_) => ParcelProvider()),
        ChangeNotifierProvider(create: (_) => ForgotAccountProvider()),
        ChangeNotifierProvider(create: (_) => LoadingProvider()),
        ChangeNotifierProvider(create: (_)=> CollapsibleFormProvider())
        
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
       initialRoute: Routes.SPLASH,
          onGenerateRoute: AppPages.generateRoutes,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
