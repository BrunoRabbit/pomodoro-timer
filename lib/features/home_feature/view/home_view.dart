import 'package:auto_route/auto_route.dart';
import 'package:pomodoro_timer/core/routes/routes.gr.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/features/home_feature/layouts/narrow_home_screen.dart';
import 'package:pomodoro_timer/features/home_feature/layouts/wide_home_screen.dart';
import 'package:pomodoro_timer/features/language_feature/view_model/language_view_model.dart';
import 'package:pomodoro_timer/features/notifications_feature/view_model/notifications_view_model.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';
import 'package:pomodoro_timer/shared/widgets/gradient_scaffold.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

@RoutePage()
class HomeView extends StatefulWidget {
  const HomeView({Key? key}) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  late PomodoroViewModel viewModel;

  @override
  void initState() {
    super.initState();
    context.read<NotificationsViewModel>().initNotification();
    context.read<PomodoroViewModel>().initializeUserSection();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<PomodoroViewModel>(context);
    context.read<LanguageViewModel>().initLocale();
  }

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      bgColor: !viewModel.isWorking ? AppColors.scaffoldGreenSecondary : null,
      gradient: !viewModel.isWorking
          ? const LinearGradient(
              colors: [
                AppColors.scaffoldGreenPrimary,
                AppColors.scaffoldGreenSecondary,
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
              context.router.push(const StatisticsRoute());
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
