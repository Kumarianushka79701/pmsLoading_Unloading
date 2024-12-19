import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:project/model/parcel.dart';

class LocalDatabaseProvider with ChangeNotifier {
  Database? _database;
  List<ParcelData> _parcelDataList = [];

  List<ParcelData> get parcelDataList => _parcelDataList;

  // Initialize the database
  Future<Database?> initDatabase() async {
    if (_database != null) return _database;

    try {
      final dbPath = await getDatabasesPath();
      final dbFilePath = join(dbPath, 'parcel_database.db');

      _database = await openDatabase(
        dbFilePath,
        version: 2,
        onCreate: (db, version) async {
          await _createTables(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < newVersion) {
            // Handle upgrades, e.g., add new columns or tables.
          }
        },
      );

      await loadParcelData(); // Load initial data
    } catch (e) {
      print("Error initializing database: $e");
    }

    return _database;
  }
 Future<List<Map<String, dynamic>>> getTableData(String tableName) async {
    final db = _database;
    if (db == null) {
      throw Exception("Database is not initialized.");
    }

    return await db.query(tableName);
  }
  // Create tables
  Future<void> _createTables(Database db) async {
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
        _parcelDataList = maps.map((map) => ParcelData.fromMap(map)).toList();
        print("Loaded parcel data: $_parcelDataList");
        notifyListeners();
      } catch (e) {
        print("Error loading parcel data: $e");
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
      print("Error inserting parcel data: $e");
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
      print("Error retrieving parcel data: $e");
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
        _parcelDataList.removeWhere((item) => item.prrNumber == data.prrNumber);
        notifyListeners();
      } catch (e) {
        print("Error deleting parcel data: $e");
      }
    }
  }

  // Clear all data from the parcels table
  Future<void> clearDatabase() async {
    final db = await initDatabase();
    if (db != null) {
      try {
        await db.delete('parcels');
        _parcelDataList.clear();
        notifyListeners();
      } catch (e) {
        print("Error clearing database: $e");
      }
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

  // Close the database
  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database?.close();
      _database = null;
    }
  }
}
