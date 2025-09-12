import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

class DebugController extends GetxController {
  FlutterErrorDetails? errorDetails;
  int count = 0;
  Timer? timer;

  void putError(FlutterErrorDetails errorDetails) {
    this.errorDetails = errorDetails;

    showErrorColor();
  }

  void showErrorColor() {
    if (count > 0) {
      return;
    }

    count = 5;
    startTimer();
  }

  void startTimer() {
    timer?.cancel();
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (count > 0) {
        count--;
      } else {
        timer.cancel();
      }
      update();
    });
  }

  @override
  void onClose() {
    timer?.cancel();
    super.onClose();
  }
}
