import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:UnlockMe/core/app_export.dart';
import '../models/escanear_qr_model.dart';

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
      _handleScannedData(scanData);
    });
  }

  void _handleScannedData(Barcode scanData) {
    qrViewController?.pauseCamera();
    Logger.logDebug('Scanned Data: ${scanData.code}, Type: ${scanData.format}');
    String scannedCode = scanData.code ?? '';
    _validateQrCode(scannedCode);
    qrViewController?.resumeCamera();
  }

  void _validateQrCode(String scannedCode) {
    if (_isValidQrCode(scannedCode)) {
      // Handle valid QR code
      Get.snackbar(
        'Success',
        'Valid QR code scanned!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
      Get.back();
      // You can add further processing here
    } else {
      // Handle invalid QR code
      Get.snackbar(
        'Error',
        'Invalid QR code. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
    }
  }

  bool _isValidQrCode(String code) {
    // For demo purpose TODO: Implement logic querying DB and external services to validate QR code and unlock bike
    return code.isNotEmpty && code.startsWith('VALID');
  }

  void onQrScan() {
    // Handle QR scan button tap if needed
  }

  void _onManualQrSubmit(String manualCode) {
    _validateQrCode(manualCode);
  }

  void navigateToManualQr() {
    Get.offAndToNamed(
      AppRoutes.popUpInsertQrCodeScreen,
      arguments: _onManualQrSubmit,
    );
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
