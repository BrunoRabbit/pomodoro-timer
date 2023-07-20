import 'package:flutter/foundation.dart';
import 'package:pomodoro_timer/features/language_feature/view_model/language_view_model.dart';

class LanguageViewModelDebug extends LanguageViewModel {
  // ! dev tools
  void debug(DiagnosticPropertiesBuilder properties) {
    properties.add(ObjectFlagProperty(
      'Locale',
      locale,
      ifPresent: 'pt',
      ifNull: 'en',
    ));
  }
}
