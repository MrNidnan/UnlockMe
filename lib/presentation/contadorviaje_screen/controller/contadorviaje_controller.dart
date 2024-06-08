import 'package:unlockme/core/app_storage.dart' as db;
import 'package:unlockme/core/utils/logger.dart';
import 'package:unlockme/core/utils/progress_dialog_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import '../../../core/services/hive_service.dart';
import '../../../core/services/travel_timer_service.dart';
import '../models/contadorviaje_model.dart';

/// A controller class for the ContadorviajeScreen.
///
/// This class manages the state of the ContadorviajeScreen, including the
/// current contadorviajeModelObj
class ContadorviajeController extends GetxController {
  Rx<ContadorviajeModel> contadorviajeModelObj = ContadorviajeModel().obs;

  late TravelTimerService _travelTimerService;
  RxInt get routeTime => _travelTimerService.accumulatedTime;

  late final HiveService _hiveService;
  final _dbHelper = db.DatabaseHelper();
  late final _userId;
  late final _travelRoute;
  Rx<String> routeCreatedAt = ''.obs;
  bool routeFinished = false;

  @override
  void onInit() async {
    super.onInit();
    _travelTimerService = Get.find<TravelTimerService>();
    _hiveService = Get.find<HiveService>();
    await _hiveService.openBoxes();
    // Logger.logDebug(
    //     'ContadorviajeController initialized ${_hiveService.getRouteId()}');
  }

  @override
  void onReady() async {
    super.onReady();
    _userId = _hiveService.getUserId();
    if (_userId == null) {
      Logger.logError('User ID is null, cannot end travel route!');
      return;
    }
    Logger.logDebug('User ID: $_userId');
    _travelRoute = await _dbHelper.getCurrentRouteForUser(_userId);
    Logger.logDebug(
        'Route: ${_travelRoute?.routeId} ${_travelRoute?.createdAt}');
    if (_travelRoute != null) {
      DateTime dateTime = DateTime.parse(_travelRoute.createdAt);
      String formattedDate = DateFormat('hh:mm:ss a').format(dateTime);
      routeCreatedAt.value = formattedDate;
    }
  }

  void endTravelRoute() async {
    ProgressDialogUtils.showProgressDialog();
    if (_userId == null || _travelRoute == null) {
      Logger.logError(
          'User ID is: $_userId. Route ais $_travelRoute. Cannot end travel route!');
      return;
    }
    await finishRoute(_travelRoute);
    Future.delayed(const Duration(seconds: 1), () {
      ProgressDialogUtils.hideProgressDialog();
    });
  }

  Future<void> finishRoute(db.Route route) async {
    // Cancel the travel timer
    try {
      _travelTimerService.cancelTimer();
      routeFinished = true;
      // Get bike to get it's current position, as is safer than the device one
      // Bike position should be updated in the backend on retrieval the bike.
      var bike = await _dbHelper.getBikeById(route.vehicleId);
      // Update vehicle action to ended
      _dbHelper.updateRouteEnd(route.routeId!, bike.latitude, bike.longitude);
      await _hiveService.deleteUserRoute();

      _dbHelper.updateBikeStatus(route.vehicleId, db.BikeStatus.available);
      goBackToMap();
    } catch (e) {
      Logger.logError('Error stopping travel: $e');
      Get.snackbar('Error cancelling travel', 'Unable to end travel right now',
          backgroundColor: Colors.red);
      routeFinished = false;
    }
  }

  String getTimerTime() {
    final time = routeTime.value;
    final hours = (time ~/ 3600).toString().padLeft(2, '0');
    final minutes = ((time % 3600) ~/ 60).toString().padLeft(2, '0');
    final seconds = (time % 60).toString().padLeft(2, '0');
    return '$hours:$minutes:$seconds';
  }

  void goBackToMap() {
    Get.back();
  }
}
