import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';

class MultiLanguagesDelegate extends LocalizationsDelegate<MultiLanguagesImpl> {
  const MultiLanguagesDelegate();

  @override
  bool isSupported(Locale locale) {
    return ['en', 'pt'].contains(locale.languageCode);
  }

  @override
  Future<MultiLanguagesImpl> load(Locale locale) async {
    MultiLanguagesImpl languages = MultiLanguagesImpl(locale: locale);
    await languages.loadJson(locale);

    return languages;
  }

  @override
  bool shouldReload(covariant LocalizationsDelegate<MultiLanguagesImpl> old) =>
      false;
}
