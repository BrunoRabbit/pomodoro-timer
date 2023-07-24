import 'package:flutter/foundation.dart';
import 'package:pomodoro_timer/core/debug/controllers/statistics_view_model_debug.dart';
import 'package:pomodoro_timer/core/utils/extensions/hour_helper.dart';
import 'package:pomodoro_timer/core/utils/keys/shared_preferences_keys.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/features/language_feature/providers/observer.dart';
import 'package:pomodoro_timer/features/statistics_feature/model/statistics_model.dart';
import 'package:pomodoro_timer/features/statistics_feature/view_model/date_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class StatisticsViewModel extends DateViewModel
    with ChangeNotifier, DiagnosticableTreeMixin
    implements Observer {
  final PomodoroViewModel viewModel;

  StatisticsViewModel(this.viewModel) {
    observable = Observable();
    observable.addObserver(this);
  }

  late Observable observable;

  int pomodoro = 0;
  int userSection = 0;
  String totalMinutes = "";

  List<String> finishedSection = [];

  String _getData = "";

  late List<Map<String, dynamic>> _sections;

  List<StatisticsModel> get statisticsModel => _sections
      .map((map) => StatisticsModel(value: map["value"]))
      .toList(growable: false);

  static const String sectionKey = SharedPreferencesKeys.sectionKey;
  static const String userSectionKey = SharedPreferencesKeys.userSectionKey;
  static const String remainingTimeKey = SharedPreferencesKeys.remainingTimeKey;

  String get _substringDataNow =>
      DateTime.now().toIso8601String().substring(0, _getData.length);

  String get _substringLastSectionDate =>
      DateTime.parse(_getData).toIso8601String().substring(0, _getData.length);

  Future<void> getPomodoroTimer() async {
    final prefs = await SharedPreferences.getInstance();
    finishedSection = prefs.getStringList(sectionKey) ?? [];
    final storeRemainingTime = prefs.getStringList(remainingTimeKey) ?? [];

    userSection = prefs.getInt(userSectionKey) ?? 0;

    if (finishedSection.isNotEmpty) {
      await _verifySameSection(storeRemainingTime);
      _calculateTotalMinutes(storeRemainingTime);
    } else {
      _resetValues(storeRemainingTime, prefs);
    }

    await prefs.setStringList(sectionKey, finishedSection);
    observable.notifyObservers();
  }

  String plural(int count, LanguageModel model) {
    String cycle = model.cycles.last.toLowerCase();
    String cycles = model.cycles.first.toLowerCase();

    return count == 0 ? cycle : cycles;
  }

  void initSections() {
    _sections = [
      {
        "value": _parseMin(viewModel.remainingTime),
      },
      {
        "value": _parseMin(viewModel.durationRest),
      },
      {
        "value": viewModel.userCycleLimit,
      }
    ];
  }

  double getBarHeight(int i, double maxBar, bool isWeek) {
    int userSection = isWeek
        ? retrieveUserSection(i, finishedSection)
        : retrieveMonthsSection(i, finishedSection);

    if (userSection <= maxBar) {
      double barHeight = isWeek ? (maxBar * 52 - 5) / 6.22 : (50 / 6.22);

      double isSectionMax =
          userSection >= maxBar ? maxBar : userSection * barHeight / 10;
      return isSectionMax;
    }
    return maxBar;
  }

  // ? Help methods
  int _parseMin(double min) {
    if (min < 10) {
      return (min ~/ 10);
    }
    return (min ~/ 60);
  }

  String _getDateTime() {
    final now = DateTime.now();
    final day = now.day < 10 ? '0${now.day}' : '${now.day}';
    final month = now.month < 10 ? '0${now.month}' : '${now.month}';
    return '${now.year}-$month-$day';
  }

  void _calculateTotalMinutes(List<String> storeRemainingTime) {
    double seconds = storeRemainingTime.fold<double>(
      0,
      (p, r) => double.parse(r) + p,
    );

    totalMinutes = seconds.secToHourMin();
  }

  _verifySameSection(List<String> storeRemainingTime) async {
    final prefs = await SharedPreferences.getInstance();
    _getData = finishedSection.last.substring(
      userSection < 11 ? 2 : 3,
      finishedSection.last.length,
    );

    String now = _substringDataNow;
    String lastSectionDate = _substringLastSectionDate;

    if (lastSectionDate != now) {
      _resetValues(storeRemainingTime, prefs);
      return;
    }
  }

  void _resetValues(
    List<String> storeRemainingTime,
    SharedPreferences prefs,
  ) {
    pomodoro = 0;
    totalMinutes = "";
    userSection = 0;
    storeRemainingTime.clear();
    prefs.remove(userSectionKey);
    prefs.remove(remainingTimeKey);
    finishedSection.add('$userSection ${_getDateTime()}');
  }

  @override
  void update() {
    notifyListeners();
  }

  // ! dev tools
  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);

    StatisticsViewModelDebug(viewModel).debug(properties);
  }
}
