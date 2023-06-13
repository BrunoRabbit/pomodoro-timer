import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/models/settings_item_model.dart';

class GlobalController extends ChangeNotifier {
  // ? Settings
  int timerCycle = 0;
  int userCycleLimit = 0;
  double durationRest = 0.1 * 60; // 5
  double durationWork = 0.1 * 60; // 25

  // ? Timer
  double remainingTime = 0.1 * 60; // 25
  bool isTimerActive = false;
  Timer? timer;
  bool isWorking = true;

  double switchWorkRestTiming() {
    if (isWorking) {
      timerCycle++;
      return durationWork;
    }

    return durationRest;
  }

  void startTimer(BuildContext context) {
    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime--;
      isTimerActive = true;

      if (remainingTime < 0) {
        isWorking = !isWorking;
        remainingTime = switchWorkRestTiming();
      }

      finishPomodoroUsingCycle(timer, context);

      notifyListeners();
    });
  }

  void finishPomodoroUsingCycle(Timer timer, BuildContext context) {
    if (userCycleLimit > 0 && timerCycle >= userCycleLimit) {
      timer.cancel();
      isTimerActive = false;

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text(
            'Reinicie ou aumente o tamanho de ciclos!',
            style: TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
      );
    }
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
    timerCycle = 0;
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
        subTitle: '$userCycleLimit ${plural(userCycleLimit)}',
        onPress: (text) => changePomodoroCycle(text.text),
      ),
    ];
  }

  void changePomodoroCycle(String text) {
    if (timer != null) {
      timer!.cancel();
      isTimerActive = false;
    }

    int cycle = int.parse(text);

    userCycleLimit = cycle;
    notifyListeners();
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
