import 'dart:async';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/features/language_feature/providers/observer.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/settings_feature/model/section_list_model.dart';
import 'package:pomodoro_timer/features/settings_feature/model/settings_item_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsViewModel extends ChangeNotifier implements Observer {
  final PomodoroViewModel _viewModel;

  SettingsViewModel(this._viewModel) {
    _viewModel.observable.addObserver(this);
  }

  final bool _isUserWorking = true;
  int toggleValue = 0;

  double get durationWork => _viewModel.durationWork;
  double get durationRest => _viewModel.durationRest;

  int get userCycleLimit => _viewModel.userCycleLimit;
  bool get isWorking => _viewModel.isWorking;
  Timer? get timer => _viewModel.timer;
  Observable get observable => _viewModel.observable;

  set isTimerActive(bool boolean) => _viewModel.isTimerActive = boolean;
  set setUserCycleLimit(int cycle) => _viewModel.userCycleLimit = cycle;
  set setDurationWork(double min) => _viewModel.durationWork = min;
  set setDurationRest(double min) => _viewModel.durationRest = min;
  set remainingTime(double time) => _viewModel.remainingTime = time;

  // ? Settings
  int itemSelected = 0;

  void updateItemSelected(int i) {
    itemSelected = (i + 1) * 5;
    observable.notifyObservers();
  }

  void updateCycle(int i) {
    itemSelected = i;
    observable.notifyObservers();
  }

  Future<void> changeLocale(BuildContext context, bool mounted) async {
    final multiLang = MultiLanguagesImpl();

    final currentLocale = await multiLang.readLocalePrefs();
    Locale newLocale = const Locale.fromSubtags(languageCode: 'pt');

    if (currentLocale == "pt") {
      newLocale = const Locale("en", "EN");
    }

    if (mounted) {
      multiLang.setLocale(context, newLocale);
    }
    observable.notifyObservers();
  }

  void moveButton() async {
    final prefs = await SharedPreferences.getInstance();
    final multiLang = MultiLanguagesImpl();
    final currentLocale = await multiLang.readLocalePrefs();

    const String prefsKey = 'settingsButtonKey';

    if (currentLocale == 'en') {
      toggleValue = 0;
    } else {
      toggleValue = 1;
    }

    await prefs.setInt(prefsKey, toggleValue);
    observable.notifyObservers();
  }

  void loadToggleValue() async {
    final prefs = await SharedPreferences.getInstance();
    const String prefsKey = 'settingsButtonKey';

    toggleValue = prefs.getInt(prefsKey) ?? 0;

    await prefs.setInt(prefsKey, toggleValue);
    observable.notifyObservers();
  }

  void _changePomodoroCycle(int index) {
    if (timer != null) {
      timer!.cancel();
      isTimerActive = false;
    }

    int cycle = index;

    setUserCycleLimit = cycle;
    observable.notifyObservers();
  }

  void _changeSettsMinutes(double text, bool isUserWorking) {
    if (timer != null) {
      timer!.cancel();
      isTimerActive = false;
    }

    double duration = text;
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
      return durationRest;
    }

    return durationWork;
  }

  // ? helpers
  String _plural(int count, LanguageModel model) {
    String cycle = model.cycles.last.toLowerCase();
    String cycles = model.cycles.first.toLowerCase();

    return count == 0 ? cycle : cycles;
  }

  String _parseMin(double min) {
    if (min < 10) {
      return (min ~/ 10).toString();
    }
    return (min ~/ 60).toString();
  }

  // ? Settings Sections
  List<SectionListModel> settingsSections(LanguageModel model) {
    return [
      SectionListModel(
        items: [
          SettingsItemModel(
            subTitle: _parseMin(durationWork),
            openModalBottomSheet: (text) => _changeSettsMinutes(
              text,
              _isUserWorking,
            ),
          ),
          SettingsItemModel(
            subTitle: _parseMin(durationRest),
            openModalBottomSheet: (text) => _changeSettsMinutes(
              text,
              !_isUserWorking,
            ),
          ),
          SettingsItemModel(
            subTitle: '$userCycleLimit ${_plural(userCycleLimit, model)}',
            openModalBottomSheet: (text) => _changePomodoroCycle(text.toInt()),
          ),
        ],
      ),
      SectionListModel(
        items: [
          SettingsItemModel(
            subTitle: null,
            openModalBottomSheet: (_) {},
          ),
          SettingsItemModel(
            subTitle: null,
            openModalBottomSheet: (_) {},
          ),
        ],
      ),
    ];
  }

  @override
  void update() {
    notifyListeners();
  }
}
