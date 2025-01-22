import 'package:flutter/material.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:project/model/parcel.dart';
// ignore: depend_on_referenced_packages
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
        version: 3,
        onCreate: (db, version) async {
          await createTables(db);
        },
        onUpgrade: (db, oldVersion, newVersion) async {
          if (oldVersion < newVersion) {
            await db.execute('DROP TABLE IF EXISTS parcels');
            await db.execute('DROP TABLE IF EXISTS scanData');
            await db.execute('DROP TABLE IF EXISTS ACTUALLOAD');
            await db.execute('DROP TABLE IF EXISTS userlogins');
            await db.execute('DROP TABLE IF EXISTS loading');
            await db.execute('DROP TABLE IF EXISTS loading_dtl');
            await db.execute('DROP TABLE IF EXISTS addPrrPwb');
            await db.execute('DROP TABLE IF EXISTS saveManualData');
            await db.execute('DROP TABLE IF EXISTS ACT_LOADTLS_FALLBACK');
            await db.execute('DROP TABLE IF EXISTS OFFLINE_SUMMARY_DTLS');
            await db.execute('DROP TABLE IF EXISTS M_STN');
            await db.execute('DROP TABLE IF EXISTS M_TRAIN');
            await db.execute('DROP TABLE IF EXISTS M_TRNDTLS');
            await db.execute('DROP TABLE IF EXISTS M_USERID');
            await db.execute('DROP TABLE IF EXISTS M_RLY');
            await db.execute('DROP TABLE IF EXISTS M_PLATFORM');
            await db.execute('DROP TABLE IF EXISTS M_WAGTYPE');
            await db.execute('DROP TABLE IF EXISTS M_PKG_DESC');
            await db.execute('DROP TABLE IF EXISTS M_PKGCONDN');
            await db.execute('DROP TABLE IF EXISTS M_WAGON');
            await db.execute('DROP TABLE IF EXISTS M_STATION_DETAIL');

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
    );
    ''');

    await db.execute('''
      CREATE TABLE ACTUALLOAD (
        trainNumber TEXT,
        vehicleType TEXT,
        guardDetails TEXT,
        loadDetails TEXT,
        PRIMARY KEY (trainNumber, vehicleType)
  );
  ''');

    await db.execute('''
      CREATE TABLE IF NOT EXISTS userlogins (
        userId TEXT PRIMARY KEY,
        password TEXT,
        stationCode TEXT
      );
    ''');
    debugPrint("userlogins table created successfully.");

    await db.execute('''
      CREATE TABLE scanData (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        itemDetails TEXT,
        source TEXT,
        destination TEXT,
        scanTimestamp TEXT
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

    // loading_dtl Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS loading_dtl (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        pfno INTEGER,
        insideLock TEXT,
        rejectWagon TEXT,
        coachTypeUser TEXT,
        ownrlyUser TEXT,
        coachnoUser INTEGER,
        rpf TEXT,
        remark TEXT,
        guardCharge TEXT,
        guardName TEXT,
        sealed TEXT,
        sealToStn TEXT,
        nil_ld_uld TEXT,
         changeSLR TEXT
    );

  ''');

    // addPrrPwb Table
    await db.execute('''
     CREATE TABLE IF NOT EXISTS addPrrPwb (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        item_type TEXT,
        bk_type TEXT,
        prrNo INTEGER,
        srcStn TEXT,
        desStn TEXT,
        bkDate INTEGER,
        bkd_pkg INTEGER,
        ld_pkg INTEGER,
        bkd_wt INTEGER,
        ld_wt INTEGER,
        pkg_condn TEXT,
        pkg_desc TEXT,
        remarks TEXT,
        rackNo INTEGER
);

  ''');

    // saveManualData Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS saveManualData (
        item_type TEXT,
        bk_type TEXT,
        prrNo INTEGER PRIMARY KEY,
        srcStn TEXT,
        desStn TEXT,
        bkDate INTEGER,
        bkd_pkg INTEGER,
        ld_pkg INTEGER,
        bkd_wt INTEGER,
        ld_wt INTEGER,
        pkg_condn TEXT,
        pkg_desc TEXT,
        remarks TEXT,
        rackNo INTEGER
      );
    ''');

    // ACT_LOADTLS_FALLBACK Table
    await db.execute('''
      CREATE TABLE IF NOT EXISTS ACT_LOADTLS_FALLBACK (
        ACT_LOADNO TEXT NOT NULL,
        PWBLTNO INTEGER NOT NULL,
        CONSIGNOR_MOBILE_NO INTEGER NOT NULL,
        CONSIGNEE_MOBILE_NO INTEGER NOT NULL,
        MAJCOMMD TEXT NOT NULL DEFAULT 0,
        TOTCHRG INTEGER NOT NULL DEFAULT 0,
        NOOFITEMSLOADED INTEGER,
        PKGCND TEXT,
        LOAD_DT NUMERIC,
        CNTR NUMERIC,
        STNCODE TEXT,
        ZONE NUMERIC,
        REMOTEADDR TEXT,
        REMOTEHOST TEXT,
        BKTYPE TEXT,
        WEIGHT NUMERIC DEFAULT 0,
        STNFROM TEXT,
        DSTNSTN TEXT,
        BOOK_DT NUMERIC,
        BKDPACKAGE NUMERIC,
        TEMPPWBNO TEXT,
        PKGTYPE TEXT,
        SCHLD_DT NUMERIC,
        VEHICLE_NO TEXT,
        ITEMNOS TEXT,
        LOST_ITEMNO TEXT,
        BKWT NUMERIC,
        LDWT NUMERIC,
        REMARKS TEXT,
        MEMO_NIL_NO TEXT,
        SERIAL_NO NUMERIC NOT NULL DEFAULT 0,
        SYSTEM_DT NUMERIC,
        DESTNSTNCBA TEXT,
        SCH_DATETIME_ZERO_TIME NUMERIC,
        PKG_DESC NUMERIC,
        RACKNO TEXT,
        NOOFITEMSLD_REQ NUMERIC,
        SCANALL NUMERIC DEFAULT 0,
        COMMO TEXT,
        PKG_DESC_ITEMS TEXT,
        SCALE TEXT,
        LDCHRGWT TEXT,
        TOTCHRGWT TEXT,
        NOP_SCANNED NUMERIC,
        PRIMARY KEY (PWBLTNO, ACT_LOADNO)
      );
    ''');

    await db.execute('''
   CREATE TABLE IF NOT EXISTS OFFLINE_SUMMARY_DTLS (
  VCLTYPE TEXT,
  SCHLD_DT NUMERIC,
  TRAIN_NO NUMERIC,
  STNCODE TEXT,
  ID NUMERIC,
  PRR TEXT,
  SRC TEXT,
  DES TEXT,
  PKG TEXT,
  WGHT TEXT,
  BT TEXT,
  PKGTYPE TEXT,
  BKDT TEXT,
  CONDITION TEXT,
  DESCR TEXT,
  REMARKS TEXT,
  BKD NUMERIC,
  PKGS NUMERIC,
  POTENTIAL NUMERIC,
  MAXLOAD NUMERIC,
  BKWT NUMERIC,
  WT NUMERIC,
  ITEMNOS TEXT,
  PWBNO TEXT,
  RACKNO TEXT,
  DCMLWT TEXT,
  SCANALL NUMERIC DEFAULT 0,
  COMMO TEXT,
  PKG_DESC_ITEMS TEXT,
  MINITEMNO NUMERIC,
  MAXITEMNO NUMERIC,
  SEQUENCE_FLG NUMERIC,
  SCALE TEXT,
  CHRGWT NUMERIC,
  TOTCHRGWT NUMERIC
);

    ''');
    await db.execute('''
    CREATE TABLE IF NOT EXISTS M_STN (
  CODE TEXT NOT NULL,
  DETAIL TEXT,
  CRIS_STNNO NUMERIC,
  ZONE NUMERIC,
  SYSTEM_DT NUMERIC
);

    ''');
    await db.execute('''
      CREATE TABLE IF NOT EXISTS M_TRAIN (
  TRAIN_NO NUMERIC NOT NULL,
  TRAIN_NAME TEXT,
  TRAIN_TYPE TEXT NOT NULL,
  TRAIN_DIRECTION TEXT,
  OTHER_DESC TEXT,
  USER_NAME TEXT,
  USER_DATETIME NUMERIC,
  PARCEL_BKNG_ALLWD NUMERIC,
  LUGG_BKNG_ALLWD NUMERIC,
  TRAIN_GAUGE TEXT NOT NULL,
  OWNNG_RLY TEXT,
  MON_FLAG NUMERIC,
  TUE_FLAG NUMERIC,
  WED_FLAG NUMERIC,
  THU_FLAG NUMERIC,
  FRI_FLAG NUMERIC,
  SAT_FLAG NUMERIC,
  SUN_FLAG NUMERIC,
  USERID INTEGER,
  STNCODE TEXT,
  SYSTEM_DT NUMERIC,
  SCALECODE TEXT,
  VALIDITY NUMERIC,
  LTSCALECODE TEXT NOT NULL,
  TRAIN_VER NUMERIC,
  REMOTEHOST TEXT
);

    ''');
    await db.execute('''
     CREATE TABLE IF NOT EXISTS M_TRNDTLS (
      TRNNO TEXT NOT NULL,
      STNCODE TEXT NOT NULL,
      DISTANCE TEXT NOT NULL,
      DAYCOUNT NUMERIC NOT NULL,
      FSLRQUOTA NUMERIC DEFAULT 0,
      RSLRQUOTA NUMERIC DEFAULT 0,
      VP1QUOTA NUMERIC DEFAULT 0,
      VP2QUOTA NUMERIC DEFAULT 0,
      OWNMG_RLY TEXT,
      ZONE NUMERIC,
      TRNROUTE TEXT,
      ARRTIME NUMERIC NOT NULL,
      DEPTIME NUMERIC NOT NULL,
      USERID TEXT,
      SYSTEM_DT NUMERIC,
      STN_CD TEXT,
      ARRTIME_TS NUMERIC,
      DEPTIME_TS NUMERIC,
      VALID NUMERIC NOT NULL,
      TRAIN_VER NUMERIC NOT NULL DEFAULT 1,
      USERLEVEL NUMERIC
    )
    ''');

    // Creating M_USERID
    await db.execute('''
    CREATE TABLE IF NOT EXISTS M_USERID (
      USERID TEXT NOT NULL,
      PASSWORD TEXT,
      INVALID NUMERIC,
      STNCODE TEXT
    );
    ''');

    await db.execute('''
          CREATE TABLE IF NOT EXISTS M_RLY (
            ZONE TEXT NOT NULL,
            CODE TEXT NOT NULL
          );
        ''');
    await db.execute('''
        CREATE TABLE M_PLATFORM (
            CODE TEXT PRIMARY KEY,
            DETAIL TEXT
          )
        ''');

    await db.execute('''
     CREATE TABLE IF NOT EXISTS M_WAGTYPE (
      TYPE TEXT NOT NULL,
      GUAGE TEXT NOT NULL,
      DETAIL TEXT NOT NULL,
      SHORTDET TEXT NOT NULL
    );
    ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS M_PKG_DESC (
            SL_NO TEXT NOT NULL,
            PKG_DESC TEXT NOT NULL,
            USERID TEXT NOT NULL,
            STNCODE TEXT NOT NULL
          );
        ''');
    await db.execute('''
          CREATE TABLE IF NOT EXISTS M_PKGCONDN (
            CODE TEXT NOT NULL,
            DETAIL TEXT NOT NULL
          );
        ''');
    await db.execute('''
          CREATE TABLE M_WAGON (
            CODE TEXT PRIMARY KEY,
            WAGON_TYPE TEXT,
            CODENAME TEXT,
            CAPACITY INTEGER
          )
        ''');
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
      await db.rawQuery(
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
      await db.query(tableName);
    } catch (e) {}
  }

  Future<List<String>> getAllTableNames() async {
    final db = await initDatabase();
    if (db != null) {
      final result = await db.rawQuery(
          "SELECT name FROM sqlite_master WHERE type='table' AND name NOT LIKE 'sqlite_%'");
      return result.map((row) => row['name'] as String).toList();
    }
    return [];
  }

  Future<void> insertLoginInfo(
      String userId, String password, String stationCode) async {
    final db = await initDatabase();
    if (db == null) throw Exception("Database is not initialized.");

    try {
      final hashedPassword = hashPassword(password);

      await db.insert(
        'userlogins',
        {
          'userId': userId,
          'password': hashedPassword,
          'stationCode': stationCode
        },
        conflictAlgorithm: ConflictAlgorithm.replace,
      );
      debugPrint("Login info inserted for userId: $userId");
    } catch (e) {
      debugPrint("Error inserting login info: $e");
    }
  }

  Future<void> onLoginButtonClick(String userId, String password) async {
    await initDatabase();
    bool isValidUser = validateUserCredentials(userId, password);

    if (isValidUser) {
      String stationCode =
          "NDLS"; // Example, get this from your validation logic
      try {
        await insertLoginInfo(userId, password, stationCode);
      } catch (e) {
        // Handle error
      }
    } else {
      // Handle invalid login
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

  void onLoginSuccess(String userId, String password, String stationCode) {
    final localDatabaseProvider = LocalDatabaseProvider();
    localDatabaseProvider.saveLoginInfo(
      userId: userId,
      password: password,
      stationCode: stationCode,
    );
  }

  // Save login info to userLogins table
  Future<void> saveLoginInfo({
    required String userId,
    required String password,
    required String stationCode,
  }) async {
    final db = await initDatabase();
    if (db != null) {
      try {
        String hashedPassword = hashPassword(password);

        await db.insert(
          'userlogins',
          {
            'userId': userId,
            'password': hashedPassword,
            'stationCode': stationCode,
          },
          conflictAlgorithm: ConflictAlgorithm.replace,
        );

        debugPrint("Login info saved for userId: $userId");
      } catch (e) {
        debugPrint("Error saving login info: $e");
      }
    } else {
      debugPrint("Database is not initialized.");
    }
  }
}
