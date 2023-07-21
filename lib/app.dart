import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pomodoro_timer/core/routes/routes.dart';
import 'package:pomodoro_timer/features/language_feature/view_model/language_view_model.dart';
import 'package:pomodoro_timer/features/notifications_feature/view_model/notifications_view_model.dart';
import 'package:pomodoro_timer/features/settings_feature/view_model/settings_view_model.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';
import 'package:pomodoro_timer/features/statistics_feature/view_model/statistics_view_model.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

void application() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();

  runApp(Application(prefs));
}

class _ApplicationState extends State<Application> {
  final _appRouter = Routes();

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PomodoroViewModel>(
          create: (context) => PomodoroViewModel(),
        ),
        ChangeNotifierProvider<SettingsViewModel>(
          create: (context) => SettingsViewModel(
            Provider.of<PomodoroViewModel>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<LanguageViewModel>(
          create: (context) => LanguageViewModel(),
        ),
        ChangeNotifierProvider<NotificationsViewModel>(
          create: (context) => NotificationsViewModel(),
        ),
        ChangeNotifierProvider<StatisticsViewModel>(
          create: (context) => StatisticsViewModel(
            Provider.of<PomodoroViewModel>(context, listen: false),
          ),
        ),
      ],
      child: Consumer<LanguageViewModel>(
        builder: (context, value, child) {
          return MaterialApp.router(
            routerConfig: _appRouter.config(),
            debugShowCheckedModeBanner: false,
            supportedLocales: const [
              Locale('en', 'US'),
              Locale.fromSubtags(languageCode: 'pt'),
            ],
            localizationsDelegates: const [
              MultiLanguagesImpl.delegate,
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
            ],
            locale: Locale(widget.prefs.getString('localeKey') ?? 'pt'),
            localeResolutionCallback: (locale, supported) {
              return value.localeResolutionCallback(locale, supported);
            },
          );
        },
      ),
    );
  }
}

class Application extends StatefulWidget {
  const Application(this.prefs, {super.key});

  final SharedPreferences prefs;

  @override
  State<Application> createState() => _ApplicationState();
}
