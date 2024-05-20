import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
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

  @override
  void onClose() {
    super.onClose();
    nameOneController.dispose();
    emailController.dispose();
    passwordOneController.dispose();
    confirmPasswordController.dispose();
  }
}
