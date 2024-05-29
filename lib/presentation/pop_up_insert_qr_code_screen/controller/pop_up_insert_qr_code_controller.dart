import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../models/pop_up_insert_qr_code_model.dart';

/// A controller class for the PopUpInsertQrCodeScreen.
///
/// This class manages the state of the PopUpInsertQrCodeScreen, including the
/// current popUpInsertQrCodeModelObj
class PopUpInsertQrCodeController extends GetxController {
  Rx<PopUpInsertQrCodeModel> popUpInsertQrCodeModelObj =
      PopUpInsertQrCodeModel().obs;
  TextEditingController inputTextController = TextEditingController();

  late Function(String) qrValidationCallback;

  @override
  void onInit() {
    super.onInit();
    qrValidationCallback = Get.arguments as Function(String);
  }

  void goBack() {
    Get.back();
  }

  void readQrString() {
    String qrString = inputTextController.text;
    if (qrString.isNotEmpty) {
      if (qrValidationCallback(qrString)) {
        Get.back();
      }
    } else {
      Get.snackbar(
        'Error',
        'Please enter a QR code.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  @override
  void onClose() {
    inputTextController.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    inputTextController.dispose();
    super.dispose();
  }
}
