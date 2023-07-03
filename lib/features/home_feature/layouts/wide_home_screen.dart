import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/home_feature/layouts/narrow_home_screen.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';

class WideHomeScreen extends StatelessWidget {
  const WideHomeScreen({
    super.key,
    required this.viewModel,
  });

  final PomodoroViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: NarrowHomeScreen(
              viewModel: viewModel,
            ),
          ),
        ),
      ],
    );
  }
}
