import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/utils/keys/shared_preferences_keys.dart';

void main() {
  test('SharedPreferencesKeys should have correct key values', () {
    expect(SharedPreferencesKeys.userSectionKey, 'UserSectionKey');
    expect(SharedPreferencesKeys.sectionKey, 'SectionKey');
    expect(SharedPreferencesKeys.remainingTimeKey, 'RemainingTimeKey');
  });
}
