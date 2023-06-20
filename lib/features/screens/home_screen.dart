import 'package:auto_route/auto_route.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/core/utils/extensions/translate_helper.dart';
import 'package:pomodoro_timer/features/controllers/language_controller.dart';
import 'package:pomodoro_timer/features/controllers/pomodoro_controller.dart';
import 'package:pomodoro_timer/features/widgets/circular_component.dart';
import 'package:pomodoro_timer/features/widgets/custom_button.dart';
import 'package:pomodoro_timer/features/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/routes/routes.gr.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double size;
  late PomodoroController controller;
  final multiLang = MultiLanguagesImpl();

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size.height / 3;
    controller = Provider.of<PomodoroController>(context);
    initLocale(context);
  }

  @override
  void dispose() {
    super.dispose();
    controller = PomodoroController.removeObserver();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      bgColor: !controller.isWorking ? AppColors.kScaffoldGreenSecondary : null,
      gradient: !controller.isWorking
          ? const LinearGradient(
              colors: [
                AppColors.kScaffoldGreenPrimary,
                AppColors.kScaffoldGreenSecondary,
              ],
              begin: Alignment.bottomCenter,
              end: Alignment.topCenter,
            )
          : null,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.settings_rounded),
          onPressed: () {
            context.router.push(const SettingsRoute());
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.equalizer),
            onPressed: () {
              context.router.push(const SettingsRoute());
            },
          ),
        ],
      ),
      body: Column(
        children: <Widget>[
          SizedBox(
            height: size / 4,
          ),

          // ? Title
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10.0),
            child: Text(
              controller.isWorking
                  ? 'working_title'.pdfString(context)
                  : 'rest_title'.pdfString(context),
              style: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w600,
                fontSize: FontSizes.large,
                color: Colors.white,
              ),
            ),
          ),
          CircularComponent(
            size: size,
            controller: controller,
          ),
          SizedBox(
            height: size / 6,
          ),
          CustomButton(
            title: !controller.isTimerActive
                ? 'start_timer'.pdfString(context)
                : 'pause_timer'.pdfString(context),
            onPressed: () {
              if (!controller.isTimerActive) {
                controller.startTimer(context);
              } else {
                controller.pauseTimer();
              }
            },
            isWorking: controller.isWorking,
          ),
          SizedBox(
            height: size / 16,
          ),
          CustomButton(
            isWorking: controller.isWorking,
            title: 'restart_timer'.pdfString(context),
            onPressed: () {
              controller.resetTimer();
            },
          ),
          // CustomButton(
          //   isWorking: controller.isWorking,
          //   title: 'CHANGE LOCALE',
          //   onPressed: () => changeLocale(),
          // ),
        ],
      ),
    );
  }

  Future<void> initLocale(BuildContext context) async {
    LanguageController languageController =
        Provider.of<LanguageController>(context, listen: false);

    final localeKey = await multiLang.readLocalePrefs();

    languageController.getLocale(localeKey);
  }
}
