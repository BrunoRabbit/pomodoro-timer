import 'package:flutter/foundation.dart';
import 'package:pomodoro_timer/features/settings_feature/view_model/settings_view_model.dart';

class SettingsViewModelDebug extends SettingsViewModel {
  SettingsViewModelDebug(super.viewModel);

  void debug(DiagnosticPropertiesBuilder properties) {
    properties.add(IntProperty('toggleValue', toggleValue));
    properties.add(IntProperty('userCycleLimit', userCycleLimit));
    properties.add(IntProperty('itemSelected', itemSelected));

    properties.add(DoubleProperty('durationWork', durationWork));
    properties.add(DoubleProperty('durationRest', durationRest));

    properties.add(
      FlagProperty('isWorking',
          value: isWorking,
          ifTrue: 'user is working',
          ifFalse: 'user is not working'),
    );
  }
}
