import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/home_feature/view_model/pomodoro_view_model.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/features/statistics_feature/model/statistics_model.dart';
import 'package:pomodoro_timer/features/statistics_feature/view_model/statistics_view_model.dart';
import 'package:provider/provider.dart';

class _DayWidgetState extends State<DayWidget> {
  late LanguageModel langModel;
  late PomodoroViewModel pomodoroViewModel;
  late StatisticsViewModel viewModel;

  List<StatisticsModel> get _model => viewModel.statisticsModel;
  double get heightPerItem => 55 * _model.length.toDouble();

  String get sectionTitle => langModel.settingsSection.first.sectionTitle!;
  String get averagePomodoro =>
      '${langModel.statisticsAveragePomodoroDay} ${viewModel.pomodoro} pomodoro\n(${viewModel.totalMinutes})';

  final Divider divider = const Divider(
    height: 6,
    color: AppColors.linesCardBorderColor,
    thickness: 2,
    indent: 20,
  );

  @override
  void initState() {
    super.initState();
    context.read<StatisticsViewModel>().initSections();
    context.read<StatisticsViewModel>().getPomodoroTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    langModel = MultiLanguagesImpl.of(context)!.instance();
    pomodoroViewModel = Provider.of<PomodoroViewModel>(context);
    viewModel = Provider.of<StatisticsViewModel>(context);
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22.0, top: 22.0),
            child: Text(
              '$sectionTitle - ${langModel.statisticsSectionTitleDay}',
              style: TextStyle(
                color: Colors.white.withOpacity(.85),
                fontSize: FontSizes.medium,
              ),
            ),
          ),
          Container(
            height: heightPerItem,
            margin: const EdgeInsets.only(top: 8),
            decoration: BoxDecoration(
              color: AppColors.cardRedBackground,
              border: Border.all(
                color: AppColors.linesCardBorderColor,
                width: 2,
              ),
            ),
            child: ListView.separated(
              itemCount: _model.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) => divider,
              itemBuilder: (context, j) {
                String minutesAndCyclesPrefix = j == 2
                    ? viewModel.plural(
                        pomodoroViewModel.userCycleLimit, langModel)
                    : 'min';
    
                return Container(
                  height: 50,
                  width: double.infinity,
                  color: AppColors.cardRedBackground,
                  child: ListTile(
                    contentPadding: const EdgeInsets.only(left: 20),
                    trailing: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, right: 12),
                      child: Text(
                        '${_model[j].value} $minutesAndCyclesPrefix',
                        style: TextStyle(
                          color: Colors.white.withOpacity(.6),
                          fontSize: FontSizes.large,
                        ),
                      ),
                    ),
                    leading: Padding(
                      padding: const EdgeInsets.only(bottom: 8.0),
                      child: Text(
                        langModel.settingsSection.first.sectionItems![j],
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: FontSizes.large,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 16.0),
            child: Center(
              child: Text(
                averagePomodoro,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white.withOpacity(.85),
                  fontSize: FontSizes.medium,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class DayWidget extends StatefulWidget {
  const DayWidget({required this.locale, super.key});

  final String locale;

  @override
  State<DayWidget> createState() => _DayWidgetState();
}
