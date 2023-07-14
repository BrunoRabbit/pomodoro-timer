import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/core/utils/extensions/hour_helper.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:provider/provider.dart';

class CircularComponent extends StatelessWidget {
  const CircularComponent({
    super.key,
    required this.viewModel,
    required this.languageModel,
  });

  final LanguageModel languageModel;
  final PomodoroViewModel viewModel;

  double get remainingTime => viewModel.remainingTime;
  double get currentDuration =>
      viewModel.isWorking ? viewModel.durationWork : viewModel.durationRest;

  double get valueCircularProgress => 1 - (remainingTime / (currentDuration));

  @override
  Widget build(BuildContext context) {
    final sizes = viewModel.adjustPosition(context);
    
    return Padding(
      padding: const EdgeInsets.only(top: 30.0),
      child: Stack(
        alignment: Alignment.center,
        children: [
          // ? Two Circular Progress
          Stack(
            children: [
              Center(
                child: SizedBox(
                  height: sizes,
                  width: sizes,
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
                  height: sizes,
                  width: sizes,
                  child: CircularProgressIndicator(
                    color: Colors.white, // AppColors.kProgressColor
                    value: remainingTime == 0 ? 1.0 : valueCircularProgress,
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
                  languageModel.cycles.first,
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
}
