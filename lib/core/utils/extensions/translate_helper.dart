import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';

extension TranslateHelper on String {
  String pdfString(BuildContext context) {
    return MultiLanguagesImpl.of(context)!.translate(this);
  }
}
