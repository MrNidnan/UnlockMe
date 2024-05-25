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
  String? address;
  var remainingTime = 0.obs;

  @override
  void onInit() async {
    super.onInit();
    final args = Get.arguments;
    pantallaReservaModelObj = PantallaReservaModel(
      bike: args['bike'] as Bike,
    ).obs;
    try {
      address = await getAddressFromCoordinates(
          pantallaReservaModelObj.value.bike.latitude,
          pantallaReservaModelObj.value.bike.longitude);
      print('Address: $address');
    } catch (e) {
      Logger.log('Error: $e');
    }
  }

  Future<void> createReservation() async {
    // Read user ID from Hive
    var userBox = await Hive.openBox('userBox');
    final int userId = userBox.get('userId') ?? 1;
    final int userHotelId = userBox.get('userHotelId') ?? 0;
    print('User=$userId:$userHotelId');

    // Save reservation to SQLite
    final dbHelper = DatabaseHelper();
    final reserveId = await dbHelper.insertReserve(Reserve(
        userId: userId,
        bikeId: pantallaReservaModelObj.value.bike.id!,
        createdAt: DateTime.now().toIso8601String(),
        endsAt: DateTime.now().add(Duration(seconds: 30)).toIso8601String(),
        status: ReserveStatus.active.toString()));

    var reserveBox = await Hive.openBox('reserveBox');
    reserveBox.put('reserveId', reserveId);

    pantallaReservaModelObj.update((model) {
      model?.isReserved = true;
      model?.endsAt = DateTime.now().add(Duration(seconds: 30));
    });

    startTimer();

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
    cancelReservation();
    Get.snackbar('Reservation', 'Reservation expired!');
  }

  void onTapCancelReservation() async {
    final isConfirmed = await _showConfirmationDialog();
    if (isConfirmed) {
      cancelReservation();
      // Provide feedback to the user
      Get.snackbar('Reservation', 'Reservation cancelled successfully!');
    }
  }

  void cancelReservation() async {
    _timer?.cancel();
    remainingTime.value = 0;

    var reserveBox = await Hive.openBox('reserveBox');
    final reserveId = reserveBox.get('reserveId');

    // Update reservation to SQLite
    final dbHelper = DatabaseHelper();
    await dbHelper.updateReserve(reserveId, {
      'status': ReserveStatus.cancelled.toString(),
    });

    reserveBox.delete('reserveId');
    pantallaReservaModelObj.update((model) {
      model?.isReserved = false;
      model?.endsAt = null;
    });
    remainingTime.value = 0;
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
}
