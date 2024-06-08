import 'package:get/get.dart';
import 'package:unlockme/core/services/hive_service.dart';
import 'package:unlockme/core/storage/contracts/user.dart';
import 'package:unlockme/core/storage/database_helper.dart';
import 'package:unlockme/core/app_storage.dart' as db;

class UserService extends GetxService {
  late final DatabaseHelper _dbHelper;
  late final HiveService _hiveService;

  @override
  void onInit() {
    super.onInit();
    _dbHelper = db.DatabaseHelper();
    _hiveService = Get.find<HiveService>();
  }

  Future<User?> getUserByEmail(String email) async {
    return await _dbHelper.getUser(email);
  }

  Future<int> createUser(User user) async {
    final existingUser = await _dbHelper.getUser(user.email);

    if (existingUser != null) {
      return -1;
    }

    //TODO remove magic number
    user.hotelId = 1;

    var userId = await _dbHelper.insertUser(user);
    await _hiveService.setUserId(userId);
    await _hiveService.setHotelId(user.hotelId!);

    return userId; // No error message, registration successful
  }
}
