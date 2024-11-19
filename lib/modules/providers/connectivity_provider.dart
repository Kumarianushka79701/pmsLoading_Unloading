import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ConnectivityProvider extends ChangeNotifier {
  bool _isConnected = true;

  bool get isConnected => _isConnected;

  // ConnectivityProvider() {
  //   _init();
  // }

  // Initialize connectivity monitoring
  // Future<void> _init() async {
  //   // Initial connectivity check
  //   ConnectivityResult initialResult = await Connectivity().checkConnectivity();
  //   _isConnected = initialResult != ConnectivityResult.none;

  //   // Notify listeners about the initial connection status
  //   notifyListeners();

  //   // Listen for connectivity changes
  //   Connectivity().onConnectivityChanged.listen((ConnectivityResult result) {
  //     _isConnected = result != ConnectivityResult.none;
  //     notifyListeners();
  //   });
  // }
}

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => ConnectivityProvider(),
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: ConnectivityScreen(),
    );
  }
}

class ConnectivityScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Connectivity Monitor')),
      body: Center(
        child: Consumer<ConnectivityProvider>(
          builder: (context, provider, child) {
            return Text(
              provider.isConnected ? 'Connected to the internet' : 'No internet connection',
              style: TextStyle(fontSize: 20),
            );
          },
        ),
      ),
    );
  }
}
