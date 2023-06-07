import 'dart:async';

import 'package:flutter/material.dart';

class GlobalController extends ChangeNotifier {
  // ? Settings
  int cycles = 1;
  int durationRest = 5 * 60;
  int durationWork = 25 * 60;

  // ? Timer
  int remainingTime = 25 * 60;
  bool isTimerActive = false;
  Timer? timer;
  bool isWorking = true;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime--;
      isTimerActive = true;

      if (remainingTime < 0) {
        isWorking = !isWorking;
        if (isWorking) {
          remainingTime = durationWork;
          // remainingTime = durationWork * 60;
          // durationWork = remainingTime;
        } else {
          remainingTime = durationRest;
          // remainingTime = durationRest * 60;
          // remainingTime = durationRest;
          // durationRest = remainingTime;
        }
      }
      notifyListeners();
    });
  }

  void pauseTimer() {
    isTimerActive = false;
    timer!.cancel();
    notifyListeners();
  }

  void resetTimer() {
    if (timer != null) {
      timer!.cancel();
    }
    durationWork = 25 * 60;
    remainingTime = 25 * 60;
    durationRest = 5 * 60;
    isWorking = true;
    // remainingTime = workTime * 60;
    // remainingTime = durationWork ~/ 10;
    // durationWork = remainingTime;
    isTimerActive = false;
    notifyListeners();
  }

  void changeWorkMinutes(String text) {
    resetTimer();
    remainingTime = int.parse(text);
    durationWork = remainingTime * 60;
    notifyListeners();
  }

  void changeRestMinutes(String text) {
    resetTimer();
    remainingTime = int.parse(text);
    durationRest = remainingTime * 60;
    notifyListeners();
  }
}
