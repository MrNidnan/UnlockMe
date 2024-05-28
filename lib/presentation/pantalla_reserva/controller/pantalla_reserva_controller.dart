import 'package:UnlockMe/core/app_export.dart';
import 'package:UnlockMe/core/app_storage.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
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
  late Box _userBox;
  late Box _reserveBox;

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

    await _initializeReserve(bike);
    await _retrieveAddress(bike);

    _timerService.onExpire = onExpireReserve;
    _timerService.onCancel = _cancelReservation;
  }

  Future<void> _initializeReserve(Bike bike) async {
    Logger.logDebug('Reserve Screen BikeStatus: ${bike.status}');

    _reserveBox = await Hive.openBox('reserveBox');
    _userBox = await Hive.openBox('userBox');
    final reserveId = _reserveBox.get('reserveId');
    final reserveEndsAt = _reserveBox.get('reserveEndsAt');

    //(In case screen was not updated properly, we must check the source of truth in the database)
    //That is if:
    //  bike status is reserved, but the reserveId is null
    //  or bike status is available, but the reserveId is not null
    if ((pantallaReservaModelObj.value.isReserved && reserveId == null) ||
        (!pantallaReservaModelObj.value.isReserved && reserveId != null)) {
      await dbHelper.getBikeById(bike.id!).then((bike) {
        Logger.logDebug(' retrieved BikeStatus: ${bike.status}');
        pantallaReservaModelObj.update((model) {
          model?.isReserved = bike.status == BikeStatus.reserved;
        });
      });
    }

    Logger.logDebug('Reserve Ends At: $reserveEndsAt');
    Logger.logDebug('ReserveId: $reserveId');
    Logger.logDebug('IsReserved: ${pantallaReservaModelObj.value.isReserved}');

    //If the bike is already reserved by the user
    // Load the reservation details and start the timer
    if (pantallaReservaModelObj.value.isReserved) {
      if (reserveId != null) {
        pantallaReservaModelObj.update((model) {
          model?.endsAt = DateTime.parse(reserveEndsAt);
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
    if (_reserveBox.get('reserveId') != null) {
      Get.snackbar('Reservation', 'You already have a reservation!',
          backgroundColor: Colors.red);
      return;
    }
    final int userId = _userBox.get('userId') ?? 1;
    final int userHotelId = _userBox.get('userHotelId') ?? 0;
    Logger.logDebug('User=$userId:$userHotelId');

    final reserveAt = DateTime.now();
    final reserveId = await dbHelper.insertReserve(Reserve(
        userId: userId,
        bikeId: pantallaReservaModelObj.value.bike.id!,
        createdAt: reserveAt.toIso8601String(),
        endsAt: reserveAt.add(Duration(seconds: 30)).toIso8601String(),
        status: ReserveStatus.active));

    Logger.logDebug('reserveId created: $reserveId');
    var reserveBox = await Hive.openBox('reserveBox');
    reserveBox.put('reserveId', reserveId);
    reserveBox.put('reserveEndsAt',
        reserveAt.add(Duration(seconds: 30)).toIso8601String());

    final reserveEndsAt = reserveBox.get('reserveEndsAt');
    Logger.logDebug('Reserve Ends At: $reserveEndsAt');

    pantallaReservaModelObj.update((model) {
      model?.isReserved = true;
      model?.endsAt = DateTime.now().add(Duration(seconds: 30));
    });

    _timerService.startTimer(pantallaReservaModelObj.value.endsAt!);
    await updateBikeStatus();
    Get.snackbar('Reservation', 'Bike reserved successfully!');
  }

  void onExpireReserve() {
    _cancelReservation();
    Get.snackbar('Reservation', 'Reservation expired!');
  }

  void onCancelReserve() async {
    final isConfirmed = await _showConfirmationDialog();
    if (isConfirmed) {
      _timerService.cancelTimer();
      Get.snackbar('Reservation', 'Reservation cancelled successfully!');
    }
  }

  void _cancelReservation() async {
    final reserveId = _reserveBox.get('reserveId');
    Logger.logDebug('ReserveId on cancelReservation: $reserveId');

    if (reserveId != null) {
      await dbHelper.updateReserve(reserveId, {
        'status': ReserveStatus.cancelled,
      });
      _reserveBox.delete('reserveId');
      _reserveBox.delete('reserveEndsAt');
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
            title: Text('Cancel Reservation'),
            content: Text('Are you sure you want to cancel the reservation?'),
            actions: [
              TextButton(
                onPressed: () => Get.back(result: false),
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () => Get.back(result: true),
                child: Text(
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
