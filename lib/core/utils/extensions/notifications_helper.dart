import 'package:pomodoro_timer/features/settings_feature/view/widgets/settings_items_widget.dart';

extension NotificationsHelper on Notifications {
  String get notificationCode {
    switch (this) {
      case Notifications.yes:
        return 'Sim';
      case Notifications.no:
        return 'Não';
    }
  }
}