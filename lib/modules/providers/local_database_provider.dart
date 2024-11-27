import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:project/model/parcel.dart';




class LocalDatabaseProvider with ChangeNotifier {
  Database? _database;

  // In-memory list to hold the data
  List<ParcelData> _parcelDataList = [];

  // Getter for parcel data
  List<ParcelData> get parcelDataList => _parcelDataList;

  // Initialize the database and load data

  
 Future<Database?> init() async {
  if (_database != null) return _database; // Return existing database instance

  final dbPath = await getDatabasesPath();
  final dbFilePath = join(dbPath, 'parcel_database.db');

  _database = await openDatabase(
    dbFilePath,
    version: 1,
    onCreate: (db, version) async {
      // Create the parcels table on database creation
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
    },
    onUpgrade: (db, oldVersion, newVersion) async {
      // Handle database upgrades if needed in future
      if (oldVersion < newVersion) {
        // Example: Add new columns or tables here
      }
    },
  );

  // Verify table creation or check table structure
  // await _checkTableExists();

  // Load initial data after initializing the database
  await loadParcelData();

  return _database; // Return the database instance
}

  // Load parcel data from the database
  Future<void> loadParcelData() async {
    final db = _database;
    if (db != null) {
      final List<Map<String, dynamic>> maps = await db.query('parcels');
      _parcelDataList = maps.map((map) => ParcelData.fromMap(map)).toList();
      print("Loaded data: $_parcelDataList"); // Debug log
      notifyListeners();
    }
  }
Future<bool?> isParcelDuplicate(String? prrNumber) async {
  if (prrNumber == null || prrNumber.isEmpty) return false;

  final db = await init();
  final result = await db?.query(
    'parcels',
    where: 'prrNumber = ?',
    whereArgs: [prrNumber],
  );

  return result?.isNotEmpty;
}

  // Insert parcel data into the database
  Future<void> insertParcelData(ParcelData parcelData) async {
    final db = _database;
    if (db == null) {
      throw Exception("Database is not initialized.");
    }
    await db.insert(
      'parcels',
      parcelData.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace,
  );
    await loadParcelData(); // Reload data after insert
}

  // Query parcel data from the database
  Future<List<ParcelData>> getParcelData() async {
    final db = _database;
    if (db == null) {
      throw Exception("Database is not initialized.");
    }

    final List<Map<String, dynamic>> maps = await db.query('parcels');
    return List.generate(maps.length, (i) {
      return ParcelData.fromMap(maps[i]);
    });
  }

  // Delete parcel data from the database
  Future<void> deleteParcelData(ParcelData data) async {
    final db = _database;
    if (db != null) {
      await db.delete(
        'parcels',
        where: 'prrNumber = ?',
        whereArgs: [data.prrNumber],
      );
      _parcelDataList.removeWhere((item) => item.prrNumber == data.prrNumber);
      notifyListeners();
    }
  }

  // Clear all data from the database
  Future<void> clearDatabase() async {
    final db = _database;
    if (db != null) {
      await db.delete('parcels');
      _parcelDataList.clear();
      notifyListeners();
    }
  }

  // Close the database
  Future<void> closeDatabase() async {
    final db = _database;
    if (db != null) {
      await db.close();
      _database = null;
    }
  }
}
