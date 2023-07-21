import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/utils/enums/notifications.dart';
import 'package:pomodoro_timer/core/utils/extensions/notifications_helper.dart';

void main() {
  test('Translate Notifications values to pt-BR format', () {
    expect(Notifications.yes.notificationCode, equals('Sim'));
    expect(Notifications.no.notificationCode, equals('Não'));
  });
}