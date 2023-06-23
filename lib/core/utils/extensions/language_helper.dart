import 'package:pomodoro_timer/features/settings_feature/view/widgets/settings_items_widget.dart';

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
