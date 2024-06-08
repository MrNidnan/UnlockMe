import 'package:unlockme/core/services/hive_service.dart';
import 'package:unlockme/domain/users/user_service.dart';
import 'package:unlockme/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unlockme/core/storage/contracts/user.dart';
import '../models/register_model.dart';

/// A controller class for the RegisterScreen.
///
/// This class manages the state of the RegisterScreen, including the
/// current registerModelObj
class RegisterController extends GetxController {
  TextEditingController nameOneController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordOneController = TextEditingController();
  TextEditingController confirmPasswordController = TextEditingController();

  Rx<RegisterModel> registerModelObj = RegisterModel().obs;
  Rx<bool> isShowPassword = true.obs;
  Rx<bool> isShowPassword1 = true.obs;
  Rx<bool> recordarMisDatos = false.obs;
  late final HiveService _hiveService;
  late final UserService _userService;

  @override
  void onInit() {
    super.onInit();
    _hiveService = Get.find<HiveService>();
    _hiveService.openBoxes();
    _userService = Get.find<UserService>();

    // Initialize emailController if email is passed as a parameter
    if (Get.arguments != null && Get.arguments is String) {
      emailController.text = Get.arguments;
    }
  }

  @override
  void onClose() {
    super.onClose();
    nameOneController.dispose();
    emailController.dispose();
    passwordOneController.dispose();
    confirmPasswordController.dispose();
  }

  Future<void> registerUser() async {
    final name = nameOneController.text.trim();
    final email = emailController.text.trim();
    final password = passwordOneController.text.trim();

    int result = await _userService
        .createUser(User(name: name, email: email, password: password));

    if (result == -1) {
      Get.rawSnackbar(message: "User already exists with that email!");
      return;
    }

    Get.rawSnackbar(message: "User registered successfully.");
    await Future.delayed(const Duration(seconds: 2));

    Get.offNamed(AppRoutes.mapaScreen);
  }
}
