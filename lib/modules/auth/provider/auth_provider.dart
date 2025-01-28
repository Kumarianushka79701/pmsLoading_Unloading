import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';
import 'package:project/api/urls.dart';
import 'package:project/model/WagonTypeAl_model.dart';
import 'package:project/modules/tabScreen/views/tabs.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:sqflite/sqflite.dart';

class LocalDatabaseHelper {
  static final LocalDatabaseHelper _instance = LocalDatabaseHelper._internal();
  static Database? _database;

  LocalDatabaseHelper._internal();

  factory LocalDatabaseHelper() {
    return _instance;
  }

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'local_app_database.db');

    return await openDatabase(
      path,
      version: 2, // Incremented version for changes
      onCreate: (db, version) async {
        await _createTables(db);
      },
      onUpgrade: (db, oldVersion, newVersion) async {
        if (oldVersion < 2) {
          await _createTables(db); // Add new tables if upgrading
        }
      },
    );
  }

  Future<void> _createTables(Database db) async {
    // Existing Tables
    await db.execute('''
      CREATE TABLE IF NOT EXISTS M_PLATFORM (
        CODE TEXT PRIMARY KEY,
        DETAIL TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS M_WAGON (
        CODE TEXT PRIMARY KEY,
        WAGON_TYPE TEXT,
        CODENAME TEXT,
        CAPACITY INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS M_PKG_DESC (
        SL_NO TEXT PRIMARY KEY,
        PKG_DESC TEXT NOT NULL
      )
    ''');

    // New Table: StationDetails
    await db.execute('''
      CREATE TABLE IF NOT EXISTS M_STATION_DETAIL (
        ID INTEGER PRIMARY KEY AUTOINCREMENT,
        STATE TEXT,
        TOT_PLTFRMS INTEGER,
        PBOOKING INTEGER,
        JUNCTION_STN_FLAG INTEGER,
        RLY_CODE TEXT,
        SCTN TEXT,
        STN_CLASS TEXT,
        WHARF_RATE_TYPE TEXT,
        EXTRA_OUT_CHRG_REASON TEXT,
        GAUGE TEXT,
        DETAIL TEXT,
        DIST_CODE TEXT,
        EXTRA_OUT_CHRG REAL,
        SRV TEXT,
        PRICEOFINITIALWT REAL,
        CODE TEXT,
        CODENAME TEXT,
        TRANSHMNT_STN INTEGER,
        OUTAGENCY INTEGER,
        AREA TEXT,
        POLICE_VI TEXT,
        OA_PRO_ADDR TEXT,
        INITIALWT REAL,
        DIV_NO TEXT,
        PRICEOFADDLWT REAL,
        WHARF_SLAB INTEGER,
        ZONE INTEGER,
        CRIS_STNNO INTEGER,
        DIV_CODE TEXT,
        RPF_I TEXT,
        SQUARE TEXT,
        OA_PROP_NAME TEXT,
        STN_NUMBER TEXT,
        ADDLWT REAL,
        ADD3 TEXT,
        ADD2 TEXT,
        ADD1 TEXT
      )
    ''');
  }

  Future<void> insert(String table, Map<String, dynamic> values) async {
    final db = await database;
    await db.insert(
      table,
      values,
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<void> deleteTable(String table) async {
    final db = await database;
    await db.delete(table);
  }

  Future<List<Map<String, dynamic>>> fetchAll(String table) async {
    final db = await database;
    return await db.query(table);
  }

  Future<void> deleteDatabaseFile() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'local_app_database.db');
    await deleteDatabase(path);
  }
}

class RunMasterService {
  final LocalDatabaseHelper _dbHelper = LocalDatabaseHelper();

  Future<String> runMasterMethod(BuildContext context) async {
    try {
      Database db = await _dbHelper.database;

      await _dbHelper.deleteTable('M_WAGON');
      await _dbHelper.deleteTable('M_PLATFORM');

      await getWagonMaster(db);
      await getPlatformMaster(db);
      await getUserMasterRest({"username": "AT", "password": "AT"}, context);
      await getWagTypeAL({"username": "AT", "password": "AT"});
      await getRailwayAL();
      await getPkgCondnMaster();
      await getStationDetailRest(db);
      await getMPkgDesc(db);
      return "success";
    } catch (e) {
      debugPrint("Error in runMasterMethod: $e");
      return "failed: Error in service";
    }
  }

  Future<void> getWagonMaster(Database db) async {
    const apiUrl = AppURLs.wagonMasterUrl;
    final requestBody = {
      "DETAIL": {"APPTYPE": "Online"}
    };

    try {
      debugPrint('Sending request to $apiUrl');
      debugPrint('Request Body: ${jsonEncode(requestBody)}');

      final response = await http
          .post(
            Uri.parse(apiUrl),
            headers: {"Content-Type": "application/json"},
            body: jsonEncode(requestBody),
          )
          .timeout(const Duration(seconds: 10));

      debugPrint('Response Status Code: ${response.statusCode}');
      debugPrint('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        debugPrint('Decoded Response Data: $responseData');

        // Insert into the database
        await db.transaction((txn) async {
          Batch batch = txn.batch();
          for (var wagon in responseData) {
            batch.insert(
              'M_WAGON',
              {
                'CODE': wagon['code'].toString(),
                'WAGON_TYPE': wagon['wagon_type'].toString(),
                'CODENAME': wagon['codename'].toString(),
                'CAPACITY': wagon['capacity'],
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
          await batch.commit(noResult: true);
        });
      } else {
        throw Exception(
            'Failed to fetch wagon master data. Status Code: ${response.statusCode}');
      }
    } on TimeoutException {
      debugPrint("Timeout occurred while fetching Wagon Master data");
      throw Exception('Timeout occurred');
    } on SocketException {
      debugPrint("Network issue while fetching Wagon Master data");
      throw Exception('Network issue');
    } catch (e) {
      debugPrint("Unexpected error: $e");
      throw Exception('Unexpected error: $e');
    }
  }

  Future<void> getPlatformMaster(Database db) async {
    const apiUrl = AppURLs.plateformMasterUrl;
    final requestBody = {
      "DETAIL": {"APPTYPE": "Online"}
    };

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        debugPrint('Platform Master Data: $responseData');

        for (var platform in responseData) {
          await db.insert(
            'M_PLATFORM',
            {
              'CODE': platform['code'],
              'DETAIL': platform['detail'],
            },
            conflictAlgorithm: ConflictAlgorithm.replace,
          );
        }
      } else {
        throw Exception('Failed to fetch platform master data.');
      }
    } catch (e) {
      throw Exception('Error in fetching platform master data: $e');
    }
  }

  Future<void> getUserMasterRest(
      Map<String, dynamic> credentials, BuildContext context) async {
    final requestBody = {
      "detail": "{ \"stncode\": \"_NDLS\", \"strapptype\": \"Online\"}"
    };

    try {
      final response = await http.post(
        Uri.parse(AppURLs.userMasterUrl),
        headers: {"Content-Type": "application/json"},
        body: jsonEncode(requestBody),
      );
      debugPrint('Response Body: ${response.body}');
      if (response.statusCode == 200) {
        try {
          final responseData = jsonDecode(response.body);
          debugPrint('Parsed User Master Data: $responseData');

          if (context.mounted) {
            Navigator.pushReplacement(
              context,
              MaterialPageRoute(builder: (context) => const TabsScreen()),
            );
          }
        } catch (jsonError) {
          debugPrint('Error parsing JSON: $jsonError');
          throw Exception('Failed to parse response data.');
        }
      } else if (response.statusCode == 500) {
        debugPrint(
            'Server Error 500: ${response.body}. Possible issue with server logic or missing fields.');

        throw Exception(
            'Server Error: ${response.body}. Please verify the backend API implementation.');
      } else {
        debugPrint(
            'Error: Failed to fetch user master data. Status code: ${response.statusCode}, Body: ${response.body}');
        throw Exception(
            'Failed to fetch user master data. HTTP ${response.statusCode}');
      }
    } catch (e) {
      debugPrint('Error in getUserMasterRest: $e');
      throw Exception('Error in fetching user master data: $e');
    }
  }

  Future<void> getRailwayAL() async {
    try {
      final response = await http.post(
        Uri.parse(AppURLs.railwayALUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "DETAIL": "{\"APPTYPE\": \"Online\"}",
        }),
      );
      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        print('Railway AL Data: $responseData');
      } else {
        print('Failed: ${response.statusCode} - ${response.reasonPhrase}');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getPkgCondnMaster() async {
    try {
      final response = await http.post(
        Uri.parse(AppURLs.m_pkg_condnUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "DETAIL": "{\"APPTYPE\": \"Online\"}",
        }),
      );

      if (response.statusCode == 200) {
        print('PkgCondnMaster data: ${response.body}');
      } else {
        throw Exception('Failed to fetch platform master data.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getStationDetailRest(Database db) async {
    try {
      final response = await http.post(
        Uri.parse(AppURLs.stationdetailUrl),
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          "strWhereCondn":
              "\tWHERE\tCODE IS NOT NULL AND CRIS_STNNO IS NOT NULL",
          "strOrderBy": "\tORDER BY CRIS_STNNO"
        }),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        debugPrint('Decoded StationDetailRest Data: $responseData');

        await db.transaction((txn) async {
          Batch batch = txn.batch();
          for (var station in responseData) {
            batch.insert(
              'M_STATION_DETAIL',
              {
                'CODE': station['CODE'],
                'CRIS_STNNO': station['CRIS_STNNO'],
                'STATION_NAME': station['STATION_NAME'] ?? '',
              },
              conflictAlgorithm: ConflictAlgorithm.replace,
            );
          }
          await batch.commit(noResult: true);
        });
        debugPrint('Data inserted into M_STATION_DETAIL: ${response.body}');
      } else {
        throw Exception('Failed to fetch platform master data.');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  Future<void> getMPkgDesc(Database db) async {
    try {
      final response = await http.post(
        Uri.parse(AppURLs.m_pkg_descUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({"DETAIL": "{\"APPTYPE\": \"Online\"}"}),
      );

      if (response.statusCode == 200) {
        final List<dynamic> responseData = jsonDecode(response.body);
        debugPrint('Decoded Response Data: $responseData');

        await db.transaction((txn) async {
          Batch batch = txn.batch();
          for (var pkgDesc in responseData) {
            batch.insert(
              'M_PKG_DESC',
              {
                'SL_NO': pkgDesc['slNumber'].toString(),
                'PKG_DESC': pkgDesc['pkgDesc'],
              },
            );
          }
          await batch.commit(noResult: true);
        });
        debugPrint('Data inserted into M_PKG_DESC: ${response.body}');
      } else {
        throw Exception('Failed to fetch package description data.');
      }
    } catch (e) {
      debugPrint('Error: $e');
    }
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
      "DETAIL": jsonEncode({"APPTYPE": "Online"}),
    };
    final response = await http.post(
      Uri.parse(AppURLs.wagtypeALUrl),
      headers: {"Content-Type": "application/json"},
      body: jsonEncode(requestBody),
    );

    if (response.statusCode == 200) {
      final List<dynamic> responseData = jsonDecode(response.body);

      debugPrint('Response status code ANUuuuu: ${responseData.length}');

      if (responseData is List) {
        _wagTypeData =
            responseData.map((data) => WagonTypeAl.fromJson(data)).toList();
        debugPrint("object=${response.body}");
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
  } finally {}
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
  bool _isPasswordVisible = false;
  bool get isPasswordVisible => _isPasswordVisible;

  void togglePasswordVisibility() {
    _isPasswordVisible = !_isPasswordVisible;
    notifyListeners();
  }

  void setLoading(bool value) {
    _isLoading = value;
    notifyListeners();
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
 Map<String, dynamic>? _apiResponse;

  // Getter to access the API response
  Map<String, dynamic>? get loginApiResponse => _apiResponse;
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

  // Future<void> processWagonMasterData() async {
  //   try {
  //     Map<String, dynamic> requestData = {'APPTYPE': 'yourAppType'};
  //     List<dynamic> responseData = await fetchWagonMasterData(requestData);

  //     await db.execute('DELETE FROM M_WAGON');
  //     for (var item in responseData) {
  //       await db.insert('M_WAGON', {
  //         'CODE': item['code'],
  //         'WAGON_TYPE': item['wagon_type'],
  //         'CODENAME': item['codename'],
  //         'CAPACITY': item['capacity'],
  //       });
  //     }
  //   } catch (e) {
  //     throw Exception('Failed to process wagon master data: $e');
  //   }
  // }

  // Future<dynamic> fetchTrainDetails(Map<String, dynamic> credentials) async {
  //   final response = await http.post(
  //     Uri.parse('${AppURLs.trnDtlsUrl}'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(credentials),
  //   );

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to fetch train details.');
  //   }
  // }

  // Future<dynamic> fetchUserMaster(Map<String, dynamic> credentials) async {
  //   final response = await http.post(
  //     Uri.parse('${AppURLs.userMasterUrl}'),
  //     headers: {'Content-Type': 'application/json'},
  //     body: jsonEncode(credentials),
  //   );

  //   if (response.statusCode == 200) {
  //     return jsonDecode(response.body);
  //   } else {
  //     throw Exception('Failed to fetch user master data.');
  //   }
  // }

  // Future<String> runMasterMethod(BuildContext context) async {
  //   try {
  //     final Database db = await openDatabase(
  //       'platform_master.db',
  //       version: 1,
  //       onCreate: (Database db, int version) async {
  //         await db.execute('''
  //           'CREATE TABLE M_PLATFORM (CODE TEXT PRIMARY KEY, DETAIL TEXT)',
  //       ''');
  //                   await db.execute('''
  //           CREATE TABLE M_WAGON (
  //             CODE TEXT NOT NULL,
  //             WAGON_TYPE TEXT NOT NULL,
  //             CODENAME TEXT NOT NULL,
  //             CAPACITY TEXT NOT NULL,
  //             PRIMARY KEY (CODE, WAGON_TYPE, CODENAME, CAPACITY)
  //           )
  //           ''');
  //       },
  //     );

  // String strapptype = 'Test';
  // await getWagonMaster(strapptype);

  // final apiUrl = AppURLs.plateformMasterUrl;
  // final appTypeDataDetail = {"APPTYPE": "Online"};

  //     return "success";
  //   } catch (e) {
  //     debugPrint("Error in runMasterMethod: $e");
  //     return "failed: Error in service";
  //   }
}

  // Future<void> getWagonMaster(String strapptype) async {
  //   const String apiUrl = AppURLs.wagonMasterUrl;
  //   final Map<String, dynamic> requestBody = {
  //     "DETAIL": {"APPTYPE": strapptype}
  //   };

  //   try {
  //     final response = await http.post(
  //       Uri.parse(apiUrl),
  //       headers: {
  //         "Content-Type": "application/json",
  //       },
  //       body: jsonEncode(requestBody),
  //     );

  //     if (response.statusCode == 200) {
  //       final List<dynamic> responseData = jsonDecode(response.body);
  //       print('getWagonMaster API Responsesssss: $responseData');

  //       await database?.execute('DELETE FROM M_WAGON');

  //       for (var wagon in responseData) {
  //         await database?.insert(
  //           'M_WAGON',
  //           WagonMaster(
  //             code: wagon['code'],
  //             wagonType: wagon['wagon_type'],
  //             codename: wagon['codename'],
  //             capacity: wagon['capacity'],
  //           ).toMap(),
  //           conflictAlgorithm: ConflictAlgorithm.replace,
  //         );
  //       }
  //     } else {
  //       throw Exception(
  //           'Failed to fetch wagon master data. Status: ${response.statusCode}');
  //     }
  //   } catch (e) {
  //     throw Exception('Error in fetching wagon master data: $e');
  //   }
  // }}

//   Future<void> getUserMasterRest(Map<String, dynamic> credentials,
//       String requiredString, BuildContext context) async {
//     final url = Uri.parse(AppURLs.userMasterUrl);

//     try {
//       final response = await http.post(
//         url,
//         headers: {
//           "Content-Type": "application/json",
//         },
//         body: jsonEncode({
//           "credentials": credentials,
//           "requiredString": requiredString,
//           "detail": {
//             "stncode": "_NDLS",
//             "strapptype": "Online",
//           },
//         }),
//       );

//       if (response.statusCode == 200) {
//         final responseData = jsonDecode(response.body);
//         debugPrint('getUserMasterRest Response: $responseData');


//         if (!context.mounted) return;
//         Navigator.pushReplacement(
//           context,
//           MaterialPageRoute(builder: (context) => const TabsScreen()),
//         );
//       } else {
//         throw Exception(
//             'Failed to fetch user master data. Status Code: ${response.statusCode}');
//       }
//     } catch (e) {
//       throw Exception('Failed to fetch user master data: $e');
//     }
//   }
// }




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


