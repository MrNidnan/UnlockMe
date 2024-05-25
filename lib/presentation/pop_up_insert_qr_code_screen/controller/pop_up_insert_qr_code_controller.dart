import 'package:flutter/material.dart';

import '../../../core/app_export.dart';
import '../models/pop_up_insert_qr_code_model.dart';

/// A controller class for the PopUpInsertQrCodeScreen.
///
/// This class manages the state of the PopUpInsertQrCodeScreen, including the
/// current popUpInsertQrCodeModelObj
class PopUpInsertQrCodeController extends GetxController {
  Rx<PopUpInsertQrCodeModel> popUpInsertQrCodeModelObj =
      PopUpInsertQrCodeModel().obs;
  TextEditingController inputTextController = TextEditingController();
}
