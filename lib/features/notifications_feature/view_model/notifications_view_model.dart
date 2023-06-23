import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:pomodoro_timer/core/utils/extensions/translate_helper.dart';
import 'package:pomodoro_timer/features/providers/observer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NotificationsViewModel extends ChangeNotifier implements Observer {
  final Observable observable = Observable();

  NotificationsViewModel() {
    observable.addObserver(this);
  }

  NotificationsViewModel.removeObserver() {
    observable.removeObserver(this);
  }

  bool isNotificationAllowed = true;
  static const _notificationKey = 'userNotificationPrefs';

  FlutterLocalNotificationsPlugin notificationsPlugin =
      FlutterLocalNotificationsPlugin();

  Future<void> initNotification() async {
    const String flutterIcon = '@mipmap/ic_launcher';

    const InitializationSettings initializationSettings =
        InitializationSettings(
      android: AndroidInitializationSettings(flutterIcon),
    );

    await notificationsPlugin.initialize(initializationSettings);
  }

  Future<void> showNotification(BuildContext context) async {
    const AndroidNotificationDetails androidChannelSpecifics =
        AndroidNotificationDetails(
      'channel_id',
      'channel_name',
      channelDescription: 'channel_description',
      importance: Importance.max,
      priority: Priority.high,
      styleInformation: BigTextStyleInformation(''),
    );

    const NotificationDetails platformChannelSpecifics = NotificationDetails(
      android: androidChannelSpecifics,
    );

    await notificationsPlugin.show(
      0,
      'notifications_title'.pdfString(context),
      'notifications_description'.pdfString(context),
      platformChannelSpecifics,
    );
  }

  void toggleNotifications() {
    isNotificationAllowed = !isNotificationAllowed;
    observable.notifyObservers();
  }

  Future<void> saveUserNotificationPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(_notificationKey, isNotificationAllowed);

    observable.notifyObservers();
  }

  Future<void> getUserNotificationPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();

    isNotificationAllowed = prefs.getBool(_notificationKey) ?? true;
    observable.notifyObservers();
  }

  @override
  void update() {
    notifyListeners();
  }
}
