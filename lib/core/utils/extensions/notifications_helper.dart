import 'package:pomodoro_timer/core/utils/enums/notifications.dart';

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