import 'package:pomodoro_timer/features/controllers/global_controller.dart';

class SettingsItemModel {
  SettingsItemModel({
    required this.title,
    this.subTitle,
  });

  String title;
  String? subTitle;

  List<SettingsItemModel> populateItemModel(GlobalController control) {
    return [
      SettingsItemModel(
        title: 'Pomodoro',
        subTitle: control.durationWork.toString(),
      ),
      SettingsItemModel(
        title: 'Descanso',
        subTitle: control.durationRest.toString(),
      ),
      SettingsItemModel(
          title: 'Ciclos trabalho/descanso',
          subTitle: '${control.cycles} ${plural(control.cycles)}'),
      SettingsItemModel(
        title: 'cccccc',
        subTitle: 'dddddd',
      ),
      SettingsItemModel(
        title: 'eeeee',
        subTitle: 'fffff',
      ),
      SettingsItemModel(
        title: 'ggggg',
        subTitle: 'hhhhh',
      ),
    ];
  }

  String plural(int count) {
    return count == 1 ? "ciclo" : "ciclos";
  }
}
