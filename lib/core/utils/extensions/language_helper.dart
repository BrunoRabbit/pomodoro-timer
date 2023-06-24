import 'package:pomodoro_timer/core/utils/enums/language.dart';

extension LanguageHelper on Language {
  String get languageCode {
    switch (this) {
      case Language.ptBR:
        return 'pt-BR';
      case Language.enEN:
        return 'en-EN';
    }
  }
}
