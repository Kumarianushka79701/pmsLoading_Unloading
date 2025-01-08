import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'dart:convert';
import 'dart:async';
import 'package:project/api/urls.dart';
import 'package:project/model/WagonTypeAl_model.dart';
import 'package:project/model/plateform_master_model.dart';
import 'package:project/model/user_master_rest_model.dart';
import 'package:project/model/wagon_master_model.dart';
import 'package:project/modules/auth/provider/auth_provider.dart';
import 'package:project/modules/tabScreen/views/tabs.dart';
import 'package:sqflite/sqflite.dart';
import 'package:http/http.dart' as http;

class Authservices with ChangeNotifier {
  Future<String> runMasterMethod(BuildContext context) async {
    try {
      final Database db = await openDatabase(
        'platform_master.db',
        version: 1,
        onCreate: (Database db, int version) async {
          await db.execute(
            'CREATE TABLE M_PLATFORM (CODE TEXT PRIMARY KEY, DETAIL TEXT)',
          );
        },
      );
      debugPrint("Database initialized.");

      String strapptype = 'Test';
      await getWagonMaster(db, strapptype);

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
      await getWagTypeAL({"username": "AT", "password": "AT"});
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

  Future<void> getWagonMaster(Database database, String strapptype) async {
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

        await database.execute('DELETE FROM M_WAGON');

        for (var wagon in responseData) {
          await database.insert(
            'M_WAGON',
            WagonMaster(
              code: wagon['code'],
              wagonType: wagon['wagon_type'],
              codename: wagon['codename'],
              capacity: wagon['capacity'],
            ).toMap(),
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

        // Parse response data into UserMasterRest model
        final userMasterRest = UserMasterRest.fromJson(responseData);

        // Save response data to UserLogins table
        final timestamp = DateTime.now().toIso8601String();
        await DatabaseHelper.instance.insertUserLogin({
          'username': credentials['username'] ?? 'Unknown',
          'stncode': userMasterRest.stncode,
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

  Future<void> fetchPlatformMaster(Database database, String apiUrl,
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
            PlatformMaster(
              code: platform['code'],
              detail: platform['detail'],
            ).toMap(),
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

  List<WagonTypeAl> _wagTypeData = [];
  String? _error;

  List<WagonTypeAl> get wagTypeData => _wagTypeData;
  String? get error => _error;

  Future<void> getWagTypeAL(credentials) async {
    try {
      _error = null;

      final requestBody = {
        "DETAIL": jsonEncode(credentials),
      };

      print("requestBody=${requestBody}");
      final response = await http.post(
        Uri.parse(AppURLs.wagtypeALUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );
      print('Response status code: ${response.statusCode}');

      if (response.statusCode == 200) {
        final decodedBody = jsonDecode(response.body);
        if (decodedBody is List) {
          _wagTypeData =
              decodedBody.map((data) => WagonTypeAl.fromJson(data)).toList();
          print("object=${response.body}");
        } else {
          _error = "Unexpected response format";
        }
      } else {
        _error =
            "Failed: Error in connection getWagTypeAL. Status code: ${response.statusCode}";
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

  void notifyListeners() {}
}
