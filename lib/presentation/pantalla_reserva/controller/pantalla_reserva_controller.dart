import 'package:UnlockMe/core/storage/contracts/bike.dart';
import 'package:UnlockMe/core/storage/contracts/reserve.dart';
import 'package:UnlockMe/core/storage/database_helper.dart';
import 'package:UnlockMe/core/utils/geolocation_utils.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import '../../../core/app_export.dart';
import '../models/pantalla_reserva_model.dart';
import 'package:hive/hive.dart';
import 'dart:async';

/// A controller class for the PantallaReservaScreen.
///
/// This class manages the state of the PantallaReservaScreen, including the
/// current pantallaReservaModelObj
class PantallaReservaController extends GetxController {
  //late defines a variable that is not initialized when it is declared
  late Rx<PantallaReservaModel> pantallaReservaModelObj;
  Timer? _timer;
  Rx<String> address = 'Address Unknown'.obs;
  RxInt testVar = 0.obs;
  var remainingTime = 0.obs;
  final dbHelper = DatabaseHelper();

  @override
  void onInit() async {
    super.onInit();
    final args = Get.arguments;
    Bike bike = args['bike'] as Bike;

    Logger.logDebug('BikeStatus: ${bike.status}');

    // Initialize the model with the bike's status
    pantallaReservaModelObj = PantallaReservaModel(
      bike: bike,
      isReserved: bike.status == BikeStatus.reserved,
    ).obs;

    var reserveBox = await Hive.openBox('reserveBox');
    final reserveId = reserveBox.get('reserveId');
    //debug purpose
    final reserveEndsAt = reserveBox.get('reserveEndsAt');
    print('Reserve Ends At: ${reserveEndsAt}');
    print('ReserveId: ${reserveId}');
    print('IsReserved:${pantallaReservaModelObj.value.isReserved}');
    ////

    if (pantallaReservaModelObj.value.isReserved) {
      // Load the reservation details and set the timer

      if (reserveId != null) {
        //final reserve = await dbHelper.getReserve(reserveId);
        pantallaReservaModelObj.update((model) {
          model?.endsAt = DateTime.parse(reserveEndsAt);
        });
        startTimer();
      }
    }

    try {
      var retrievedAddress =
          await getAddressFromCoordinates(bike.latitude, bike.longitude);
      //address = retrievedAddress?.obs ?? 'Unknown'.obs;
      address.value = retrievedAddress ?? ' Address Unknown';

      //testVar.value = 23;
      Logger.logDebug('Address: $address');
    } catch (e) {
      Logger.logError('Error: $e');
    }
  }

  Future<void> createReservation() async {
    // Read user ID from Hive
    var userBox = await Hive.openBox('userBox');
    final int userId = userBox.get('userId') ?? 1;
    final int userHotelId = userBox.get('userHotelId') ?? 0;
    Logger.logDebug('User=$userId:$userHotelId');

    // Save reservation to SQLite
    final dbHelper = DatabaseHelper();
    final reserveAt = DateTime.now();
    final reserveId = await dbHelper.insertReserve(Reserve(
        userId: userId,
        bikeId: pantallaReservaModelObj.value.bike.id!,
        createdAt: reserveAt.toIso8601String(),
        endsAt: reserveAt.add(Duration(seconds: 30)).toIso8601String(),
        status: ReserveStatus.active));

    Logger.logDebug('reserveId created:$reserveId');
    var reserveBox = await Hive.openBox('reserveBox');
    reserveBox.put('reserveId', reserveId);
    reserveBox.put('reserveEndsAt',
        reserveAt.add(Duration(seconds: 30)).toIso8601String());

    //debug purpose
    // final rId = reserveBox.get('reserveId');
    final reserveEndsAt = reserveBox.get('reserveEndsAt');
    print('Reserve Ends At: ${reserveEndsAt}');
    // print(rId);
    //debug

    pantallaReservaModelObj.update((model) {
      model?.isReserved = true;
      model?.endsAt = DateTime.now().add(Duration(seconds: 30));
    });

    startTimer();
    await updateBikeStatus();
    // Provide feedback to the user
    Get.snackbar('Reservation', 'Bike reserved successfully!');
  }

  void startTimer() {
    if (pantallaReservaModelObj.value.endsAt == null) return;
    final endTime = pantallaReservaModelObj.value.endsAt!;
    remainingTime.value = endTime.difference(DateTime.now()).inSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.isAfter(endTime)) {
        onReserveExpiration();
      } else {
        remainingTime.value = endTime.difference(now).inSeconds;
      }
    });
  }

  void onReserveExpiration() {
    _cancelReservation();
    Get.snackbar('Reservation', 'Reservation expired!');
  }

  void onTapCancelReservation() async {
    final isConfirmed = await _showConfirmationDialog();
    if (isConfirmed) {
      _cancelReservation();
      // Provide feedback to the user
      Get.snackbar('Reservation', 'Reservation cancelled successfully!');
    }
  }

  void _cancelReservation() async {
    _timer?.cancel();
    remainingTime.value = 0;

    var reserveBox = await Hive.openBox('reserveBox');
    final reserveId = reserveBox.get('reserveId');
    Logger.logDebug('ReserveId on cancelReservation: $reserveId');
    // Update reservation to SQLite
    //TODO: Fix issue when the timer ends in map screen
    await dbHelper.updateReserve(reserveId, {
      'status': ReserveStatus.cancelled,
    });

    reserveBox.delete('reserveId');
    reserveBox.delete('reserveEndsAt');
    pantallaReservaModelObj.update((model) {
      model?.isReserved = false;
      model?.endsAt = null;
    });
    remainingTime.value = 0;

    await updateBikeStatus();

    // Update the shared state to notify other screens
    //Get.find<MapaController>().updateBikeStatus(pantallaReservaModelObj.value.bike.id!, ReserveStatus.cancelled);
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
                onPressed: () =>
                    Get.back(result: false), // Close dialog and return false
                child: Text(
                  'No',
                  style: TextStyle(color: Colors.red),
                ),
              ),
              TextButton(
                onPressed: () =>
                    Get.back(result: true), // Close dialog and return true
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
