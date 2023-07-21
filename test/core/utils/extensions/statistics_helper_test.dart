import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/utils/enums/statistics.dart';
import 'package:pomodoro_timer/core/utils/extensions/statistics_helper.dart';

void main() {
  test('Translate Statistics values to pt-BR format', () {
    expect(Statistics.day.statisticsLocale, equals('Dia'));
    expect(Statistics.week.statisticsLocale, equals('Semana'));
    expect(Statistics.month.statisticsLocale, equals('Mês'));
  });
}