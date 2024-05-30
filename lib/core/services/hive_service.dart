import 'package:get/get.dart';
import 'package:hive_flutter/hive_flutter.dart';

/**
Service for managing Hive box access and using constants for keys
Using GetxService with GetX dependency injection provides lifecycle management and easier integration with GetX's reactive state management.
*/
class HiveService extends GetxService {
  /**
   * Retrieving the box reference every time you want to access or set a value can introduce unnecessary overhead, even if it is relatively small. It is more efficient to store the box references as class variables within your HiveService. This way, you only retrieve the box reference once during initialization and reuse it throughout the service's lifetime.
   */
  late Box _reserveBox;
  late Box _userBox;
  Box get reserveBox => _reserveBox;
  Box get userBox => _userBox;

  Future<void> openBoxes() async {
    _reserveBox = await Hive.openBox(reserveBoxName);
    _userBox = await Hive.openBox(userBoxName);
  }

  Future<void> closeHive() async {
    await Hive.close();
  }

  @override
  void onClose() {
    super.onClose();
    closeHive();
  }

  // Getters and Setters
  // convinience methods for getting and setting values in Hive
  int? getReserveId() {
    return _reserveBox.get(reserveIdKey);
  }

  Future<void> setReserve(int reserveId, String endsAt) async {
    await _reserveBox.put(reserveIdKey, reserveId);
    await _reserveBox.put(reserveEndsAtKey, endsAt);
  }

  Future<void> setReserveId(int reserveId) async {
    await _reserveBox.put(reserveIdKey, reserveId);
  }

  String? getReserveEndsAt() {
    return _reserveBox.get(reserveEndsAtKey);
  }

  Future<void> setReserveEndsAtId(String endsAt) async {
    await _reserveBox.put(reserveEndsAtKey, endsAt);
  }

  Future<void> deleteReserve() async {
    await _reserveBox.delete(reserveIdKey);
    await _reserveBox.delete(reserveEndsAtKey);
  }

  int? getUserId() {
    return _userBox.get(userIdKey);
  }

  Future<void> setUserId(int userId) async {
    await _userBox.put(userIdKey, userId);
  }

  int? getHotelId() {
    return _userBox.get(userHotelIdKey);
  }

  Future<void> setHotelId(int userHotelId) async {
    await _userBox.put(userHotelIdKey, userHotelId);
  }

  Future<void> deleteHotelId() async {
    await _userBox.delete(userHotelIdKey);
  }

  int? getRouteId() {
    return _userBox.get(userRouteIdKey);
  }

  Future<void> setUserRoute(
      int userRouteIdKey, String userRouteStartsAt) async {
    await _userBox.put(userRouteIdKey, userRouteIdKey);
    await _userBox.put(userRouteStartsAt, userRouteStartsAt);
  }

  Future<void> deleteUserRoute() async {
    await _userBox.delete(userRouteIdKey);
    await _userBox.delete(userRouteStartsAt);
  }

  String? getRouteStartsAt() {
    return _userBox.get(userRouteStartsAt);
  }

  //// Constants for Hive
  // Box names
  static const String reserveBoxName = 'reserveBox';
  static const String userBoxName = 'userBox';

  // Reserve box keys
  static const String reserveIdKey = 'reserveId';
  static const String reserveEndsAtKey = 'reserveEndsAt';

  // User box keys
  static const String userIdKey = 'userId';
  static const String userHotelIdKey = 'userHotelId';
  static const String userRouteIdKey = 'userRouteId';
  static const String userRouteStartsAt = 'userRouteStartsAt';
}
