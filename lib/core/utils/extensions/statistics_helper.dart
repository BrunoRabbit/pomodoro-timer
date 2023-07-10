import 'package:pomodoro_timer/core/utils/enums/statistics.dart';

extension StatisticsHelper on Statistics {
  String get statisticsLocale {
    switch (this) {
      case Statistics.day:
        return 'Dia';
      case Statistics.week:
        return 'Semana';
      case Statistics.month:
        return 'Mês';
    }
  }
}