import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';

void main() {
  test('AppColors should have correct color values', () {
    expect(AppColors.scaffoldColorPrimary, const Color(0xffF42E48));
    expect(AppColors.scaffoldColorSecondary, const Color(0xffFC4F44));
    expect(AppColors.scaffoldGreenPrimary, const Color(0xff279F5C));
    expect(AppColors.scaffoldGreenSecondary, const Color(0xff1B7042));
    expect(AppColors.progressMissingGreen, const Color(0xff419B63));
    expect(AppColors.progressColorMissing, const Color(0xffFA656D));
    expect(AppColors.progressColor, const Color(0xffE06E77));
    expect(AppColors.cardRedBackground, const Color(0xffD4303D));
    expect(AppColors.linesCardBorderColor, const Color(0xffBE2934));
  });
}
