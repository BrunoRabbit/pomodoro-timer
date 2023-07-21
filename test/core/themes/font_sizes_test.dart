import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';

void main() {
  test('FontSizes should have correct font size values', () {
    expect(FontSizes.light, 12.0);
    expect(FontSizes.medium, 16.0);
    expect(FontSizes.large, 20.0);
    expect(FontSizes.xLarge, 30.0);
    expect(FontSizes.xxLarge, 35.0);
  });
}
