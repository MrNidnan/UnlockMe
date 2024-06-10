import 'package:unlockme/core/app_export.dart';
import 'package:unlockme/core/app_storage.dart';
import 'package:unlockme/core/services/hive_service.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import '../models/pantalla_reserva_model.dart';

class PantallaReservaController extends GetxController {
  //late defines a variable that is not initialized when it is declared
  late Rx<PantallaReservaModel> pantallaReservaModelObj;
  // Singleton TimerService instance
  final ReserveTimerService _timerService = Get.find<ReserveTimerService>();
  // Observing the timer state from TimerService
  RxInt get remainingTime => _timerService.remainingTime;
  Rx<String> address = 'Address Unknown'.obs;

  final dbHelper = DatabaseHelper();
  late final HiveService _hiveService;
  late int? _reserveId;
  late String? _reserveEndsAt;

  @override
  void onInit() async {
    super.onInit();
    final args = Get.arguments;
    Bike bike = args['bike'] as Bike;

    // Initialize the model with the bike status
    pantallaReservaModelObj = PantallaReservaModel(
      bike: bike,
      isReserved: bike.status == BikeStatus.reserved,
    ).obs;
    _hiveService = Get.find<HiveService>();
    await _hiveService.openBoxes();
    await _initializeReserve(bike);
    await _retrieveAddress(bike);

    _timerService.onExpire = onExpireReserve;
    _timerService.onCancel = _cancelReservation;
  }

  Future<void> _initializeReserve(Bike bike) async {
    Logger.logDebug('Reserve Screen BikeStatus: ${bike.status}');

    _reserveId = _hiveService.getReserveId();
    _reserveEndsAt = _hiveService.getReserveEndsAt();

    //(In case screen was not updated properly, we must check the source of truth in the database)
    //That is if:
    //  bike status is reserved, but the reserveId is null
    //  or bike status is available, but the reserveId is not null
    if ((pantallaReservaModelObj.value.isReserved && _reserveId == null) ||
        (!pantallaReservaModelObj.value.isReserved && _reserveId != null)) {
      await dbHelper.getBikeById(bike.id!).then((bike) {
        Logger.logDebug(' retrieved BikeStatus: ${bike.status}');
        pantallaReservaModelObj.update((model) {
          model?.isReserved = bike.status == BikeStatus.reserved;
        });
      });
    }

    Logger.logDebug('Reserve Ends At: $_reserveEndsAt');
    Logger.logDebug('ReserveId: $_reserveId');
    Logger.logDebug('IsReserved: ${pantallaReservaModelObj.value.isReserved}');

    //If the bike is already reserved by the user
    // Load the reservation details and start the timer
    if (pantallaReservaModelObj.value.isReserved) {
      if (_reserveId != null) {
        pantallaReservaModelObj.update((model) {
          model?.endsAt = DateTime.parse(_reserveEndsAt!);
        });
        _timerService.startTimer(pantallaReservaModelObj.value.endsAt!);
      }
    }
  }

  Future<void> _retrieveAddress(Bike bike) async {
    try {
      var retrievedAddress =
          await getAddressFromCoordinates(bike.latitude, bike.longitude);
      address.value = retrievedAddress ?? 'Address Unknown';
      Logger.logDebug('Address: $address');
    } catch (e) {
      Logger.logError('Error: $e');
    }
  }

  @override
  void onClose() {
    //// Do NOT cancel the timer here as we want to run it even when the screen is closed to cancel the reservation
    super.onClose();
  }

  Future<void> createReservation() async {
    //if there is already a reservation, return
    if (_hiveService.getReserveId() != null) {
      Get.snackbar('Reservation', 'You already have a reservation!',
          backgroundColor: Colors.red);
      return;
    }
    if (_hiveService.getRouteId() != null) {
      Get.snackbar('Reservation', 'You are already on a travel route!',
          backgroundColor: Colors.red);
      return;
    }

    final int? userId = _hiveService.getUserId();
    final int? userHotelId = _hiveService.getHotelId();
    Logger.logDebug('User=$userId:$userHotelId');
    if (userId == null || userHotelId == null) {
      Get.snackbar('Reserve error', 'User or Hotel not found!',
          backgroundColor: Colors.red);
      return;
    }

    final reserveAt = DateTime.now();
    final reserveId = await dbHelper.insertReserve(Reserve(
        userId: userId,
        bikeId: pantallaReservaModelObj.value.bike.id!,
        createdAt: reserveAt.toIso8601String(),
        endsAt: reserveAt.add(const Duration(seconds: 30)).toIso8601String(),
        status: ReserveStatus.active));

    Logger.logDebug('reserveId created: $reserveId');

    _hiveService.setReserve(
        reserveId, reserveAt.add(const Duration(seconds: 30)).toIso8601String());

    Logger.logDebug('Reserve Ends At: ${_hiveService.getReserveEndsAt()}');

    pantallaReservaModelObj.update((model) {
      model?.isReserved = true;
      model?.endsAt = DateTime.now().add(const Duration(seconds: 30));
    });

    _timerService.startTimer(pantallaReservaModelObj.value.endsAt!);
    await updateBikeStatus();
    Get.snackbar('Reservation', 'Bike reserved successfully!');
  }

  void onExpireReserve() async {
    await _cancelReservation();
    //final MapaController mapaController = Get.find<MapaController>();
    //mapaController.updateMap();
    Get.snackbar('Reservation', 'Reservation expired!');
  }

  void onCancelReserve() async {
    final isConfirmed = await _showConfirmationDialog();
    if (isConfirmed) {
      _timerService.cancelTimer();
      Get.snackbar('Reservation', 'Reservation cancelled successfully!');
    }
  }

  Future<void> _cancelReservation() async {
    final reserveId = _hiveService.getReserveId();
    final userId = _hiveService.getUserId();
    Logger.logDebug('ReserveId on cancelReservation: $reserveId $userId');

    if (reserveId != null) {
      await dbHelper.updateReserve(reserveId, {
        'status': ReserveStatus.cancelled,
      });
      _hiveService.deleteReserve();
      pantallaReservaModelObj.update((model) {
        model?.isReserved = false;
        model?.endsAt = null;
      });
      await updateBikeStatus();
    }
  }

  Future<void> updateBikeStatus() async {
    await dbHelper.updateBikeStatus(
        pantallaReservaModelObj.value.bike.id!,
        pantallaReservaModelObj.value.isReserved
            ? BikeStatus.reserved
            : BikeStatus.available);
  }

  Future<bool> _showConfirmationDialog() async {
    return await Get.dialog(
          AlertDialog(
            title: const Text('Cancel Reservation'),
            content: const Text('Are you sure you want to cancel the reservation?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: const Text(
                  'No',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: const Text(
                  'Yes',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ) ??
        false;
  }

  void goBackToMap() {
    Get.back();
  }
}
