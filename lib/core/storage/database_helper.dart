import 'package:UnlockMe/core/storage/contracts/enums_constants.dart';
import 'package:UnlockMe/core/storage/contracts/user.dart';
import 'package:UnlockMe/core/storage/contracts/vehicle_action.dart';
import 'package:UnlockMe/core/utils/logger.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

import 'contracts/bike.dart';
import 'contracts/reserve.dart';

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
        status TEXT,
        qrCode TEXT
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
    //TODO change to travels
    await db.execute('''
      CREATE TABLE vehicle_actions (
        actionId INTEGER PRIMARY KEY AUTOINCREMENT,
        action_type TEXT,
        createdAt TEXT DEFAULT CURRENT_TIMESTAMP,
        vehicleId INTEGER,
        userId INTEGER,
        FOREIGN KEY(vehicleId) REFERENCES bikes(id),
        FOREIGN KEY(userId) REFERENCES users(id)
      )
    ''');
  }

  Future<void> populateWithFakeData() async {
    final users = await getUsers();
    if (users.isEmpty) {
      User user = User(
        name: 'Angel',
        lastname: 'Test',
        email: 'angel@test.com',
        password: '12345678',
        hotelId: 1,
      );
      await this.insertUser(user);
    }

    final bikes = await getBikes();
    if (bikes.isEmpty) {
      // Insert a couple of bikes with coordinates from Barcelona
      Bike bike1 = Bike(
          latitude: 41.3851,
          longitude: 2.1734,
          batteryLife: 85,
          hotelId: 1,
          status: 'available',
          qrCode: 'VALID123abc');
      await this.insertBike(bike1);

      Bike bike2 = Bike(
          latitude: 41.3879,
          longitude: 2.1699,
          batteryLife: 90,
          hotelId: 1,
          status: 'available',
          qrCode: 'VALID456def');
      await this.insertBike(bike2);

      // Bike bike3 = Bike(
      //     latitude: 41.3979,
      //     longitude: 2.1899,
      //     batteryLife: 90,
      //     hotelId: 2,
      //     status: 'available',
      //     qrCode: 'VALID456def');
      // await this.insertBike(bike3);
    }
  }

  Future<void> clearDatabase() async {
    final db = await database;
    await db.delete('users');
    await db.delete('bikes');
    await db.delete('reserves');
  }

  Future<void> closeDatabase() async {
    if (_database != null) {
      await _database!.close();
      _database = null;
    }
  }

  Future<void> deleteAndRecreateDatabase() async {
    String path = join(await getDatabasesPath(), 'unlockme.db');
    // Close the database before deleting it
    await closeDatabase();
    // Delete the database file
    if (await databaseExists(path)) {
      await deleteDatabase(path);
    }
    // Reinitialize the database
    _database = await _initDB();
    await populateWithFakeData();
  }

  Future<List<Map<String, dynamic>>> getUsers() async {
    final db = await database;
    return await db.query('users');
  }

  Future<int> updateUser(int id, Map<String, dynamic> user) async {
    final db = await database;
    return await db.update('users', user, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> insertUser(User user) async {
    final db = await database;
    return await db.insert(
      'users',
      user.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<User?> getUser(String email) async {
    final db = await database;
    final user =
        await db.query('users', where: 'email = ?', whereArgs: [email]);

    if (user.isEmpty) {
      return null;
    }
    return User.fromMap(user.first);
  }

  // Future<int> updateUser(User user) async {
  //   final db = await database;
  //   return await db.update(
  //     'users',
  //     user.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [user.id],
  //   );
  // }

  Future<int> deleteUser(int id) async {
    final db = await database;
    return await db.delete('users', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD operations for Bikes
  Future<int> insertBike(Bike bike) async {
    final db = await database;
    return await db.insert(
      'bikes',
      bike.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<List<Bike>> getUserBikes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bikes');
    return List.generate(maps.length, (i) {
      return Bike.fromMap(maps[i]);
    });
  }

  Future<List<Bike>> getBikes() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bikes');
    return List.generate(maps.length, (i) {
      return Bike.fromMap(maps[i]);
    });
  }

  Future<Bike> getBikeById(int id) async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('bikes', where: 'id = ?', whereArgs: [id]);
    return Bike.fromMap(maps.first);
  }

  Future<Bike?> getBikeByQrCode(String qrCode, int hotelId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('bikes',
        where: 'qrCode = ? AND hotelId = ?', whereArgs: [qrCode, hotelId]);
    if (maps.isNotEmpty) {
      return Bike.fromMap(maps.first);
    }
    return null;
  }

  Future<void> updateBikeStatus(int bikeId, String status) async {
    Logger.logDebug('Updating bike status: $status, bikeId: $bikeId');

    final db = await database;
    await db.update(
      'bikes',
      {'status': status},
      where: 'id = ?',
      whereArgs: [bikeId],
    );
  }

  // Future<int> updateBike(Bike bike) async {
  //   final db = await database;
  //   return await db.update(
  //     'bikes',
  //     bike.toMap(),
  //     where: 'id = ?',
  //     whereArgs: [bike.id],
  //   );
  // }

  Future<int> updateBike(int id, Map<String, dynamic> bike) async {
    final db = await database;
    return await db.update('bikes', bike, where: 'id = ?', whereArgs: [id]);
  }

  Future<int> deleteBike(int id) async {
    final db = await database;
    return await db.delete('bikes', where: 'id = ?', whereArgs: [id]);
  }

  // CRUD operations for Reservations
  Future<int> insertReserve(Reserve reserve) async {
    final db = await database;
    return await db.insert(
      'reserves',
      reserve.toMap(),
      conflictAlgorithm: ConflictAlgorithm.fail,
    );
  }

  Future<List<Reserve>> getReserves() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reserves');
    return List.generate(maps.length, (i) {
      return Reserve.fromMap(maps[i]);
    });
  }

  // Future<int> updateReserve(Reserve reserve) async {
  //   final db = await database;
  //   return await db.update(
  //     'reserves',
  //     reserve.toMap(),
  //     where: 'reserveId = ?',
  //     whereArgs: [reserve.reserveId],
  //   );
  // }

  Future<int> updateReserve(int id, Map<String, dynamic> reserve) async {
    final db = await database;
    return await db
        .update('reserves', reserve, where: 'reserveId = ?', whereArgs: [id]);
  }

  Future<void> updateReserveStatus(int reserveId, String status) async {
    final db = await database;
    await db.update(
      'reserves',
      {'status': status},
      where: 'reserveId = ?',
      whereArgs: [reserveId],
    );
  }

  Future<int> deleteReserve(int reserveId) async {
    final db = await database;
    return await db.delete(
      'reserves',
      where: 'reserveId = ?',
      whereArgs: [reserveId],
    );
  }

  Future<Reserve?> getActiveReserveForUser(int userId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('reserves',
        where: 'userId = ? AND status = ?',
        whereArgs: [userId, ReserveStatus.active]);
    if (maps.isNotEmpty) {
      return Reserve.fromMap(maps.first);
    }
    return null;
  }

  // Insert or update vehicle Action
  Future<int> setVehicleAction(
      String actionType, String dateAsString, int vehicleId, int userId) async {
    final db = await database;
    return await db.insert(
      'vehicle_actions',
      {
        'action_type': actionType,
        'createdAt': dateAsString,
        'vehicleId': vehicleId,
        'userId': userId,
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<VehicleAction?> getVehicleAction(int actionId) async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db
        .query('vehicle_actions', where: 'actionId = ?', whereArgs: [actionId]);
    if (maps.isNotEmpty) {
      Logger.logDebug('Vehicle action: ${maps.first}');
      return VehicleAction.fromMap(maps.first);
    }
    return null;
  }
}
