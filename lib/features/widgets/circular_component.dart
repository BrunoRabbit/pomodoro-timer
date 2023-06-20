
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/core/utils/extensions/hour_helper.dart';
import 'package:pomodoro_timer/core/utils/extensions/translate_helper.dart';
import 'package:pomodoro_timer/features/controllers/pomodoro_controller.dart';

class CircularComponent extends StatelessWidget {
  const CircularComponent({
    super.key,
    required this.size,
    required this.controller,
  });

  final double size;
  final PomodoroController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ? Stack -> double circular progress (blue and red)
          Stack(
            children: [
              Center(
                child: SizedBox(
                  height: size,
                  width: size,
                  child: CircularProgressIndicator(
                    value: 0,
                    strokeWidth: 4,
                    backgroundColor: controller.isWorking
                        ? AppColors.kProgressMissing
                        : AppColors.kProgressMissingGreen,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: size,
                  width: size,
                  child: CircularProgressIndicator(
                    color: Colors.white, // AppColors.kProgressColor
                    value: controller.remainingTime == 0
                        ? 1.0
                        : 1 -
                            (controller.remainingTime /
                                (controller.isWorking
                                    ? controller.durationWork
                                    : controller.durationRest)),
                    strokeWidth: 8,
                  ),
                ),
              ),
            ],
          ),
          Text(
            controller.remainingTime.toInt().toMinSec(),
            style: const TextStyle(
              color: Colors.white,
              fontSize: FontSizes.xLarge * 2,
              fontWeight: FontWeight.w700,
              letterSpacing: 1.4,
            ),
          ),
          Positioned(
            bottom: 40,
            child: Column(
              children: [
                Text(
                  "cycles".pdfString(context),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.medium,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
                const SizedBox(
                  height: 8,
                ),
                Text(
                  "${controller.timerCycle}",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.medium,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}