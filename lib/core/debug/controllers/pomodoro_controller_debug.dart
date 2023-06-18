import 'package:flutter/foundation.dart';
import 'package:pomodoro_timer/features/controllers/pomodoro_controller.dart';

class PomodoroControllerDebug extends PomodoroController {
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
