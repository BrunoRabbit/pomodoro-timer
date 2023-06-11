import 'package:auto_route/auto_route.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/controllers/global_controller.dart';
import 'package:pomodoro_timer/features/widgets/custom_button.dart';
import 'package:pomodoro_timer/features/widgets/gradient_scaffold.dart';
import 'package:pomodoro_timer/core/utils/extensions/hour_helper.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/routes/routes.gr.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late double size;
  late GlobalController controller;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size.height / 3;
    controller = Provider.of<GlobalController>(context);
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
                  ? 'MANTENHA O FOCO'
                  : 'TENHA CALMA, DESCANSE',
              style: const TextStyle(
                fontFamily: 'Raleway',
                fontWeight: FontWeight.w600,
                fontSize: FontSizes.large,
                color: Colors.white,
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30.0),
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ? Stack -> double circular progress (blue and red)
                Stack(
                  children: [
                    Center(
                      child: SizedBox(
                        height: size,
                        width: size,
                        child: CircularProgressIndicator(
                          value: 0,
                          strokeWidth: 4,
                          backgroundColor: controller.isWorking
                              ? AppColors.kProgressMissing
                              : AppColors.kProgressMissingGreen,
                        ),
                      ),
                    ),
                    Center(
                      child: SizedBox(
                        height: size,
                        width: size,
                        // TODO - VALUE ANIMATED
                        child: CircularProgressIndicator(
                          color: Colors.white, // AppColors.kProgressColor
                          value: controller.remainingTime == 0
                              ? 1.0
                              : 1 -
                                  (controller.remainingTime /
                                      (controller.isWorking
                                          ? controller.durationWork
                                          : controller.durationRest)),
                          strokeWidth: 8,
                        ),
                      ),
                    ),
                  ],
                ),
                Text(
                  controller.remainingTime.toInt().toMinSec(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: FontSizes.xLarge * 2,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 1.4,
                  ),
                ),
                Positioned(
                  bottom: 40,
                  child: Column(
                    children: [
                      const Text(
                        "Cycles",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.medium,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                        ),
                      ),
                      const SizedBox(
                        height: 8,
                      ),
                      Text(
                        "${controller.cycles}",
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.medium,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.4,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(
            height: size / 6,
          ),
          CustomButton(
            title: !controller.isTimerActive
                ? 'INICIAR POMODORO'
                : 'PAUSAR POMODORO',
            onPressed: () {
              if (!controller.isTimerActive) {
                controller.startTimer();
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
            title: 'REINICIAR',
            onPressed: () {
              controller.resetTimer();
            },
          ),

          // Text(
          //   '${(remainingTime ~/ 60).toString().padLeft(2, '0')}:${(remainingTime % 60).toString().padLeft(2, '0')}',
          //   style: TextStyle(fontSize: 48),
          // ),
        ],
      ),
    );
  }
}
