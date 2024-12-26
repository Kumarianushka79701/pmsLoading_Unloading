import 'package:flutter/material.dart';
import 'package:project/modules/auth/views/auth.dart';
import 'package:project/modules/databseReport/views/table.dart';
import 'package:project/modules/forgot_account_page/views/forgot_account_view.dart';
import 'package:project/modules/home/views/home.dart';
import 'package:project/modules/lodingScreen/loading_screen/loading.dart';
import 'package:project/modules/splash.dart';
import 'package:project/routes/app_routes.dart';

class AppPages {
  static String? _lastRoute = "/";
  static Route<dynamic> generateRoutes(RouteSettings setting) {
    print("My Route is $_lastRoute");
    _lastRoute = setting.name;

    switch (setting.name) {
      case Routes.SPLASH:
        return MaterialPageRoute(
          settings: setting,
          builder: (_) => const SplashScreen(),
        );
      case Routes.LOGIN:
        return MaterialPageRoute(
          settings: setting,
          builder: (_) =>  AuthScreen(),
        );
      case Routes.HOME:
        final arguments = setting.arguments as Map<String, dynamic>?; // Use nullable type
        return MaterialPageRoute(
          settings: setting,
          builder: (_) => const HomeScreen(),
        );
      case Routes.DATABSE_TABLE_SCREEN:
        final arguments = setting.arguments as Map<String, dynamic>?; // Use nullable type
        return MaterialPageRoute(
          settings: setting,
          builder: (_) => const TableScreen(),
        );
      case Routes.LOADING_SCREEN:
        final arguments = setting.arguments as Map<String, dynamic>?; // Use nullable type
        return MaterialPageRoute(
          settings: setting,
          builder: (_) => const LoadigScreen(),
        );
      case Routes.FORGOT_ACCOUNT_PAGE:
        final arguments = setting.arguments as Map<String, dynamic>?; // Use nullable type
        return MaterialPageRoute(
          settings: setting,
          builder: (_) => const ForgotAccountView(),
        );
      default:
        return MaterialPageRoute(
          settings: setting,
          builder: (_) =>  AuthScreen(),
        );
    }
  }

  static String? get lastRoute => _lastRoute;
}
