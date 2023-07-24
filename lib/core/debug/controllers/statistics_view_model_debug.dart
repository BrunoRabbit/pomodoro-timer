import 'package:flutter/foundation.dart';
import 'package:pomodoro_timer/features/statistics_feature/view_model/statistics_view_model.dart';

class StatisticsViewModelDebug extends StatisticsViewModel {
  StatisticsViewModelDebug(super.viewModel);

  void debug(DiagnosticPropertiesBuilder properties) {
    properties.add(IntProperty('pomodoro', pomodoro));
    properties.add(StringProperty('hour and minute', totalMinutes));
    properties.add(IntProperty('userSection', userSection));
  }
}
