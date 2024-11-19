import 'package:path/path.dart';
import 'package:project/model/parcel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "pms_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: _createDB,
    );
    return database;
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
        CREATE TABLE parcels (
            prrNumber TEXT PRIMARY KEY,
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
  }

  Future<String> addParcel(ParcelData parcel) async {
    final db = await database;
    await db.insert('parcels', parcel.toMap());
    print('Parcel added successfully $parcel');
    return parcel.prrNumber!;
  }

  Future<List<ParcelData>> getAllParcels() async {
    final db = await DatabaseService.instance.database;

    final result = await db.query('parcels');
    print('Parcels fetched successfully $result');
    return result.map((json) => ParcelData.fromMap(json)).toList();
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('parcels');
    print('All data clear from the database.');
  }
}
