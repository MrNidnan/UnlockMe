import 'package:qr_code_scanner/qr_code_scanner.dart';

import '../../../core/app_export.dart';
import '../models/escanear_qr_model.dart';

/// A controller class for the EscanearQrScreen.
///
/// This class manages the state of the EscanearQrScreen, including the
/// current escanearQrModelObj
class EscanearQrController extends GetxController {
  Rx<EscanearQrModel> escanearQrModelObj = EscanearQrModel().obs;
  QRViewController? qrViewController;

  @override
  void onInit() {
    super.onInit();
  }

  void onQRViewCreated(QRViewController controller) {
    qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      //Handle the scanned data
      controller.pauseCamera();
    });
  }

  void onQrScan() {
    // Handle QR scan button tap
  }

  void navigateToManualQr() {
    //navigates to the specified named route and then immediately pops back to the previous route
    //Navigator.popAndPushNamed()
    Get.offAndToNamed(AppRoutes.popUpInsertQrCodeScreen);
  }

  @override
  void onClose() {
    qrViewController?.dispose();
    super.onClose();
  }

  @override
  void dispose() {
    qrViewController?.dispose();
    super.dispose();
  }
}
