import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:pomodoro_timer/core/routes/routes.dart';
import 'package:pomodoro_timer/features/controllers/language_controller.dart';
import 'package:pomodoro_timer/features/controllers/pomodoro_controller.dart';
import 'package:pomodoro_timer/features/controllers/settings_controller.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
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
        ChangeNotifierProvider<PomodoroController>(
          create: (context) => PomodoroController(),
        ),
        ChangeNotifierProvider<SettingsController>(
          create: (context) => SettingsController(
            Provider.of<PomodoroController>(context, listen: false),
          ),
        ),
        ChangeNotifierProvider<LanguageController>(
          create: (context) => LanguageController(),
        ),
      ],
      child: Builder(
        builder: (context) {
          LanguageController langController =
              Provider.of<LanguageController>(context);

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
            locale: langController.locale,
            localeResolutionCallback: (locale, supported) {
              return langController.localeResolutionCallback(locale, supported);
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
