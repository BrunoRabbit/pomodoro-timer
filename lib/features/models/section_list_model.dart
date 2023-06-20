import 'package:pomodoro_timer/features/models/settings_item_model.dart';

class SectionListModel {
  SectionListModel({
    required this.title,
    required this.items,
  });

  String title;
  List<SettingsItemModel> items;
}
