import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/localization/json_file_manager.dart';
import 'package:pomodoro_timer/core/localization/multi_languages_delegate.dart';
import 'package:pomodoro_timer/features/controllers/language_controller.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

abstract class MultiLanguages {
  Future<void> storeLocalePrefs(String localeKey);
  Future<String> readLocalePrefs();
  void setLocale(BuildContext context, Locale locale);
}

class MultiLanguagesImpl with JsonFileManager implements MultiLanguages {
  MultiLanguagesImpl({
    this.locale = const Locale.fromSubtags(languageCode: 'en'),
  });

  final Locale locale;
  static const String prefsKey = 'localeKey';

  static MultiLanguagesImpl? of(BuildContext context) {
    return Localizations.of(context, MultiLanguagesImpl);
  }

  // ? shared prefs
  @override
  Future<void> storeLocalePrefs(String localeKey) async {
    final prefs = await SharedPreferences.getInstance();

    await prefs.setString(prefsKey, localeKey);
  }

  @override
  Future<String> readLocalePrefs() async {
    final prefs = await SharedPreferences.getInstance();

    return prefs.getString(prefsKey) ?? 'pt';
  }

  @override
  void setLocale(BuildContext context, Locale locale) async {
    storeLocalePrefs(locale.languageCode);

    Provider.of<LanguageController>(context, listen: false)
        .setNewLocale(locale);
  }

  static const LocalizationsDelegate<MultiLanguages> delegate =
      MultiLanguagesDelegate();
}
