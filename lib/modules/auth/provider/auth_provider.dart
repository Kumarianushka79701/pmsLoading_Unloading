import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

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
}