import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:project/model/parcel.dart';

class LocalDatabaseProvider with ChangeNotifier {
  Database? _database;

  // Open database
  Future<void> initDatabase() async {
    final dbPath = await getDatabasesPath();
    _database = await openDatabase(
      join(dbPath, 'parcel_data.db'),
      onCreate: (db, version) {
        return db.execute(
          '''
          CREATE TABLE parcels(
            id INTEGER PRIMARY KEY,
            prrNumber TEXT,
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
          ''',
        );
      },
      version: 1,
    );
  }

  List<ParcelData> _parcelDataList = [];

  // Method to insert parcel data into the list
  void insertParcelData(ParcelData data) {
    _parcelDataList.add(data);
    notifyListeners();  // Notify listeners to refresh the UI
  }
void deleteParcelData(ParcelData data) {
  _parcelDataList.remove(data);
  notifyListeners();  // Notifies listeners to refresh the UI after deletion
}

  // Get all parcel data
  Future<List<ParcelData>> getParcelData() async {
    final db = await _database!;
    final List<Map<String, dynamic>> maps = await db.query('parcels');

    return List.generate(maps.length, (i) {
      return ParcelData.fromMap(maps[i]);
    });
  }
}
