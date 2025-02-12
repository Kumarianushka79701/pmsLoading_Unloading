import 'package:flutter/material.dart';
import 'package:project/modules/auth/provider/auth_provider.dart';
import 'package:project/modules/forgot_account_page/provider/forgot_account_provider.dart';
import 'package:project/modules/home/provider/homeProvider.dart';
import 'package:project/modules/lodingScreen/provider/collapsible_form.dart';
import 'package:project/modules/lodingScreen/provider/loading_provider.dart';
import 'package:project/modules/mis_report/provider/mis_report_provider.dart';
import 'package:project/modules/providers/local_database_provider.dart';
import 'package:project/modules/providers/parcel_provider.dart';
import 'package:project/modules/providers/scan_activity_provider.dart';
import 'package:project/modules/prrStatus/provider/prr_status_Provider.dart';
import 'package:project/modules/splash.dart';
import 'package:project/modules/tabScreen/prvider/tabs_provider.dart';
import 'package:project/modules/unLoading/providers/unloading_provider.dart';
import 'package:project/routes/app_pages.dart';
import 'package:project/routes/app_routes.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  WidgetsFlutterBinding.ensureInitialized();
  final databaseProvider = LocalDatabaseProvider();
  await databaseProvider.initDatabase();

  await databaseProvider.verifyTables();

  await databaseProvider.printTableData('parcels');
  await databaseProvider.printTableData('ACTUALLOAD');
  await databaseProvider.printTableData('userlogins');
  await databaseProvider.printTableData('loading');
  await databaseProvider.printTableData('loading_dtl');
  await databaseProvider.printTableData('addPrrPwb');
  await databaseProvider.printTableData('saveManualData');
  await databaseProvider.printTableData('ACT_LOADTLS_FALLBACK');
  await databaseProvider.printTableData('OFFLINE_SUMMARY_DTLS');
  await databaseProvider.printTableData('M_STN');
  await databaseProvider.printTableData('M_TRAIN');
  await databaseProvider.printTableData('M_TRNDTLS');
  await databaseProvider.printTableData('M_USERID');
  await databaseProvider.printTableData('M_RLY');
  await databaseProvider.printTableData('M_PLATFORM');
  await databaseProvider.printTableData('M_WAGTYPE');
  await databaseProvider.printTableData('M_PKG_DESC');
  await databaseProvider.printTableData('M_PKGCONDN');
  await databaseProvider.printTableData('M_WAGON');
  await databaseProvider.printTableData('M_STATION_DETAIL');


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
        ChangeNotifierProvider(create: (_) => CollapsibleFormProvider()),
        ChangeNotifierProvider(create: (_) => PrrStatusProvider()),
        ChangeNotifierProvider(create: (_) => MisReportProvider()),
        ChangeNotifierProvider(create: (_) => UnloadingSummaryProvider()),
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
      title: 'LoadingUloading',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const SplashScreen(),
    );
  }
}
