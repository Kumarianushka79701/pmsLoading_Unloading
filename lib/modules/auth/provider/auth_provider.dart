import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:project/services/local_database.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  // final TextEditingController nameController = TextEditingController();
  // final TextEditingController phoneController = TextEditingController();
  final TextEditingController stationCodeController = TextEditingController();
  final TextEditingController userIDController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  final String apiBaseUrl = "https://your-api-url.com"; // Replace with your API base URL
  late Database db;

Future<void> signUp(String userId, String password, String stationCode) async {
  _isLoading = true;
  _errorMessage = null;
  notifyListeners();

  Uri url = Uri.parse(
      'https://parcel.indianrail.gov.in/PMSRestServices/services/PMSStatus/registerUser/');

  Map<String, String> body = {
    'userid': userId,
    'password': password,
    'stncode': stationCode,
    'strapptype': 'Test',
  };

  try {
    final response = await http.post(
      url,
      headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
      body: jsonEncode(body),
    );

    print('SignUp Response status: ${response.statusCode}');
    print('SignUp Response body: ${response.body}');

    if (response.statusCode == 200) {
      final responseData = jsonDecode(response.body);

      if (responseData == true) {
        _isAuthenticated = true;
        await _saveCredentials(userId, password, stationCode);
      } else {
        _errorMessage = 'Sign-up failed: Invalid details';
      }
    } else {
      _errorMessage = 'Failed to sign up';
    }
  } catch (error) {
    _errorMessage = 'Error: $error';
  } finally {
    _isLoading = false;
    notifyListeners();
  }
}

  // Method to authenticate the user
  void authenticate() {
    _isAuthenticated = true;
    notifyListeners();
  }

  // Method to log the user out
  void logout() {
    _isAuthenticated = false;
    notifyListeners();
  }
Future<void> saveLoginInfo(String userId, String password, String stationCode) async {
  // Logic to save data locally or in a database
  // Example: SharedPreferences or SQLite
  // Example using SharedPreferences:
  final prefs = await SharedPreferences.getInstance();
  await prefs.setString('userId', userId);
  await prefs.setString('password', password);
  await prefs.setString('stationCode', stationCode);
}

  // Method for logging in
  Future<void> login(String userId, String password, String stationCode) async {
    _isLoading = true;
    _errorMessage = null;
    notifyListeners();

    Uri url = Uri.parse(
        'https://parcel.indianrail.gov.in/PMSRestServices/services/PMSStatus/validateUser/');

    Map<String, String> body = {
      'userid': userId,
      'password': password,
      'stncode': stationCode,
      'strapptype': 'Test',
    };

    try {
      final response = await http.post(
        url,
        headers: <String, String>{'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(body),
      );

      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('Response data: $responseData');

        if (responseData == true) {
          _isAuthenticated = true;
          await _saveCredentials(userId, password, stationCode);
        } else {
          _errorMessage = 'Invalid credentials';
        }
      } else {
        _errorMessage = 'Failed to login';
      }
    } catch (error) {
      _errorMessage = 'Error: $error';
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }

  Future<void> _saveCredentials(String userId, String password, String stationCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('credentials_$userId', [userId, password, stationCode]);
  }
  
  Future<String> runMasterMethod() async {
  try {
    // Show loader (replace this with your loader logic)
    // showLoader();

    // Call the methods sequentially
    await getWagonMaster();
    await getUserMasterRest();
    // await getPlatformMaster();
    // await getWagTypeAL();
    // await getRailwayAL();
    // await getPkgCondnMaster();
    // await getStationDetailRest();
    // await getMPkgDesc();

    // Return success after all methods are completed
    return "success";
  } catch (e) {
    // Handle errors and return failure message
    debugPrint("Error in runMasterMethod: $e");
    return "failed: Error in service";
  }
}
 Future<List<dynamic>> getWagonMasterFromAPI(Map<String, dynamic> requestData) async {
    final response = await http.post(
      Uri.parse('$apiBaseUrl/getWagonMaster'),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("Failed to fetch wagon master data");
    }
  }

  // Clear and insert data into the database
  Future<void> getWagonMaster() async {
    try {
      Map<String, dynamic> apptypeData = {"APPTYPE": "yourAppType"}; // Replace with actual data
      Map<String, dynamic> apptypeDatadetail = {"DETAIL": apptypeData};

      // Fetch data from API
      List<dynamic> responseData = await getWagonMasterFromAPI(apptypeDatadetail);

      // Clear existing table
      await db.execute('DELETE FROM M_WAGON');

      // Insert new data
      for (var item in responseData) {
        await db.insert('M_WAGON', {
          "CODE": item['code'],
          "WAGON_TYPE": item['wagon_type'],
          "CODENAME": item['codename'],
          "CAPACITY": item['capacity'],
        });
      }
    } catch (e) {
      throw Exception("Failed to process wagon master data: $e");
    }
  }


Future<void> getUserMasterRest() async {
  // Your API or logic here
  await Future.delayed(Duration(seconds: 1)); // Simulating API call
  debugPrint("getUserMasterRest called");
}

// Repeat similar methods for the other calls...

}
