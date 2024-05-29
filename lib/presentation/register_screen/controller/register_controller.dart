import 'package:UnlockMe/core/services/hive_service.dart';
import 'package:UnlockMe/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:UnlockMe/core/storage/contracts/user.dart';
import 'package:UnlockMe/core/storage/database_helper.dart';
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

  @override
  void onInit() {
    super.onInit();
    _hiveService = Get.find<HiveService>();
    _hiveService.openBoxes();
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
    final dbHelper = DatabaseHelper();
    final email = emailController.text.trim();
    final existingUser = await dbHelper.getUser(email);

    if (existingUser != null) {
      Get.rawSnackbar(message: "User with this email already exists.");
      return;
    }

    final user = User(
      name: nameOneController.text.trim(),
      email: email,
      password: passwordOneController.text.trim(),
      hotelId: 0,
    );

    var userId = await dbHelper.insertUser(user);
    await _hiveService.setUserId(userId);
    await _hiveService.setHotelId(user.hotelId!);

    Get.rawSnackbar(message: "User registered successfully.");
    await Future.delayed(Duration(seconds: 2));

    Get.offNamed(AppRoutes.mapaScreen);
  }
}
