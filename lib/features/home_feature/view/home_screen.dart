import 'package:auto_route/auto_route.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/core/utils/extensions/translate_helper.dart';
import 'package:pomodoro_timer/features/language_feature/view_model/language_view_model.dart';
import 'package:pomodoro_timer/features/notifications_feature/view_model/notifications_view_model.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';
import 'package:pomodoro_timer/features/home_feature/view/widgets/circular_component.dart';
import 'package:pomodoro_timer/shared/widgets/custom_button.dart';
import 'package:pomodoro_timer/shared/widgets/gradient_scaffold.dart';
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
  late PomodoroViewModel viewModel;

  @override
  void initState() {
    super.initState();
    context.read<NotificationsViewModel>().initNotification();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<PomodoroViewModel>(context);
    context.read<LanguageViewModel>().initLocale();
  }

  @override
  void dispose() {
    viewModel = PomodoroViewModel.removeObserver();
    viewModel.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      bgColor: !viewModel.isWorking ? AppColors.kScaffoldGreenSecondary : null,
      gradient: !viewModel.isWorking
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
      body: LayoutBuilder(
        builder: (context, constraints) {
          if (constraints.maxWidth > 600) {
            return WideHomeScreen(viewModel: viewModel);
          } else {
            return NarrowHomeScreen(viewModel: viewModel);
          }
        },
      ),
    );
  }
}

class NarrowHomeScreen extends StatelessWidget {
  const NarrowHomeScreen({
    super.key,
    required this.viewModel,
  });

  final PomodoroViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return OrientationBuilder(
      builder: (context, orientation) {
        bool isLandscape = orientation == Orientation.landscape;
        final size = MediaQuery.of(context).size.height / 3;

        return Column(
          children: <Widget>[
            SizedBox(
              height: isLandscape ? size / 6 : size / 4,
            ),

            // ? Title
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Text(
                viewModel.isWorking
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
              viewModel: viewModel,
            ),
            SizedBox(
              height: size / 6,
            ),
            CustomButton(
              title: !viewModel.isTimerActive
                  ? 'start_timer'.pdfString(context)
                  : 'pause_timer'.pdfString(context),
              onPressed: () {
                if (!viewModel.isTimerActive) {
                  viewModel.startTimer(context);
                } else {
                  viewModel.pauseTimer();
                }
              },
              isWorking: viewModel.isWorking,
            ),
            SizedBox(
              height: size / 16,
            ),
            CustomButton(
              isWorking: viewModel.isWorking,
              title: 'restart_timer'.pdfString(context),
              onPressed: () {
                viewModel.resetTimer();
              },
            ),

            isLandscape
                ? SizedBox(
                    height: size / 6,
                  )
                : Container(),
          ],
        );
      },
    );
  }
}

class WideHomeScreen extends StatelessWidget {
  const WideHomeScreen({
    super.key,
    required this.viewModel,
  });

  final PomodoroViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: SingleChildScrollView(
            child: NarrowHomeScreen(
              viewModel: viewModel,
            ),
          ),
        ),
      ],
    );
  }
}
