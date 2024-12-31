import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:project/api/urls.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController stationCodeController = TextEditingController();
  final TextEditingController userIDController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  late Database db;

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<void> signUp(String userId, String password, String stationCode) async {
    setLoading(true);
    _errorMessage = null;

    Uri url = Uri.parse('${AppURLs.signUpURL}/registerUser/');

    Map<String, String> body = {
      'userid': userId,
      'password': password,
      'stncode': stationCode,
      'strapptype': 'Test',
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData == true) {
          _isAuthenticated = true;
          await _saveCredentials(userId, password, stationCode);
        } else {
          _errorMessage = 'Sign-up failed: Invalid details.';
        }
      } else {
        _errorMessage = 'Failed to sign up. Try again later.';
      }
    } catch (error) {
      _errorMessage = 'Sign-up error: $error';
    } finally {
      setLoading(false);
    }
  }

  Future<void> login(String userId, String password, String stationCode) async {
    setLoading(true);
    _errorMessage = null;

    Uri url = Uri.parse('${AppURLs.loginURL}/validateUser/');

    Map<String, String> body = {
      'userid': userId,
      'password': password,
      'stncode': stationCode,
      'strapptype': 'Test',
    };

    try {
      final response = await http.post(
        url,
        headers: {'Content-Type': 'application/json; charset=UTF-8'},
        body: jsonEncode(body),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);

        if (responseData == true) {
          _isAuthenticated = true;
          await _saveCredentials(userId, password, stationCode);
        } else {
          _errorMessage = 'Invalid login credentials.';
        }
      } else {
        _errorMessage = 'Failed to log in. Try again later.';
      }
    } catch (error) {
      _errorMessage = 'Login error: $error';
    } finally {
      setLoading(false);
    }
  }

  Future<void> _saveCredentials(
      String userId, String password, String stationCode) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setStringList('credentials_$userId', [userId, password, stationCode]);
  }

  Future<List<dynamic>> fetchWagonMasterData(Map<String, dynamic> requestData) async {
    final response = await http.post(
      Uri.parse('${AppURLs.wagonMasterUrl}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(requestData),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch wagon master data.');
    }
  }

  Future<void> processWagonMasterData() async {
    try {
      Map<String, dynamic> requestData = {'APPTYPE': 'yourAppType'};
      List<dynamic> responseData = await fetchWagonMasterData(requestData);

      await db.execute('DELETE FROM M_WAGON');
      for (var item in responseData) {
        await db.insert('M_WAGON', {
          'CODE': item['code'],
          'WAGON_TYPE': item['wagon_type'],
          'CODENAME': item['codename'],
          'CAPACITY': item['capacity'],
        });
      }
    } catch (e) {
      throw Exception('Failed to process wagon master data: $e');
    }
  }

  Future<dynamic> fetchTrainDetails(Map<String, dynamic> credentials) async {
    final response = await http.post(
      Uri.parse('${AppURLs.trnDtlsUrl}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(credentials),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch train details.');
    }
  }

  Future<dynamic> fetchUserMaster(Map<String, dynamic> credentials) async {
    final response = await http.post(
      Uri.parse('${AppURLs.userMasterUrl}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(credentials),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to fetch user master data.');
    }
  }
  Future<String> runMasterMethod() async {
    try {
      // Show loader (replace this with your loader logic)
      // showLoader();

      // Call the methods sequentially
      // await getWagonMaster();
      await getUserMasterRest({"username": "AT", "password": "AT"},
          "requiredString");
      await fetchTrainDetails({"username": "AT", "password": "AT"});
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

  Future<void> getUserMasterRest(Map<String, dynamic> credentials, String requiredString) async {
    // Implement the method logic here
    final response = await http.post(
      Uri.parse('${AppURLs.userMasterUrl}'),
      headers: {'Content-Type': 'application/json'},
      body: jsonEncode(credentials),
    );

    if (response.statusCode == 200) {
      // Process the response data
      final responseData = jsonDecode(response.body);
      // Perform any additional operations with responseData if needed
    } else {
      throw Exception('Failed to fetch user master data.');
    }
  }
  Future<dynamic> makePostRequest(String url, Map<String, dynamic> body) async {
  final headers = {'Content-Type': 'application/json'};
  final response = await http.post(
    Uri.parse(url),
    headers: headers,
    body: jsonEncode(body),
  );
  if (response.statusCode == 200) {
    return jsonDecode(response.body);
  } else {
    throw Exception('Failed with status code: ${response.statusCode}');
  }
}

}
