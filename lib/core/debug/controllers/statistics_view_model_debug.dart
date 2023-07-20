import 'package:flutter/foundation.dart';
import 'package:pomodoro_timer/features/statistics_feature/view_model/statistics_view_model.dart';

class StatisticsViewModelDebug extends StatisticsViewModel {
  StatisticsViewModelDebug(super.viewModel);

  void debug(DiagnosticPropertiesBuilder properties) {
    properties.add(IntProperty('pomodoro', pomodoro));
    properties.add(IntProperty('hours', hours));
    properties.add(IntProperty('minutes', minutes));
    properties.add(IntProperty('userSection', userSection));
  }
}
