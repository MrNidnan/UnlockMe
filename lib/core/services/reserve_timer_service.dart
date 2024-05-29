import 'package:UnlockMe/core/utils/logger.dart';
import 'package:get/get.dart';
import 'dart:async';

class ReserveTimerService extends GetxService {
  Timer? _timer;
  var remainingTime = 0.obs;
  Function()? onExpire;
  Function()? onCancel;

  bool get isRunning => _timer != null && _timer!.isActive;

  void startTimer(DateTime endTime) {
    _timer?.cancel(); // Cancel any existing timer
    remainingTime.value = endTime.difference(DateTime.now()).inSeconds;

    Logger.logDebug('Start Timer with remainingTime ${remainingTime.value}');

    _timer = Timer.periodic(Duration(seconds: 1), (timer) {
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
    onExpire?.call(); // Call the expiration callback
  }

  void cancelTimer() {
    _timer?.cancel();
    remainingTime.value = 0;
    onCancel?.call(); // Call the cancellation callback
  }

  @override
  void onClose() {
    _timer?.cancel();
    super.onClose();
  }
}
