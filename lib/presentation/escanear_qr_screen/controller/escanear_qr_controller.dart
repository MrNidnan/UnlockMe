import 'package:UnlockMe/core/services/hive_service.dart';
import 'package:UnlockMe/core/services/travel_timer_service.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:UnlockMe/core/app_export.dart';
import 'package:UnlockMe/core/app_storage.dart';
import '../models/escanear_qr_model.dart';

class EscanearQrController extends GetxController {
  Rx<EscanearQrModel> escanearQrModelObj = EscanearQrModel().obs;
  QRViewController? qrViewController;
  final dbHelper = DatabaseHelper();

  late final int? _reserveId;
  late final int? _userId;
  late final int? _userHotelId;
  // Singleton Services instances
  late final TravelTimerService _timerService;
  late final HiveService _hiveService;

  @override
  void onInit() async {
    super.onInit();
    _hiveService = Get.find<HiveService>();
    _hiveService.openBoxes();

    _timerService = Get.find<TravelTimerService>();

    _reserveId = _hiveService.getReserveId();
    _userId = _hiveService.getUserId();
    _userHotelId = _hiveService.getHotelId();
  }

  void onQRViewCreated(QRViewController controller) {
    qrViewController = controller;
    controller.scannedDataStream.listen((scanData) {
      _handleScannedData(scanData);
    });
  }

  void _handleScannedData(Barcode scanData) async {
    qrViewController?.pauseCamera();
    Logger.logDebug('Scanned Data: ${scanData.code}, Type: ${scanData.format}');
    String scannedCode = scanData.code ?? '';
    bool isOk = await _validateQrAndStartTravel(scannedCode);

    if (isOk) {
      Get.snackbar(
        'Success',
        'Bike unlocked successfully!',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.green,
      );
      Future.delayed(Duration(seconds: 2), () {
        Get.back();
      });
      //Get.back();
      return;
    }
    qrViewController?.resumeCamera();
  }

  /**
   * // get actives reserve  user from db
      // if exists compare bikeId with the bikeId from the reserve
      // if they are different show error indicating you have another bike reserved
      //UnlockVehicle() if the user has no active reserves or the bikeId reserve is equal to the bikeId scanned
   */
  Future<bool> _validateQrAndStartTravel(String scannedCode) async {
    try {
      var bike = await _getBikeWithQrCode(scannedCode);
      if (bike == null) {
        Get.snackbar(
          'Error',
          'Invalid QR code.',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.red,
        );
        return false;
      }

      // Check active reservations
      var activeReserve = await dbHelper.getActiveReserveForUser(_userId!);
      if (activeReserve != null && activeReserve.bikeId != bike.id) {
        Get.snackbar(
          'Error',
          'This is not your bike! You have another bike reserved.',
          snackPosition: SnackPosition.TOP,
          backgroundColor: Colors.red,
        );
        return false;
      }

      await _unlockVehicle(bike);
      await startTravel(bike);
      return true;
    } catch (e) {
      Logger.logError('Error unlocking bike: $e');
      Get.snackbar(
        'Error',
        'An error occurred while unlocking the bike. Please try again.',
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
      );
      return false;
    }
  }

  Future<void> _unlockVehicle(Bike bike) async {
    Logger.logDebug('Unlocking bike with ID: ${bike.id}');

    // Update bike status to inUse (triggering on the admin backend the unlock of the bike)
    await dbHelper.updateBike(bike.id!, {'status': BikeStatus.inUse});
    // Update reserve status to used and delete the reserve from the local storage
    if (_reserveId != null && _reserveId! > 0) {
      await dbHelper.updateReserve(_reserveId!, {'status': ReserveStatus.used});
      _hiveService.deleteReserve();
    }
  }

  //Start travel timer and variables
  Future<void> startTravel(Bike bike) async {
    final currentDate = DateTime.now();
    var travelId = await dbHelper.setVehicleAction(VehicleActionType.started,
        currentDate.toIso8601String(), bike.id!, _userId!);
    _hiveService.setUserTravel(travelId, currentDate.toIso8601String());
    _timerService.startTimer(currentDate);
  }

  //Validates Qr and gets the bike
  Future<Bike?> _getBikeWithQrCode(String code) async {
    Logger.logDebug('Validating QR code: $code');
    if (code.isNotEmpty && code.startsWith('VALID')) {
      // Implement logic querying DB and external services to validate QR code and unlock bike
      // Query the database for the vehicle with the associated QR code
      Bike? bike = await dbHelper.getBikeByQrCode(code, _userHotelId!);
      return bike;
    }
    return null;
  }

  void onQrScan() {
    // Handle QR scan button tap if needed
  }

  Future<bool> _onManualQrSubmit(String manualCode) async {
    return await _validateQrAndStartTravel(manualCode);
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
