class LanguageModel {
  LanguageModel({
    required this.workingTitle,
    required this.restTitle,
    required this.cycles,
    required this.startTimer,
    required this.pauseTimer,
    required this.restartTimer,
    required this.settingsTitle,
    required this.notificationsTitle,
    required this.notificationsDescription,
    required this.statisticsTitle,
    required this.settingsSection,
  });

  String workingTitle;
  String restTitle;
  String cycles;
  String startTimer;
  String pauseTimer;
  String restartTimer;
  String notificationsTitle;
  String notificationsDescription;
  String statisticsTitle;
  String settingsTitle;
  List<SettingsSectionModel> settingsSection;

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      workingTitle: map['working_title'],
      restTitle: map['rest_title'],
      cycles: map['cycles'],
      startTimer: map['start_timer'],
      pauseTimer: map['pause_timer'],
      restartTimer: map['restart_timer'],
      notificationsTitle: map['notifications_title'],
      notificationsDescription: map['notifications_description'],
      statisticsTitle: map['statistics_title'],
      settingsTitle: map['settings_title'],
      settingsSection: List<SettingsSectionModel>.from(
        map['settings_section'].map<SettingsSectionModel>(
          (x) => SettingsSectionModel.fromMap(x as Map<String, dynamic>),
        ),
      ),
    );
  }
}

class SettingsSectionModel {
  SettingsSectionModel({
    required this.sectionTitle,
    required this.sectionItems,
  });

  String? sectionTitle;
  List<String>? sectionItems;

  factory SettingsSectionModel.fromMap(Map<String, dynamic> map) {
    return SettingsSectionModel(
      sectionTitle: map['section_title'] as String,
      sectionItems: List<String>.from(map['section_items']),
    );
  }
}
