import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/core/utils/extensions/hour_helper.dart';
import 'package:pomodoro_timer/core/utils/extensions/translate_helper.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';

class CircularComponent extends StatelessWidget {
  const CircularComponent({
    super.key,
    required this.size,
    required this.viewModel,
  });

  final double size;
  final PomodoroViewModel viewModel;
  @override
  Widget build(BuildContext context) {
    final bool position =
        MediaQuery.of(context).orientation == Orientation.landscape;

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
                  height: _adjustPosition(position),
                  width: _adjustPosition(position),
                  child: CircularProgressIndicator(
                    value: 0,
                    strokeWidth: 4,
                    backgroundColor: viewModel.isWorking
                        ? AppColors.kProgressMissing
                        : AppColors.kProgressMissingGreen,
                  ),
                ),
              ),
              Center(
                child: SizedBox(
                  height: _adjustPosition(position),
                  width: _adjustPosition(position),
                  child: CircularProgressIndicator(
                    color: Colors.white, // AppColors.kProgressColor
                    value: viewModel.remainingTime == 0
                        ? 1.0
                        : 1 -
                            (viewModel.remainingTime /
                                (viewModel.isWorking
                                    ? viewModel.durationWork
                                    : viewModel.durationRest)),
                    strokeWidth: 8,
                  ),
                ),
              ),
            ],
          ),
          Text(
            viewModel.remainingTime.toInt().toMinSec(),
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
                  "${viewModel.timerCycle}",
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

  double _adjustPosition(position) {
    return position ? size / 0.5 : size;
  }
}
