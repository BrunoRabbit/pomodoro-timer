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
    required this.inputTitleMinutes,
    required this.inputSaveButton,
    required this.inputError,
    required this.snackBar,
  });

  String workingTitle;
  String restTitle;
  List<String> cycles;
  String startTimer;
  String pauseTimer;
  String restartTimer;
  String notificationsTitle;
  String notificationsDescription;
  String statisticsTitle;
  String settingsTitle;
  String inputTitleMinutes;
  String inputSaveButton;
  String inputError;
  String snackBar;
  List<SettingsSectionModel> settingsSection;

  factory LanguageModel.fromMap(Map<String, dynamic> map) {
    return LanguageModel(
      workingTitle: map['working_title'],
      restTitle: map['rest_title'],
      cycles: List<String>.from(map['cycles'] as List<dynamic>),
      startTimer: map['start_timer'],
      pauseTimer: map['pause_timer'],
      restartTimer: map['restart_timer'],
      notificationsTitle: map['notifications_title'],
      notificationsDescription: map['notifications_description'],
      statisticsTitle: map['statistics_title'],
      settingsTitle: map['settings_title'],
      inputTitleMinutes: map['input_title_minutes'],
      inputError: map['input_error'],
      inputSaveButton: map['input_save_button'],
      snackBar: map['snack_bar'],
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
