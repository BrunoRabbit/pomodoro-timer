import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/utils/enums/language.dart';

void main() {
  test('Language enum should have correct values', () {
    expect(Language.ptBR, equals(Language.values[0]));
    expect(Language.enEN, equals(Language.values[1]));
  });
}
