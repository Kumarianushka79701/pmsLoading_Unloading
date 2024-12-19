// import 'package:sqflite/sqflite.dart';
// import 'package:path/path.dart';

// class LocalLoginDatabase {
//   static final LocalLoginDatabase instance = LocalLoginDatabase._init();
//   Database? _database;

//   LocalLoginDatabase._init();

//   // Initialize the database
//   Future<Database> get database async {
//     if (_database != null) return _database!;

//     _database = await _initDB('login_database.db');
//     return _database!;
//   }

//   Future<Database> _initDB(String fileName) async {
//     final dbPath = await getDatabasesPath();
//     final path = join(dbPath, fileName);

//     return await openDatabase(
//       path,
//       version: 1,
//       onCreate: _createDB,
//     );
//   }

//   Future<void> _createDB(Database db, int version) async {
//     await db.execute('''
//       CREATE TABLE login_info (
//         userId TEXT PRIMARY KEY,
//         password TEXT NOT NULL,
//         stationCode TEXT
//       )
//     ''');
//   }

//   // Insert login information
//   Future<void> insertLoginInfo(String userId, String password, String stationCode) async {
//     final db = await instance.database;

//     await db.insert(
//       'login_info',
//       {
//         'userId': userId,
//         'password': password,
//         'stationCode': stationCode,
//       },
//       conflictAlgorithm: ConflictAlgorithm.replace,
//     );
//   }

//   // Get login info by userId
//   Future<Map<String, dynamic>?> getLoginInfo(String userId) async {
//     final db = await instance.database;

//     final result = await db.query(
//       'login_info',
//       where: 'userId = ?',
//       whereArgs: [userId],
//     );

//     return result.isNotEmpty ? result.first : null;
//   }

//   // Check if login exists
//   Future<bool> loginExists(String userId, String password) async {
//     final db = await instance.database;

//     final result = await db.query(
//       'login_info',
//       where: 'userId = ? AND password = ?',
//       whereArgs: [userId, password],
//     );

//     return result.isNotEmpty;
//   }

//   // Update login information
//   Future<void> updateLoginInfo(String userId, String newPassword, String newStationCode) async {
//     final db = await instance.database;

//     await db.update(
//       'login_info',
//       {
//         'password': newPassword,
//         'stationCode': newStationCode,
//       },
//       where: 'userId = ?',
//       whereArgs: [userId],
//     );
//   }

//   // Delete login info
//   Future<void> deleteLoginInfo(String userId) async {
//     final db = await instance.database;

//     await db.delete(
//       'login_info',
//       where: 'userId = ?',
//       whereArgs: [userId],
//     );
//   }

//   // Get all login info
//   Future<List<Map<String, dynamic>>> getAllLoginInfo() async {
//     final db = await instance.database;

//     return await db.query('login_info');
//   }

//   // Close the database
//   Future<void> close() async {
//     final db = _database;

//     if (db != null) {
//       await db.close();
//       _database = null;
//     }
//   }
// }
