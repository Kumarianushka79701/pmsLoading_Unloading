import 'package:flutter/material.dart';
import 'package:project/modules/auth/views/auth.dart';
import 'package:project/modules/home/views/home.dart';
import 'package:project/modules/lodingScreen/loading_screen/loading.dart';
import 'package:project/routes/app_routes.dart';


Route<dynamic> generateRoutes(RouteSettings settings) {
  switch (settings.name) {
    case Routes.HOME:
      return MaterialPageRoute(builder: (_) => const HomeScreen());
    case Routes.LOGIN:
      return MaterialPageRoute(builder: (_) => const AuthScreen());
    case Routes.LOADING_SCREEN:
      return MaterialPageRoute(builder: (_) =>  LoadigScreen());
    default:
      return MaterialPageRoute(
        builder: (_) => Scaffold(
          body: Center(
            child: Text('Undefined route: ${settings.name}'),
          ),
        ),
      );
  }
}

void main() {
  runApp(MaterialApp(
    initialRoute: Routes.HOME,
    onGenerateRoute: generateRoutes,
  ));
}
