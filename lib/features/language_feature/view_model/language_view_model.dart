import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/features/language_feature/providers/observer.dart';

class LanguageViewModel extends ChangeNotifier implements Observer {
  LanguageViewModel() {
    observable = Observable();
    observable.addObserver(this);
  }

  Locale _locale = const Locale.fromSubtags(languageCode: 'pt');
  Locale get locale => _locale;
  late Observable observable;

  void setNewLocale(Locale newLocale) {
    _locale = newLocale;
    observable.notifyObservers();
  }

  void getLocale(String key) {
    if (key == 'en') {
      _locale = const Locale("en", "EN");
    } else {
      _locale = const Locale.fromSubtags(languageCode: "pt");
    }
    observable.notifyObservers();
  }

  Locale? localeResolutionCallback(Locale? locale, Iterable<Locale> supported) {
    for (var supportedLocale in supported) {
      if (supportedLocale.languageCode == locale?.languageCode &&
          supportedLocale.countryCode == locale?.countryCode) {
        return supportedLocale;
      }
    }
    return supported.first;
  }

  Future<void> initLocale() async {
    final multiLang = MultiLanguagesImpl();
    final localeKey = await multiLang.readLocalePrefs();

    getLocale(localeKey);
  }

  @override
  void update() {
    notifyListeners();
  }
}
