import 'dart:async';

import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/controllers/global_controller.dart';
import 'package:pomodoro_timer/features/models/settings_item_model.dart';
import 'package:pomodoro_timer/features/providers/observer.dart';

class SettingsController extends ChangeNotifier implements Observer {
  final GlobalController _controller;

  SettingsController(this._controller) {
    _controller.observable.addObserver(this);
  }

  final bool _isUserWorking = true;

  double get durationWork => _controller.durationWork;
  double get durationRest => _controller.durationRest;

  int get userCycleLimit => _controller.userCycleLimit;
  bool get isWorking => _controller.isWorking;
  Timer? get timer => _controller.timer;
  Observable get observable => _controller.observable;

  set isTimerActive(bool boolean) => _controller.isTimerActive = boolean;
  set setUserCycleLimit(int cycle) => _controller.userCycleLimit = cycle;
  set setDurationWork(double min) => _controller.durationWork = min;
  set setDurationRest(double min) => _controller.durationRest = min;
  set remainingTime(double time) => _controller.remainingTime = time;

  // ? Settings
  List<SettingsItemModel> populateItemModel() {
    return [
      SettingsItemModel(
        title: 'Pomodoro',
        subTitle: _parseMin(durationWork),
        onPress: (text) => _changeSettsMinutes(text.text, _isUserWorking),
      ),
      SettingsItemModel(
        title: 'Descanso',
        subTitle: _parseMin(durationRest),
        onPress: (text) => _changeSettsMinutes(text.text, !_isUserWorking),
      ),
      SettingsItemModel(
        title: 'Ciclos trabalho/descanso',
        subTitle: '$userCycleLimit ${_plural(userCycleLimit)}',
        onPress: (text) => _changePomodoroCycle(text.text),
      ),
    ];
  }

  void _changePomodoroCycle(String text) {
    if (timer != null) {
      timer!.cancel();
      isTimerActive = false;
    }

    int cycle = int.parse(text);

    setUserCycleLimit = cycle;
    observable.notifyObservers();
  }

  void _changeSettsMinutes(String text, bool isUserWorking) {
    if (timer != null) {
      timer!.cancel();
      isTimerActive = false;
    }

    double duration = double.parse(text);
    duration *= 60;

    if (isUserWorking) {
      setDurationWork = duration;
      remainingTime = _userDuration();
    } else {
      setDurationRest = duration;
      remainingTime = _userDuration();
    }

    observable.notifyObservers();
  }

  double _userDuration() {
    if (!isWorking) {
      return remainingTime = durationRest;
    }

    return remainingTime = durationWork;
  }

  // ? helpers
  String _plural(int count) {
    return count == 1 ? "ciclo" : "ciclos";
  }

  String _parseMin(double min) {
    if (min < 10) {
      return (min / 10).toString();
    }
    return (min / 60).toString();
  }

  @override
  void update() {
    notifyListeners();
  }
}
