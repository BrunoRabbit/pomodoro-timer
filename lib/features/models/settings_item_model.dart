import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/controllers/global_controller.dart';

class SettingsItemModel {
  SettingsItemModel({
    required this.title,
    this.subTitle,
    required this.onPress,
  });

  String title;
  String? subTitle;
  Function(TextEditingController) onPress;

  List<SettingsItemModel> populateItemModel(GlobalController control) {
    return [
      SettingsItemModel(
        title: 'Pomodoro',
        subTitle: parseMin(control.durationWork.toDouble()),
        onPress: (text) => control.changeWorkMinutes(text.text),
      ),
      SettingsItemModel(
        title: 'Descanso',
        subTitle: parseMin(control.durationRest.toDouble()),
        onPress: (text) => control.changeRestMinutes(text.text),
      ),
      SettingsItemModel(
        title: 'Ciclos trabalho/descanso',
        subTitle: '${control.cycles} ${plural(control.cycles)}',
        onPress: (_) {},
      ),
    ];
  }

  String plural(int count) {
    return count == 1 ? "ciclo" : "ciclos";
  }

  String parseMin(double min) {
    if (min < 10) {
      return (min / 10).toString();
    }
    return (min / 60).toString();
  }
}
