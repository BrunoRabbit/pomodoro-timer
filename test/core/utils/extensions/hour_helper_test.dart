import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/utils/extensions/hour_helper.dart';

void main() {
  test('toMinSec() should convert an integer to formatted string (mm:ss)', () {
    expect(0.toMinSec(), equals('00:00'));
    expect(60.toMinSec(), equals('01:00'));
    expect(90.toMinSec(), equals('01:30'));
    expect(365.toMinSec(), equals('06:05'));
    expect(900.toMinSec(), equals('15:00'));
  });
}