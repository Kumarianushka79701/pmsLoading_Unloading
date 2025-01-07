import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:project/api/urls.dart';
import 'package:project/modules/tabScreen/views/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

// Ensure that DatabaseHelper is defined and imported correctly
class DatabaseHelper {
  static final DatabaseHelper instance = DatabaseHelper._init();
  DatabaseHelper._init();

  Future<void> insertUserLogin(Map<String, dynamic> data) async {
    // Implement the method to insert user login data into the database
  }
}

class AuthProvider with ChangeNotifier {
  bool _isAuthenticated = false;
  bool _isLoading = false;
  String? _errorMessage;
  Database? database;

  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final TextEditingController stationCodeController = TextEditingController();
  final TextEditingController userIDController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  bool get isAuthenticated => _isAuthenticated;
  bool get isLoading => _isLoading;
  String? get errorMessage => _errorMessage;

  late Database db;

  Future<void> initializeDatabase() async {
    db = await _initDatabase();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
  }

  Future<Database> _initDatabase() async {
    return await openDatabase(
      join(await getDatabasesPath(), 'app_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE M_WAGON(CODE TEXT PRIMARY KEY, WAGON_TYPE TEXT, CODENAME TEXT, CAPACITY INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> signUp(
      String userId, String password, String stationCode) async {
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
    await prefs
        .setStringList('credentials_$userId', [userId, password, stationCode]);
  }

  Future<List<dynamic>> fetchWagonMasterData(
      Map<String, dynamic> requestData) async {
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

  Future<String> runMasterMethod(BuildContext context) async {
    try {
      final Database db = await openDatabase(
        'platform_master.db',
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE M_PLATFORM (CODE TEXT PRIMARY KEY, DETAIL TEXT)',
          );

          // Add any other tables required here
        },
      );
      debugPrint("Database initialized.");

      String strapptype = 'Test';
      await getWagonMaster(strapptype);

      final apiUrl = AppURLs.plateformMasterUrl;
      final appTypeDataDetail = {"APPTYPE": "Online"};
      await getPlatformMaster(db, apiUrl, appTypeDataDetail);

      await getUserMasterRest(
        {"username": "AT", "password": "AT"},
        "requiredString",
        context,
      );

      // Uncomment additional calls as needed and ensure their dependencies are handled
      // await fetchTrainDetails({"username": "AT", "password": "AT"});
      await getWagTypeAL( {"username": "AT", "password": "AT"});
      // await getRailwayAL();
      // await getPkgCondnMaster();
      // await getStationDetailRest();
      // await getMPkgDesc();

      return "success";
    } catch (e) {
      debugPrint("Error in runMasterMethod: $e");
      return "failed: Error in service";
    }
  }

  Future<void> getWagonMaster(String strapptype) async {
    const String apiUrl = AppURLs.wagonMasterUrl; // Replace with the actual URL

    final Map<String, dynamic> requestBody = {
      "DETAIL": {"APPTYPE": strapptype}
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        print('API Responsesssss: $responseData');

        await database?.execute('DELETE FROM M_WAGON');

        for (var wagon in responseData) {
          await database?.insert(
            'M_WAGON',
            {
              'CODE': wagon['code'],
              'WAGON_TYPE': wagon['wagon_type'],
              'CODENAME': wagon['codename'],
              'CAPACITY': wagon['capacity'],
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
        print('Data successfully inserted into M_WAGON.');
      } else {
        throw Exception(
            'Failed to fetch wagon master data. Status: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getWagonMaster: $e');
      throw Exception('Error in fetching wagon master data: $e');
    }
  }

  Future<void> getUserMasterRest(Map<String, dynamic> credentials,
      String requiredString, BuildContext context) async {
    final url = Uri.parse(AppURLs.userMasterUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          "Content-Type": "application/json",
        },
        body: jsonEncode({
          "credentials": credentials,
          "requiredString": requiredString,
          "detail": {
            "stncode": "_NDLS",
            "strapptype": "Online",
          },
        }),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        print('User Master Response: $responseData');

        // Save response data to UserLogins table
        final timestamp = DateTime.now().toIso8601String();
        await DatabaseHelper.instance.insertUserLogin({
          'username': credentials['username'] ?? 'Unknown',
          'stncode': "_NDLS",
          'strapptype': "Online",
          'timestamp': timestamp,
        });

        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => TabsScreen()),
        );
      } else {
        throw Exception(
            'Failed to fetch user master data. Status Code: ${response.statusCode}');
      }
    } catch (e) {
      print('Error in getUserMasterRest: $e');
      throw Exception('Failed to fetch user master data: $e');
    }
  }

Future<void> getPlatformMaster(Database database, String apiUrl,
    Map<String, dynamic> appTypeDataDetail) async {
  print('Starting getPlatformMaster...');
  try {
    print('API URL: $apiUrl');

    final requestBody = {
      "DETAIL": jsonEncode(appTypeDataDetail),
    };

    print('Request Body: $requestBody');

    final response = await http.post(
      Uri.parse(apiUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    print('Response status code: ${response.statusCode}');
    print('Response body: ${response.body}');

    if (response.statusCode == 200) {
      final List<dynamic>? responseData =
          jsonDecode(response.body) as List<dynamic>?;

      if (responseData == null || responseData.isEmpty) {
        print('Empty or invalid response data received.');
        throw Exception('Invalid response format.');
      }

      print('API Response of platform: $responseData');

      await database.execute('DELETE FROM M_PLATFORM');
      print('M_PLATFORM table cleared.');

      for (final platform in responseData) {
        if (platform['code'] == null || platform['detail'] == null) {
          print('Invalid platform data skipped: $platform');
          continue;
        }

        await database.insert(
          'M_PLATFORM',
          {
            'CODE': platform['code'],
            'DETAIL': platform['detail'],
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );
      }
      print('Data successfully inserted into M_PLATFORM.');
    } else {
      throw Exception(
        'Failed to fetch platform master data. HTTP Status: ${response.statusCode}. Response body: ${response.body}',
      );
    }
  } catch (e) {
    print('Error in getPlatformMaster: $e');
    rethrow;
  }
}

List<Map<String, dynamic>> _wagTypeData = [];
String? _error;

List<Map<String, dynamic>> get wagTypeData => _wagTypeData;
String? get error => _error;

Future<void> getWagTypeAL(credentials) async {
  try {
    _error = null;

    final requestBody = {
      "DETAIL": jsonEncode(credentials),
    };

print("requestBody=${requestBody}");
    final response = await http
        .post(
          Uri.parse(AppURLs.wagtypeALUrl),
          headers: {"Content-Type": "application/json"},
          body: jsonEncode(requestBody),
        );
    print('Response status code: ${response.statusCode}');


    if (response.statusCode == 200) {
      final decodedBody = jsonDecode(response.body);
      if (decodedBody is List) {
        _wagTypeData = List<Map<String, dynamic>>.from(decodedBody);
        print("object=${response.body}");
      } else {
        _error = "Unexpected response format";
      }
    } else {
      _error = "Failed: Error in connection getWagTypeAL. Status code: ${response.statusCode}";
    }
  } catch (e) {
    if (e is FormatException) {
      _error = "Failed: Malformed response from the server";
    } else if (e is SocketException) {
      _error = "Failed: Unable to connect to the server";
    } else if (e is TimeoutException) {
      _error = "Failed: Connection timeout";
    } else {
      _error = "Failed: Unexpected error occurred";
    }
  } finally {
    notifyListeners();
  }
}




}
//   Future<dynamic> makePostRequest(String url, Map<String, dynamic> body) async {
//   final headers = {'Content-Type': 'application/json'};
//   final response = await http.post(
//     Uri.parse(url),
//     headers: headers,
//     body: jsonEncode(body),
//   );
//   if (response.statusCode == 200) {
//     return jsonDecode(response.body);
//   } else {
//     throw Exception('Failed with status code: ${response.statusCode}');
//   }
// }


