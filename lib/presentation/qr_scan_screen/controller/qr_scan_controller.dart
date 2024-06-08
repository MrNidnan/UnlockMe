import 'package:unlockme/core/services/hive_service.dart';
import 'package:unlockme/core/services/travel_timer_service.dart';
import 'package:unlockme/presentation/mapa_screen/controller/mapa_controller.dart';
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';
import 'package:unlockme/core/app_export.dart';
import 'package:unlockme/core/app_storage.dart' as db;
import '../models/qr_scan_model.dart';

class QrScanController extends GetxController {
  Rx<QrScanModel> qrScanModel = QrScanModel().obs;
  QRViewController? qrViewController;
  final dbHelper = db.DatabaseHelper();

  late final int? _reserveId;
  late final int? _userId;
  late final int? _userHotelId;
  // Singleton Services instances
  late final TravelTimerService _travelTimerService;
  late final ReserveTimerService _reserveTimerService;
  late final HiveService _hiveService;

  @override
  void onInit() async {
    super.onInit();
    _hiveService = Get.find<HiveService>();
    _hiveService.openBoxes();

    _travelTimerService = Get.find<TravelTimerService>();
    _reserveTimerService = Get.find<ReserveTimerService>();

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
      Get.back();
    }
    qrViewController?.resumeCamera();
  }

  ///
  //  get actives reserve  user from db
  //     if exists compare bikeId with the bikeId from the reserve
  //     if they are different show error indicating you have another bike reserved
  //    UnlockVehicle() if the user has no active reserves or the bikeId reserve is equal to the bikeId scanned
  ///
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
      await startRoute(bike);
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

  Future<void> _unlockVehicle(db.Bike bike) async {
    Logger.logDebug('Unlocking bike with ID: ${bike.id}');

    // Update bike status to inUse (triggering on the admin backend the unlock of the bike)
    await dbHelper.updateBike(bike.id!, {'status': db.BikeStatus.inUse});
    // Update reserve status to used and delete the reserve from the local storage
    if (_reserveId != null && _reserveId! > 0) {
      await dbHelper
          .updateReserve(_reserveId!, {'status': db.ReserveStatus.used});
      _hiveService.deleteReserve();
      _reserveTimerService.cancelTimer();
    }
  }

  //Start travel timer and variables
  Future<void> startRoute(db.Bike bike) async {
    final currentDate = DateTime.now();
    var routeId = await dbHelper.insertRoute(
      db.Route(
        vehicleId: bike.id!,
        userId: _userId!,
        createdAt: currentDate.toIso8601String(),
        startLatitude: bike.latitude,
        startLongitude: bike.longitude,
      ),
    );
    Logger.logDebug('Route started with ID: $routeId');

    await _hiveService.setUserRoute(routeId, currentDate.toIso8601String());
    _travelTimerService.startTimer(currentDate);
  }

  //Validates Qr and gets the bike
  Future<db.Bike?> _getBikeWithQrCode(String code) async {
    Logger.logDebug('Validating QR code: $code');
    if (code.isNotEmpty && code.startsWith('VALID')) {
      // Implement logic querying DB and external services to validate QR code and unlock bike
      // Query the database for the vehicle with the associated QR code
      db.Bike? bike = await dbHelper.getBikeByQrCode(code, _userHotelId!);
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
      AppRoutes.qrManualScreen,
      arguments: _onManualQrSubmit,
    )?.then((value) {
      // Retrieve MapaController and trigger refresh so the map will be updated
      MapaController mapaController = Get.find<MapaController>();
      mapaController.updateMap();
    });
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
