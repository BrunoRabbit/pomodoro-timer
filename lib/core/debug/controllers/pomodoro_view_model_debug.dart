import 'package:flutter/foundation.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';

class PomodoroViewModelDebug extends PomodoroViewModel {
  // ! dev tools
  void debug(DiagnosticPropertiesBuilder properties) {
    properties.add(IntProperty('timerCycle', timerCycle));
    properties.add(IntProperty('userCycleLimit', userCycleLimit));

    properties.add(DoubleProperty('durationRest', durationRest));
    properties.add(DoubleProperty('durationWork', durationWork));
    properties.add(DoubleProperty('remainingTime', remainingTime));

    properties.add(
      FlagProperty('isTimerActive',
          value: isTimerActive,
          ifFalse: 'Timer deactivated',
          ifTrue: 'Timer active'),
    );

    properties.add(
      FlagProperty('isWorking',
          value: isWorking,
          ifTrue: 'user is working',
          ifFalse: 'user is not working'),
    );
  }
}
