import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/debug/controllers/pomodoro_view_model_debug.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/core/utils/keys/shared_preferences_keys.dart';
import 'package:pomodoro_timer/core/utils/responsive/dimensions.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/features/notifications_feature/view_model/notifications_view_model.dart';
import 'package:pomodoro_timer/features/language_feature/providers/observer.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

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

  // ? Settings variables
  int timerCycle = 0;
  int userCycleLimit = 0;
  double durationRest = 0.1 * 60; // 5
  double durationWork = 0.1 * 60; // 25

  // ? Pomodoro variables
  double remainingTime = 0.1 * 60; // 25
  bool isTimerActive = false;
  Timer? timer;
  bool isWorking = true;

  // ? Pomodoro variables
  int userSection = 0;
  String _getData = "";

  // ! SharedPreferencesKeys
  static const String sectionKey = SharedPreferencesKeys.sectionKey;
  static const String userSectionKey = SharedPreferencesKeys.userSectionKey;
  static const String remainingTimeKey = SharedPreferencesKeys.remainingTimeKey;

  String get _substringDataNow =>
      DateTime.now().toIso8601String().substring(0, _getData.length);

  String get _substringLastSectionDate =>
      DateTime.parse(_getData).toIso8601String().substring(0, _getData.length);

  Future<int> initializeUserSection() async {
    final prefs = await SharedPreferences.getInstance();
    userSection = prefs.getInt(userSectionKey) ?? 0;

    return userSection;
  }

  void startTimer(BuildContext context) async {
    final prefs = await SharedPreferences.getInstance();
    final storeRemainingTime = prefs.getStringList(remainingTimeKey) ?? [];

    timer = Timer.periodic(const Duration(seconds: 1), (timer) {
      remainingTime--;
      isTimerActive = true;

      if (remainingTime < 0) {
        isWorking = !isWorking;
        remainingTime = _switchWorkRestTiming();
        storeRemainingTime.add(remainingTime.toString());

        prefs.setStringList(remainingTimeKey, storeRemainingTime);
      }

      _finishPomodoroUsingCycle(timer, context);

      observable.notifyObservers();
    });
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

  // ? statistics
  void _saveUserSection() async {
    final prefs = await SharedPreferences.getInstance();
    final finishedSection = prefs.getStringList(sectionKey) ?? [];
    userSection = prefs.getInt(userSectionKey) ?? 0;

    userSection++;

    if (finishedSection.isNotEmpty) {
      _verifySameSection(finishedSection);
    } else {
      finishedSection.add('$userSection ${_getDateTime()}');
    }

    await prefs.setStringList(sectionKey, finishedSection);
    await prefs.setInt(userSectionKey, userSection);
  }

  void _verifySameSection(List<String> finishedSection) {
    _getData = finishedSection.last.substring(
      userSection < 11 ? 2 : 3,
      finishedSection.last.length,
    );

    String now = _substringDataNow;
    String lastSectionDate = _substringLastSectionDate;

    if (lastSectionDate == now) {
      finishedSection.last = '$userSection ${_getDateTime()}';
      return;
    }

    userSection = 0;
    finishedSection.add('$userSection ${_getDateTime()}');
  }

  String _getDateTime() {
    final now = DateTime.now();
    final day = now.day < 10 ? '0${now.day}' : '${now.day}';
    final month = now.month < 10 ? '0${now.month}' : '${now.month}';
    return '${now.year}-$month-$day';
  }

  // ! helper methods
  double _switchWorkRestTiming() {
    if (isWorking) {
      timerCycle++;
      return durationWork;
    }
    _saveUserSection();
    return durationRest;
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
    LanguageModel model = MultiLanguagesImpl.of(context)!.instance();

    if (viewModel.isNotificationAllowed) {
      viewModel.showNotification(context, model);
    }
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
  }

  // ! dev tools
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    PomodoroViewModelDebug().debug(properties);
  }
}
