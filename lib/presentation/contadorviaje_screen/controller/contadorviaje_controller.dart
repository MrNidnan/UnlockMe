import 'package:UnlockMe/core/app_storage.dart' as db;
import 'package:UnlockMe/core/utils/logger.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../core/services/hive_service.dart';
import '../../../core/services/travel_timer_service.dart';
import '../models/contadorviaje_model.dart';

/// A controller class for the ContadorviajeScreen.
///
/// This class manages the state of the ContadorviajeScreen, including the
/// current contadorviajeModelObj
class ContadorviajeController extends GetxController {
  Rx<ContadorviajeModel> contadorviajeModelObj = ContadorviajeModel().obs;

  final _travelTimerService = Get.find<TravelTimerService>();
  final _hiveService = Get.find<HiveService>();
  final _dbHelper = db.DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    _hiveService.openBoxes();
    Logger.logDebug(
        'ContadorviajeController initializedÑ ${_hiveService.getRouteId()}');
  }

  void endTravelRoute() async {
    final userId = _hiveService.getUserId();
    if (userId == null) {
      Logger.logError('User ID is null, cannot end travel route!');
      return;
    }

    await _dbHelper.getCurrentRouteForUser(userId).then((route) async {
      if (route == null) return;
      await finishRoute(route);
    });
  }

  Future<void> finishRoute(db.Route route) async {
    // Cancel the travel timer
    try {
      _travelTimerService.cancelTimer();

      // Get bike to get it's current position, as is safer than the device one
      // Bike position should be updated in the backend on retrieval the bike.
      var bike = await _dbHelper.getBikeById(route.vehicleId);
      // Update vehicle action to ended
      _dbHelper.updateRouteEnd(route.routeId!, bike.latitude, bike.longitude);
      await _hiveService.deleteUserRoute();

      _dbHelper.updateBikeStatus(route.vehicleId, db.BikeStatus.available);
    } catch (e) {
      Logger.logError('Error stopping travel: $e');
      Get.snackbar('Error cancelling travel', 'Unable to end travel right now',
          backgroundColor: Colors.red);
    }
  }
}
