import 'package:UnlockMe/core/storage/contracts/user.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static final DatabaseHelper _instance = DatabaseHelper._internal();
  factory DatabaseHelper() => _instance;
  static Database? _database;

  DatabaseHelper._internal();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB();
    return _database!;
  }

  Future<Database> _initDB() async {
    String path = await getDatabasesPath();
    return openDatabase(
      join(path, 'unlockme.db'),
      onCreate: _onCreate,
      version: 1,
    );
  }

  Future _onCreate(Database db, int version) async {
    await db.execute('''
      CREATE TABLE bikes (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        latitude REAL,
        longitude REAL,
        battery_life INTEGER,
        hotelId INTEGER,
        status TEXT
      )
    ''');

    await db.execute('''
      CREATE TABLE users (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        name TEXT,
        lastname TEXT,
        email TEXT,
        password TEXT,
        hotelId INTEGER
      )
    ''');

    await db.execute('''
      CREATE TABLE reserves (
        reserveId INTEGER PRIMARY KEY AUTOINCREMENT,
        userId INTEGER,
        bikeId INTEGER,
        createdAt TEXT,
        endsAt TEXT,
        status TEXT,
        FOREIGN KEY(userId) REFERENCES users(id),
        FOREIGN KEY(bikeId) REFERENCES bikes(id)
      )
    ''');

    await db.execute('''
      CREATE TABLE vehicle_actions (
        actionId INTEGER PRIMARY KEY AUTOINCREMENT,
        tipus_accio TEXT,
        vehicleId INTEGER,
        userId INTEGER,
        FOREIGN KEY(vehicleId) REFERENCES bikes(id),
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');
  }

  // CRUD operations for Users
  Future<int> insertUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

   Future<User?> getUser(String email) async {
    final db = await database;
    final user = await db.query('users', where: 'email = ?', whereArgs: [email]);
    
    if (user.isEmpty){
       return null;
    }
    return User.fromMap(user.first);
  }

  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final db = await database;
    return await db.update('users', user, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD operations for Bikes
  Future<int> insertBike(Map<String, dynamic> bike) async {
    final db = await database;
    return await db.insert('bikes', bike);
  }

  Future<List<Map<String, dynamic>>> getBikes() async {
    final db = await database;
    return await db.query('bikes');
  }

  Future<int> updateBike(int id, Map<String, dynamic> bike) async {
    final db = await database;
    return await db.update('bikes', bike, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteBike(int id) async {
    final db = await database;
    return await db.delete('bikes', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD operations for Reservations
  Future<int> insertReserve(Map<String, dynamic> reservation) async {
    final db = await database;
    return await db.insert('reserves', reservation);
  }

  Future<List<Map<String, dynamic>>> getReserve(int reserveId) async {
    final db = await database;
    return await db.query('reserves', where: 'reserveId = ?', whereArgs: [reserveId]);
  }

  Future<int> updateReserve(int reserveId, Map<String, dynamic> reservation) async {
    final db = await database;
    return await db.update('reserves', reservation, where: 'reserveId = ?', whereArgs: [reserveId]);
  }
}
