import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';

mixin JsonFileManager {
  late LanguageModel languageModel;

  Future<void> loadJson(Locale locale) async {
    String jsonString = await rootBundle.loadString(
      'assets/languages/${locale.languageCode}.json',
    );

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    languageModel = LanguageModel.fromMap(jsonMap); 
  }

  LanguageModel instance() {
    return languageModel;
  }
}
