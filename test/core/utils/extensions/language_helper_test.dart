import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/utils/enums/language.dart';
import 'package:pomodoro_timer/core/utils/extensions/language_helper.dart';

void main() {
  test('languageCode should convert Language values in pt-BR or en-EN', () {
    expect(Language.ptBR.languageCode, equals('pt-BR'));
    expect(Language.enEN.languageCode, equals('en-EN'));
  });
}