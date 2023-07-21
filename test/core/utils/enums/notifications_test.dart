import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/utils/enums/notifications.dart';

void main() {
  test('Notifications enum should have correct values', () {
    expect(Notifications.yes, equals(Notifications.values[0]));
    expect(Notifications.no, equals(Notifications.values[1]));
  });
}
