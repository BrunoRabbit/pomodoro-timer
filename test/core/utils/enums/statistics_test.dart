import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/utils/enums/statistics.dart';

void main() {
  test('Statistics enum should have correct values', () {
    expect(Statistics.day, equals(Statistics.values[0]));
    expect(Statistics.week, equals(Statistics.values[1]));
    expect(Statistics.month, equals(Statistics.values[2]));
  });
}
