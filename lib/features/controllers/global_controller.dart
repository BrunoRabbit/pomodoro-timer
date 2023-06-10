import 'dart:async';

import 'package:flutter/material.dart';

class GlobalController extends ChangeNotifier {
  // ? Settings
  int cycles = 1;
  double durationRest = 5 * 60;
  double durationWork = 25 * 60;

  // ? Timer
  double remainingTime = 25 * 60;
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
        } else {
          remainingTime = durationRest;
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
    isTimerActive = false;
    notifyListeners();
  }

  void changeWorkMinutes(String text) {
    if (timer != null) {
      timer!.cancel();
      isTimerActive = false;
    }

    durationWork = double.parse(text);
    durationWork  = durationWork * 60;

    if(isWorking){
      remainingTime = durationWork;
    }
    
    notifyListeners();
  }

  void changeRestMinutes(String text) {
    if (timer != null) {
      timer!.cancel();
      isTimerActive = false;
    }
    
    durationRest = double.parse(text);
    durationRest = durationRest * 60;

    if (!isWorking) {
      remainingTime = durationRest;
    }

    notifyListeners();
  }
}
