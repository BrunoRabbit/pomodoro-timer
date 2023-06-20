import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

mixin JsonFileManager {
  late Map<String, String> _localesMap;

  Future<void> loadJson(Locale locale) async {
    String jsonString = await rootBundle.loadString(
      'assets/languages/${locale.languageCode}.json',
    );

    Map<String, dynamic> jsonMap = json.decode(jsonString);

    _localesMap = jsonMap.map((key, value) {
      return MapEntry(key, value.toString());
    });
  }

  String translate(String key) {
    return _localesMap[key]!;
  }
}
