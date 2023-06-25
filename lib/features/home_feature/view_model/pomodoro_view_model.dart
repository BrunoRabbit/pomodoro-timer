import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/debug/controllers/pomodoro_view_model_debug.dart';
import 'package:pomodoro_timer/core/utils/responsive/dimensions.dart';
import 'package:pomodoro_timer/features/notifications_feature/view_model/notifications_view_model.dart';
import 'package:pomodoro_timer/features/language_feature/providers/observer.dart';
import 'package:provider/provider.dart';

class PomodoroViewModel extends ChangeNotifier
    with DiagnosticableTreeMixin
    implements Observer {
  final Observable observable = Observable();

  PomodoroViewModel() {
    observable.addObserver(this);
  }

  PomodoroViewModel.removeObserver() {
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
    final viewModel = context.read<NotificationsViewModel>();

    if (viewModel.isNotificationAllowed) {
      viewModel.showNotification(context);
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

  // ! responsive section
  double adjustPosition(BuildContext context) {
    final size = MediaQuery.of(context).size.height / 3;
    final mediaQuery = MediaQuery.of(context);
    
    bool isTablet = mediaQuery.size.width > kTabletWidth;
    bool isPortrait = mediaQuery.orientation == Orientation.portrait;

    if (isPortrait) {
      return size;
    }
    if (isTablet) {
      return size / 0.8;
    }

    return size / 0.5;
  } // TODO - ADJUST SETTINGS SIZES

  // ! dev tools
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    PomodoroViewModelDebug().debug(properties);
  }
}
