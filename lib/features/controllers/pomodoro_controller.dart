import 'dart:async';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/providers/observer.dart';

class PomodoroController extends ChangeNotifier implements Observer {
  late Observable observable;

  PomodoroController() {
    observable = Observable();
    observable.addObserver(this);
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
      // TODO - QND O CICLO ACABA E APERTA O BOTAO, O CICLO COMEÇA DE NOVO MAS ADICIONA UM VALOR SÓ

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
}
