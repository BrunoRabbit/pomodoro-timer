import 'dart:async';

import 'package:flutter/material.dart';

class GlobalController extends ChangeNotifier {
  // ? Settings
  int cycles = 1;
  int durationRest = 5;
  int durationWork = 10;

  // ? Timer
  int remainingTime = 10;
  bool isTimerActive = false;
  Timer? timer;
  bool isWorking = false;

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime--;
      isTimerActive = true;

      if (remainingTime < 0) {
        isWorking = !isWorking;
        if (isWorking) {
          remainingTime = durationWork;
          durationWork = remainingTime;
          // remainingTime = workTime * 60;
        } else {
          remainingTime = durationRest;
          durationRest = remainingTime;
          // remainingTime = breakTime * 60;
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
    timer!.cancel();
    isWorking = true;
    // remainingTime = workTime * 60;
    remainingTime = 10;
    isTimerActive = false;
    notifyListeners();
  }

  void changeWorkMinutes(String text){
    resetTimer();
    remainingTime = int.parse(text);
    durationWork = remainingTime;
    notifyListeners();
  }

  void changeRestMinutes(String text){
    resetTimer();
    remainingTime = int.parse(text);
    durationRest = remainingTime;
    notifyListeners();
  }
}
