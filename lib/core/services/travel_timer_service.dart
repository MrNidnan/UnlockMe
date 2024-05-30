import 'package:UnlockMe/core/utils/logger.dart';
import 'package:get/get.dart';
import 'dart:async';

class TravelTimerService extends GetxService {
  Timer? _timer;
  var accumulatedTime = 0.obs;
  Function()? onCancel;
  var isRunning = false.obs; // Make isRunning reactive

  // Starts the timer with a given start time
  void startTimer(DateTime startTime) {
    _timer?.cancel(); // Cancel any existing timer

    // Calculate the initial accumulated time based on the start time
    var now = DateTime.now();
    accumulatedTime.value = now.difference(startTime).inSeconds;
    isRunning.value = true;

    Logger.logDebug(
        'Start Timer with accumulatedTime ${accumulatedTime.value}');

    // Start the timer and update the accumulated time every second
    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
      accumulatedTime.value += 1;
    });
  }

  // Cancels the timer and resets the accumulated time
  void cancelTimer() {
    _timer?.cancel();
    accumulatedTime.value = 0;
    isRunning.value = false;
    onCancel?.call(); // Call the cancellation callback
  }

  // Disposes the timer when the service is closed
  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
