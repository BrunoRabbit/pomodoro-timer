import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pomodoro_timer/core/routes/routes.dart';
import 'package:pomodoro_timer/features/language_feature/view_model/language_view_model.dart';
import 'package:pomodoro_timer/features/notifications_feature/view_model/notifications_view_model.dart';
import 'package:pomodoro_timer/features/settings_feature/view_model/settings_view_model.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';
import 'package:provider/provider.dart';

void application() {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(const Application());
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
      ],
      child: Builder(
        builder: (context) {
          LanguageViewModel languageViewModel =
              Provider.of<LanguageViewModel>(context);

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
            locale: languageViewModel.locale,
            localeResolutionCallback: (locale, supported) {
              return languageViewModel.localeResolutionCallback(
                  locale, supported);
            },
          );
        },
      ),
    );
  }
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}
