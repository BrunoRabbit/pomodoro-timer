import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/home_feature/view/widgets/circular_component.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/shared/widgets/custom_button.dart';

class _NarrowHomeScreenState extends State<NarrowHomeScreen> {
  late double size;
  late bool isLandscape;
  late LanguageModel _languageModel;

  bool get isWorking => widget.viewModel.isWorking;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size.height / 3;
    isLandscape = MediaQuery.of(context).orientation == Orientation.landscape;
    _languageModel = MultiLanguagesImpl.of(context)!.instance();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        SizedBox(
          height: isLandscape ? size / 6 : size / 4,
        ),

        // ? Title
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Text(
            isWorking ? _languageModel.workingTitle : _languageModel.restTitle,
            style: const TextStyle(
              fontFamily: 'Raleway',
              fontWeight: FontWeight.w600,
              fontSize: FontSizes.large,
              color: Colors.white,
            ),
          ),
        ),
        CircularComponent(
          viewModel: widget.viewModel,
          languageModel: _languageModel,
        ),
        SizedBox(
          height: size / 6,
        ),
        CustomButton(
          title: !widget.viewModel.isTimerActive
              ? _languageModel.startTimer
              : _languageModel.pauseTimer,
          onPressed: () {
            if (!widget.viewModel.isTimerActive) {
              _handleTimerStart();
            } else {
              widget.viewModel.pauseTimer();
            }
          },
          isWorking: isWorking,
        ),
        SizedBox(
          height: size / 16,
        ),
        CustomButton(
          isWorking: isWorking,
          title: _languageModel.restartTimer,
          onPressed: () {
            widget.viewModel.resetTimer();
          },
        ),

        isLandscape
            ? SizedBox(
                height: size / 6,
              )
            : Container(),
      ],
    );
  }

  void _handleTimerStart() {
    int userCycleLimit = widget.viewModel.userCycleLimit;
    int timerCycle = widget.viewModel.timerCycle;

    if (userCycleLimit > 0 && timerCycle >= userCycleLimit) {
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(_languageModel.snackBar),
          ),
        );
      return;
    }

    widget.viewModel.startTimer(context);
  }
}

class NarrowHomeScreen extends StatefulWidget {
  const NarrowHomeScreen({
    super.key,
    required this.viewModel,
  });

  final PomodoroViewModel viewModel;

  @override
  State<NarrowHomeScreen> createState() => _NarrowHomeScreenState();
}
