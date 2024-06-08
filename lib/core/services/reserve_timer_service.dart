import 'package:unlockme/core/utils/logger.dart';
import 'package:get/get.dart';
import 'dart:async';

class ReserveTimerService extends GetxService {
  Timer? _timer;
  var remainingTime = 0.obs;
  Function()? onExpire;
  Function()? onCancel;
  var isRunning = false.obs; // Make isRunning reactive

  void startTimer(DateTime endTime) {
    _timer?.cancel(); // Cancel any existing timer
    remainingTime.value = endTime.difference(DateTime.now()).inSeconds;
    isRunning.value = true; // Set isRunning to true

    Logger.logDebug('Start Timer with remainingTime ${remainingTime.value}');

    _timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      final now = DateTime.now();
      if (now.isAfter(endTime)) {
        expireTimer();
      } else {
        remainingTime.value = endTime.difference(now).inSeconds;
      }
    });
  }

  void expireTimer() {
    _timer?.cancel();
    remainingTime.value = 0;
    isRunning.value = false; // Set isRunning to false

    onExpire?.call(); // Call the expiration callback
  }

  void cancelTimer() {
    _timer?.cancel();
    remainingTime.value = 0;
    isRunning.value = false; // Set isRunning to false

    onCancel?.call(); // Call the cancellation callback
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
