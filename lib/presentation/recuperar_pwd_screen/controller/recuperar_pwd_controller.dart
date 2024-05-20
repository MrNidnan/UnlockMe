import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../models/recuperar_pwd_model.dart';

/// A controller class for the RecuperarPwdScreen.
///
/// This class manages the state of the RecuperarPwdScreen, including the
/// current recuperarPwdModelObj
class RecuperarPwdController extends GetxController {
  TextEditingController emailController = TextEditingController();

  TextEditingController mobileoneController = TextEditingController();

  Rx<RecuperarPwdModel> recuperarPwdModelObj = RecuperarPwdModel().obs;

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    mobileoneController.dispose();
  }
}
