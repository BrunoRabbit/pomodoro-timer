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
        subTitle: control.durationWork.toString(),
        onPress: (text) => control.changeWorkMinutes(text.text),
      ),
      SettingsItemModel(
        title: 'Descanso',
        subTitle: control.durationRest.toString(),
        onPress: (text) => control.changeRestMinutes(text.text),
      ),
      SettingsItemModel(
        title: 'Ciclos trabalho/descanso',
        subTitle: '${control.cycles} ${plural(control.cycles)}',
        onPress: (_) {},
      ),
      SettingsItemModel(
        title: 'cccccc',
        subTitle: 'dddddd',
        onPress: (_) {},
      ),
      SettingsItemModel(
        title: 'eeeee',
        subTitle: 'fffff',
        onPress: (_) {},
      ),
      SettingsItemModel(
        title: 'ggggg',
        subTitle: 'hhhhh',
        onPress: (_) {},
      ),
    ];
  }

  String plural(int count) {
    return count == 1 ? "ciclo" : "ciclos";
  }
}
