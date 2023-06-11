import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/models/settings_item_model.dart';

class GlobalController extends ChangeNotifier {
  // ? Settings
  int cycles = 1;
  int userCycle = 2;
  double durationRest = 5 * 60;
  double durationWork = 25 * 60;

  // ? Timer
  double remainingTime = 25 * 60;
  bool isTimerActive = false;
  Timer? timer;
  bool isWorking = true;

  double timerCycle() {
    if (isWorking) {
      cycles++;
      return durationWork;
    }

    return durationRest;
  }

  void startTimer() {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime--;
      isTimerActive = true;

      if (remainingTime < 0) {
        isWorking = !isWorking;
        remainingTime = timerCycle();
      }

      if (cycles + 1 > userCycle) {
        resetTimer();
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

  // ? Settings

  List<SettingsItemModel> populateItemModel() {
    return [
      SettingsItemModel(
        title: 'Pomodoro',
        subTitle: parseMin(durationWork),
        onPress: (text) => changeWorkMinutes(text.text, isWorking),
      ),
      SettingsItemModel(
        title: 'Descanso',
        subTitle: parseMin(durationRest),
        onPress: (text) => changeWorkMinutes(text.text, !isWorking),
      ),
      SettingsItemModel(
        title: 'Ciclos trabalho/descanso',
        subTitle: '$cycles ${plural(cycles)}',
        onPress: (text) {},
        // onPress: (text) => control.changeRestMinutes(text.text),
      ),
    ];
  }

  void changeWorkMinutes(String text, bool isUserWorking) {
    if (timer != null) {
      timer!.cancel();
      isTimerActive = false;
    }

    double duration = double.parse(text);
    duration *= 60;

    if (isUserWorking) {
      durationWork = duration;
      remainingTime = userDuration();
    } else {
      durationRest = duration;
      remainingTime = userDuration();
    }

    notifyListeners();
  }

  double userDuration() {
    if (!isWorking) {
      return remainingTime = durationRest;
    }

    return remainingTime = durationWork;
  }

  // ? helpers
  String plural(int count) {
    return count == 1 ? "ciclo" : "ciclos";
  }

  String parseMin(double min) {
    if (min < 10) {
      return (min / 10).toString();
    }
    return (min / 60).toString();
  }
}
