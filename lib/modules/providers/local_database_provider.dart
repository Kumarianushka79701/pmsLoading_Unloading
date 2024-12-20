import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:project/model/parcel.dart';
import 'package:crypto/crypto.dart';
import 'dart:convert';

String hashPassword(String password) {
  return sha256.convert(utf8.encode(password)).toString();
}

class LocalDatabaseProvider with ChangeNotifier {
  Database? database;
  List<ParcelData> parcelDataList = [];

  // List<ParcelData> get parcelDataList => parcelDataList;

  // Initialize the database
  Future<Database?> initDatabase() async {
    if (database != null) return database;

    try {
      final dbPath = await getDatabasesPath();
      final dbFilePath = join(dbPath, 'parcel_database.db');

      database = await openDatabase(
        dbFilePath,
        version: 2,
        onCreate: (db, version) async {
          await createTables(db);
        },
       onUpgrade: (db, oldVersion, newVersion) async {
  if (oldVersion < newVersion) {
    await db.execute('DROP TABLE IF EXISTS parcels');
    await db.execute('DROP TABLE IF EXISTS login_info');
    await createTables(db);
  }
},
      );

      await loadParcelData(); // Load initial data
    } catch (e) {
      // Handle error
    }

    return database;
  }
  
 Future<List<Map<String, dynamic>>> getTableData(String tableName) async {
    final db = database;
    if (db == null) {
      throw Exception("Database is not initialized.");
    }

    return await db.query(tableName);
  }
  // Create tables
  Future<void> createTables(Database db) async {
    await db.execute('''
      CREATE TABLE parcels (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        prrNumber TEXT NOT NULL UNIQUE,
        weightOfConsignment TEXT,
        totalPackages TEXT,
        currentPackageNumber TEXT,
        destinationStationCode TEXT,
        sourceStationCode TEXT,
        totalWeight TEXT,
        commodityTypeCode TEXT,
        bookingDate TEXT,
        chargeableWeightForCurrentPackage TEXT,
        totalChargeableWeight TEXT,
        packagingDescriptionCode TEXT,
        trainScaleCode TEXT,
        rajdhaniFlag TEXT,
        estimatedUnloadingTime TEXT,
        transhipmentStation TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE login_info (
        userId TEXT PRIMARY KEY,
        password TEXT,
        stationCode TEXT
      )
    ''');
  }

  // Load parcel data
  Future<void> loadParcelData() async {
    final db = await initDatabase();
    if (db != null) {
      try {
        final maps = await db.query('parcels');
        parcelDataList = maps.map((map) => ParcelData.fromMap(map)).toList();
        notifyListeners();
      } catch (e) {
        // Handle error
      }
    }
  }

  // Check for duplicate parcel
  Future<bool> isParcelDuplicate(String? prrNumber) async {
    if (prrNumber == null || prrNumber.isEmpty) return false;

    final db = await initDatabase();
    final result = await db?.query(
      'parcels',
      where: 'prrNumber = ?',
      whereArgs: [prrNumber],
    );

    return result?.isNotEmpty ?? false;
  }

  // Insert parcel data
  Future<void> insertParcelData(ParcelData parcelData) async {
    final db = await initDatabase();
    if (db == null) throw Exception("Database is not initialized.");

    try {
      await db.insert(
        'parcels',
        parcelData.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      await loadParcelData();
    } catch (e) {
      // Handle error
    }
  }

  // Retrieve all parcel data
  Future<List<ParcelData>> getParcelData() async {
    final db = await initDatabase();
    if (db == null) throw Exception("Database is not initialized.");

    try {
      final maps = await db.query('parcels');
      return maps.map((map) => ParcelData.fromMap(map)).toList();
    } catch (e) {
      // Handle error
      return [];
    }
  }

  // Delete specific parcel data
  Future<void> deleteParcelData(ParcelData data) async {
    final db = await initDatabase();
    if (db != null) {
      try {
        await db.delete(
          'parcels',
          where: 'prrNumber = ?',
          whereArgs: [data.prrNumber],
        );
        parcelDataList.removeWhere((item) => item.prrNumber == data.prrNumber);
        notifyListeners();
      } catch (e) {
        // Handle error
      }
    }
  }
 Future<void> verifyTables() async {
    final db = await initDatabase();
    if (db == null) return;

    try {
      final tables = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
    } catch (e) {
      // Handle error
    }
  }
  // Clear all data from the parcels table
  Future<void> clearDatabase() async {
    final db = await initDatabase();
    if (db != null) {
      try {
        await db.delete('parcels');
            parcelDataList.clear();
        notifyListeners();
      } catch (e) {
        // Handle error
      }
    }
  }
   Future<void> printTableData(String tableName) async {
    final db = await initDatabase();
    if (db == null) return;

    try {
      final data = await db.query(tableName);
    } catch (e) {
      // Handle error
    }
  }


  // Get all table names (utility)
  Future<List<String>> getAllTableNames() async {
    final db = await initDatabase();
    if (db != null) {
      final result = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
      return result.map((row) => row['name'] as String).toList();
    }
    return [];
  }


Future<void> insertLoginInfo(String userId, String password, String stationCode) async {
  final db = await initDatabase();
  if (db == null) throw Exception("Database is not initialized.");

  try {
    final hashedPassword = hashPassword(password);

    await db.insert(
      'login_info',
      {'userId': userId, 'password': hashedPassword, 'stationCode': stationCode},
      conflictAlgorithm: ConflictAlgorithm.replace,
    );

    final insertedData = await db.query('login_info');
  } catch (e) {
    // Handle error
  }
}



final Map<String, String> users = {
    'admin': 'password123',
    'user1': 'password456',
  };

  /// Validate the user credentials.
  bool validateUserCredentials(String userId, String password) {
    if (users.containsKey(userId)) {
      return users[userId] == password;
    }
    return false;
  }
   Future<void> saveLoginInfo(String userId, String password, String stationCode) async {
    final db = await database;
    await db?.insert(
      'login_info',
      {
        'user_id': userId,
        'password': password,
        'station_code': stationCode,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,  // to replace existing record with the same id
    );
  }

Future<void> onLoginButtonClick(String userId, String password) async {
  await initDatabase();
  bool isValidUser = validateUserCredentials(userId, password);

  if (isValidUser) {
    String stationCode = "ST001"; // Example, get this from your validation logic
    await insertLoginInfo(userId, password, stationCode);
  } else {
    // Handle invalid login
  }
}


}
