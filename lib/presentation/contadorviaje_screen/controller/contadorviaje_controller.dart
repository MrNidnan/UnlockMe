import 'package:UnlockMe/core/app_storage.dart';
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

  final TravelTimerService _travelTimerService = Get.find<TravelTimerService>();
  late final HiveService _hiveService;
  final DatabaseHelper _dbHelper = DatabaseHelper();

  @override
  void onInit() {
    super.onInit();
    _hiveService = Get.find<HiveService>();
    _hiveService.openBoxes();
  }

  void endTravel() async {
    final travelId = _hiveService.getTravelId();
    if (travelId == null) {
      Logger.logError('Travel ID is null');
      return;
    }
    //get travel from db by user id
    //check if travel is active
    //TODO: check if this is the correct way to get vehicle action
    // to fix if travelId is null
    await _dbHelper.getVehicleAction(travelId!).then((vehicleAction) async {
      if (vehicleAction == null) return;
      await stopTravel(vehicleAction);
    });
  }

  Future<void> stopTravel(VehicleAction vehicleAction) async {
    // Cancel the travel timer
    try {
      _travelTimerService.cancelTimer();

      int bikeId = vehicleAction.vehicleId;
      // Update vehicle action to ended
      _dbHelper.setVehicleAction(
          VehicleActionType.ended,
          DateTime.now().toIso8601String(),
          vehicleAction.vehicleId,
          vehicleAction.userId);
      _hiveService.deleteUserTravel();

      _dbHelper.updateBikeStatus(bikeId, BikeStatus.available);
    } catch (e) {
      Logger.logError('Error stopping travel: $e');
      Get.snackbar('Error cancelling travel', 'Unable to end travel right now',
          backgroundColor: Colors.red);
    }
  }
}
