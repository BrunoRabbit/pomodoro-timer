import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'multi_languages_test.mocks.dart';

@GenerateNiceMocks([
  MockSpec<BuildContext>(),
  MockSpec<SharedPreferences>(),
])
void main() {
  // Initialize the MockSharedPreferences
  MockSharedPreferences mockSharedPreferences = MockSharedPreferences();
  late MultiLanguagesImpl multiLanguages;
  const String testLanguageCode = 'pt';

  setUp(() {
    multiLanguages = MultiLanguagesImpl(locale: const Locale(testLanguageCode));

    when(mockSharedPreferences.getString(any)).thenReturn(testLanguageCode);

    when(mockSharedPreferences.setString(any, any))
        .thenAnswer((_) => Future.value(true));
    SharedPreferences.setMockInitialValues({});
  });

  test('storeLocalePrefs should store the selected locale in SharedPreferences',
      () async {
    await multiLanguages.storeLocalePrefs(testLanguageCode);

    final prefs = await SharedPreferences.getInstance();
    final storedLanguageCode = prefs.getString(MultiLanguagesImpl.prefsKey);

    expect(storedLanguageCode, testLanguageCode);
  });

  test('readLocalePrefs should return default locale when no prefs are set',
      () async {
    final locale = await multiLanguages.readLocalePrefs();
    expect(locale, testLanguageCode);
  });

  test('readLocalePrefs should return the saved locale', () async {
    when(mockSharedPreferences.getString(MultiLanguagesImpl.prefsKey))
        .thenReturn(testLanguageCode);
    final locale = await multiLanguages.readLocalePrefs();
    expect(locale, testLanguageCode);
  });
}
