import 'package:UnlockMe/core/services/hive_service.dart';
import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../data/models/loginDeviceAuth/post_login_device_auth_resp.dart';
import '../../../core/storage/contracts/user.dart';
import '../../../core/storage/database_helper.dart';

import '../models/login_model.dart';

/// A controller class for the LoginScreen.
///
/// This class manages the state of the LoginScreen, including the
/// current loginModelObj
class LoginController extends GetxController {
  TextEditingController emailController = TextEditingController();
  TextEditingController eyeController = TextEditingController();

  Rx<LoginModel> loginModelObj = LoginModel().obs;
  Rx<bool> isShowPassword = true.obs;
  Rx<bool> recordarMisDato = false.obs;
  Rx<bool> reply = false.obs;

  late final HiveService _hiveService;

  @override
  void onInit() {
    super.onInit();
    _init();
  }

  _init() {
    _hiveService = Get.find<HiveService>();
    _hiveService.openBoxes();
  }

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    eyeController.dispose();
  }

  /// Calls the mock authentication method
  Future<void> callAuthMock() async {
    final dbHelper = DatabaseHelper();
    final user = await dbHelper.getUser(emailController.text.trim());

    if (user != null && eyeController.text == user.password) {
      _onCallAuthSuccess(user);
    } else {
      _onCallAuthError(user);
    }
  }

  void _onCallAuthSuccess(User user) async {
    await _hiveService.setUserId(user.id!);
    await _hiveService.setHotelId(user.hotelId!);

    Get.toNamed(AppRoutes.mapaScreen);
  }

  void _onCallAuthError(User? user) {
    if (user == null) {
      Logger.logError('User not found');
      Get.rawSnackbar(message: "User not found");
    } else {
      Logger.logError('Invalid password');
      Get.rawSnackbar(message: "Invalid password");
    }
  }

  void navigateToRegister() {
    Get.toNamed(AppRoutes.registerScreen,
        arguments: emailController.text.trim());
  }

  void navigateToRecoverPwd() {
    Get.toNamed(AppRoutes.recuperarPwdScreen,
        arguments: emailController.text.trim());
  }
}
