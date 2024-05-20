import 'package:flutter/material.dart';
import '../../../core/app_export.dart';
import '../../../data/apiClient/api_client.dart';
import '../../../data/models/loginDeviceAuth/post_login_device_auth_resp.dart';
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

  PostLoginDeviceAuthResp postLoginDeviceAuthResp = PostLoginDeviceAuthResp();

  @override
  void onClose() {
    super.onClose();
    emailController.dispose();
    eyeController.dispose();
  }

  /// Calls the https://nodedemo.dhiwise.co/device/auth/login API with the specified request data.
  ///
  /// The [Map] parameter represents request body
  Future<void> callLoginDeviceAuth(Map req) async {
    try {
      postLoginDeviceAuthResp = await Get.find<ApiClient>().loginDeviceAuth(
        headers: {'Content-Type': 'application/json'},
        requestData: req,
      );
      _handleLoginDeviceAuthSuccess();
    } on PostLoginDeviceAuthResp catch (e) {
      postLoginDeviceAuthResp = e;
      rethrow;
    }
  }

  /// handles the success response for the API
  void _handleLoginDeviceAuthSuccess() {}
}
