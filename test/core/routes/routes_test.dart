import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/routes/routes.dart';
import 'package:pomodoro_timer/core/routes/routes.gr.dart';

void main() {
  test('Routes should be constructed correctly', () {
    final routes = Routes().routes;

    expect(routes.length, 3);

    expect(routes[0].name, HomeRoute.page.name);
    expect(routes[0].initial, true);

    expect(routes[1].name, SettingsRoute.page.name);
    expect(routes[1].initial, false);

    expect(routes[2].name, StatisticsRoute.page.name);
    expect(routes[2].initial, false);
  });
}
