import 'package:path/path.dart';
import 'package:project/model/parcel.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;

    _db = await _initializeDatabase();
    return _db!;
  }

  Future<Database> _initializeDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "pms_db.db");

    return openDatabase(
      databasePath,
      version: 3,
      onCreate: _createDB,
      onUpgrade: _onUpgrade,
    );
  }

Future<void> _createDB(Database db, int version) async {
  print('Creating database schema...');
  
  // ACTUALLOAD Table
  await db.execute('''
    CREATE TABLE ACTUALLOAD (
      trainNumber TEXT,
      vehicleType TEXT,
      guardDetails TEXT,
      loadDetails TEXT,
      PRIMARY KEY (trainNumber, vehicleType)
    );
  ''');

  // userlogins Table
  await db.execute('''
    CREATE TABLE userlogins (
      userId TEXT PRIMARY KEY,
      password TEXT,
      role TEXT
    );
  ''');

  // scanData Table
  await db.execute('''
    CREATE TABLE scanData (
      id INTEGER PRIMARY KEY AUTOINCREMENT,
      itemDetails TEXT,
      source TEXT,
      destination TEXT,
      scanTimestamp TEXT
    );
  ''');
//for parcel
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
      );
    ''');
  // loading Table
  await db.execute('''
    CREATE TABLE loading (
      loadingId TEXT PRIMARY KEY,
      details TEXT,
      createdBy TEXT,
      createdDate TEXT
    );
  ''');
// login_info Table
  await db.execute('''
    CREATE TABLE IF NOT EXISTS login_info (
      userId TEXT PRIMARY KEY,
      password TEXT,
      stationCode TEXT
    );
  ''');
  // loading_dtl Table
  await db.execute('''
    CREATE TABLE loading_dtl (
      detailId INTEGER PRIMARY KEY AUTOINCREMENT,
      loadingId TEXT,
      itemDetails TEXT,
      FOREIGN KEY (loadingId) REFERENCES loading (loadingId)
    );
  ''');

  // addPrrPwb Table
  await db.execute('''
    CREATE TABLE addPrrPwb (
      parcelId TEXT PRIMARY KEY,
      details TEXT,
      stationCode TEXT,
      addedDate TEXT
    );
  ''');

  // saveManualData Table
  await db.execute('''
    CREATE TABLE saveManualData (
      dataId INTEGER PRIMARY KEY AUTOINCREMENT,
      manualEntry TEXT,
      enteredBy TEXT,
      entryDate TEXT
    );
  ''');

  // ACT_LOADTLS_FALLBACK Table
  await db.execute('''
    CREATE TABLE ACT_LOADTLS_FALLBACK (
      fallbackId INTEGER PRIMARY KEY AUTOINCREMENT,
      loadDetails TEXT,
      createdDate TEXT
    );
  ''');

  print('Database schema created.');
}

  Future<void> _onUpgrade(Database db, int oldVersion, int newVersion) async {
    print('Upgrading database from version $oldVersion to $newVersion...');
    if (oldVersion < 3) {
      await db.execute('''
      CREATE TABLE IF NOT EXISTS login_info (
        userId TEXT PRIMARY KEY,
        password TEXT,
        stationCode TEXT
      );
    ''');
      print('Table login_info added.');
    }
  }

  Future<void> verifyTables() async {
    final db = await database;
    final result =
        await db.rawQuery("SELECT name FROM sqlite_master WHERE type='table'");
    print('Tables in database: $result');
  }
Future<List<Map<String, dynamic>>> getTableData(String tableName) async {
  final db = await database;
  try {
    return await db.query(tableName);
  } catch (e) {
    print('Error fetching data from $tableName: $e');
    return [];
  }
}
Future<List<String>> getAllTableNames() async {
  final db = await database;
  try {
    final tables = await db.rawQuery(
      "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%' AND name != 'android_metadata'"
    );
    return tables.map((row) => row['name'].toString()).toList();
  } catch (e) {
    print('Error fetching table names: $e');
    return [];
  }
}



  Future<List<Map<String, dynamic>>> getAllLoginInfo() async {
    final db = await database;
    try {
      final result = await db.query('login_info');
      print('Fetched login info: $result');
      return result;
    } catch (e) {
      print('Error fetching login info: $e');
      return [];
    }
  }

  Future<void> insertLoginInfo(
      String userId, String password, String stationCode) async {
    final db = await database;
    try {
      await db.insert(
        'login_info',
        {
          'userId': userId,
          'password': password,
          'stationCode': stationCode,
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      print('Login info inserted successfully');
    } catch (e) {
      print('Error inserting login info: $e');
    }
  }

  Future<String> addParcel(ParcelData parcel) async {
    final db = await database;
    try {
      await db.insert('parcels', parcel.toMap());
      print('Parcel added successfully: $parcel');
      return parcel.prrNumber!;
    } catch (e) {
      print('Error adding parcel: $e');
      return '';
    }
  }

  Future<List<ParcelData>> getAllParcels() async {
    final db = await database;
    try {
      final result = await db.query('parcels');
      print('Parcels fetched successfully: $result');
      return result.map((json) => ParcelData.fromMap(json)).toList();
    } catch (e) {
      print('Error fetching parcels: $e');
      return [];
    }
  }

  Future<void> clearParcels() async {
    final db = await database;
    try {
      await db.delete('parcels');
      print('All data cleared from the parcels table.');
    } catch (e) {
      print('Error clearing parcels table: $e');
    }
  }

  Future<void> deleteDatabaseFile() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "pms_db.db");
    try {
      await deleteDatabase(databasePath);
      print("Database deleted successfully.");
    } catch (e) {
      print('Error deleting database: $e');
    }
  }
}

