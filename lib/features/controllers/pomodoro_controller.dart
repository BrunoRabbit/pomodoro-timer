import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/debug/controllers/pomodoro_controller_debug.dart';
import 'package:pomodoro_timer/features/controllers/notifications_controller.dart';
import 'package:pomodoro_timer/features/providers/observer.dart';
import 'package:provider/provider.dart';

class PomodoroController extends ChangeNotifier
    with DiagnosticableTreeMixin
    implements Observer {
  final Observable observable = Observable();

  PomodoroController() {
    observable.addObserver(this);
  }

  PomodoroController.removeObserver() {
    observable.removeObserver(this);
  }

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

  double _switchWorkRestTiming() {
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
        remainingTime = _switchWorkRestTiming();
      }

      _finishPomodoroUsingCycle(timer, context);

      observable.notifyObservers();
    });
  }

  void _finishPomodoroUsingCycle(Timer timer, BuildContext context) {
    if (userCycleLimit > 0 && timerCycle >= userCycleLimit) {
      timer.cancel();
      isTimerActive = false;

      _isNotificationAvailable(context);
    }
  }

  void _isNotificationAvailable(BuildContext context) {
    final controller = context.read<NotificationsController>();

    if (controller.isNotificationAllowed) {
      controller.showNotification(context);
    }
  }

  void pauseTimer() {
    isTimerActive = false;
    timer!.cancel();
    observable.notifyObservers();
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
    observable.notifyObservers();
  }

  @override
  void update() {
    notifyListeners();
  }

  // ! dev tools
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    PomodoroControllerDebug().debug(properties);
  }
}
