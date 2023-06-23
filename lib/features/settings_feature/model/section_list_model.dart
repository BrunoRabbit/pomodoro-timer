import 'package:pomodoro_timer/features/settings_feature/model/settings_item_model.dart';

class SectionListModel {
  SectionListModel({
    required this.title,
    required this.items,
  });

  String title;
  List<SettingsItemModel> items;
}
