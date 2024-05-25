import 'package:UnlockMe/core/storage/contracts/bike.dart';
import 'package:UnlockMe/core/storage/contracts/reserve.dart';
import 'package:UnlockMe/core/storage/database_helper.dart';
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
  late PantallaReservaModel pantallaReservaModelObj;
  Timer? _timer;
  var remainingTime = 0.obs;

  @override
  void onInit() {
    super.onInit();
    final args = Get.arguments;
    pantallaReservaModelObj = PantallaReservaModel(
      bike: args['bike'] as Bike,
    );
  }

  Future<void> createReservation() async {
    // Read user ID from Hive
    var userBox = await Hive.openBox('userBox');
    int userId = userBox.get('user').userId;
    var reserveBox = await Hive.openBox('reserveBox');

    // Save reservation to SQLite
    final dbHelper = DatabaseHelper();
    final reserveId = await dbHelper.insertReserve(Reserve(
        userId: userId,
        bikeId: pantallaReservaModelObj.bike.id!,
        createdAt: DateTime.now().toIso8601String(),
        endsAt: DateTime.now().add(Duration(minutes: 15)).toIso8601String(),
        status: ReserveStatus.active.toString()));

    reserveBox.put('reserveId', reserveId);
    pantallaReservaModelObj.isReserved = true;
    pantallaReservaModelObj.endsAt = DateTime.now().add(Duration(minutes: 15));
    startTimer();

    // Provide feedback to the user
    Get.snackbar('Reservation', 'Bike reserved successfully!');
  }

  void startTimer() {
    if (pantallaReservaModelObj.endsAt == null) return;
    final endTime = pantallaReservaModelObj.endsAt!;
    remainingTime.value = endTime.difference(DateTime.now()).inSeconds;
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.isAfter(endTime)) {
        timer.cancel();
        remainingTime.value = 0;
      } else {
        remainingTime.value = endTime.difference(now).inSeconds;
      }
    });
  }

  void cancelReservation() async {
    _timer?.cancel();
    var reserveBox = await Hive.openBox('reserveBox');
    final reserveId = reserveBox.get('reserveId');

    // Update reservation to SQLite
    final dbHelper = DatabaseHelper();
    await dbHelper.updateReserve(reserveId, {
      'status': ReserveStatus.cancelled,
    });

    reserveBox.delete('reserveId');
    pantallaReservaModelObj.isReserved = false;
    pantallaReservaModelObj.endsAt = null;
    remainingTime.value = 0;

    // Provide feedback to the user
    Get.snackbar('Reservation', 'Reservation cancelled successfully!');
  }
}
