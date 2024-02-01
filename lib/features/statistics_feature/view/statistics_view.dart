import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/core/utils/enums/statistics.dart';
import 'package:pomodoro_timer/core/utils/extensions/statistics_helper.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/features/statistics_feature/view/widgets/day_widget.dart';
import 'package:pomodoro_timer/features/statistics_feature/view/widgets/month_widget.dart';
import 'package:pomodoro_timer/features/statistics_feature/view/widgets/week_widget.dart';
import 'package:pomodoro_timer/shared/widgets/gradient_scaffold.dart';
import 'package:toggle_switch/toggle_switch.dart';

@RoutePage()
class StatisticsView extends StatefulWidget {
  const StatisticsView({super.key});

  @override
  State<StatisticsView> createState() => _StatisticsViewState();
}

class _StatisticsViewState extends State<StatisticsView> {
  late LanguageModel model;
  late String locale;

  late double size;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size.width;
    model = MultiLanguagesImpl.of(context)!.instance();
    locale = Localizations.localeOf(context).toString();
  }

  static const style = TextStyle(
    fontSize: FontSizes.medium,
    fontFamily: 'Raleway',
    fontWeight: FontWeight.w600,
    letterSpacing: .6,
  );

  final controller = PageController(
    initialPage: 0,
  );

  @override
  Widget build(BuildContext context) {
    return GradientScaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: Text(
          model.statisticsTitle,
          style: const TextStyle(
            fontFamily: 'Raleway',
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios_new_rounded,
          ),
          onPressed: () {
            context.router.pop();
          },
        ),
      ),
      body: Column(
        children: [
          // ? Switch
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 8),
                child: ToggleSwitch(
                  minWidth: size * 0.315,
                  minHeight: 50,
                  cornerRadius: size * 0.1,
                  activeFgColor: AppColors.scaffoldColorPrimary,
                  inactiveBgColor: AppColors.progressColorMissing,
                  inactiveFgColor: Colors.white,
                  initialLabelIndex: 0,
                  totalSwitches: 3,
                  labels: _formattedLabels(locale),
                  radiusStyle: true,
                  customTextStyles: const [style],
                  activeBgColors: const [
                    [Colors.white],
                    [Colors.white],
                    [Colors.white],
                  ],
                  onToggle: (index) {
                    controller.jumpToPage(index!);
                  },
                ),
              ),
            ],
          ),

          Expanded(
            child: PageView(
              controller: controller,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                DayWidget(locale: locale),
                WeekWidget(locale: locale),
                MonthWidget(locale: locale),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<String> _formattedLabels(String locale) {
    if (locale == 'pt') {
      return Statistics.values
          .map((stat) =>
              stat.statisticsLocale.toString().split('.').last.toUpperCase())
          .toList();
    }

    return Statistics.values
        .map((stat) => stat.toString().split('.').last.toUpperCase())
        .toList();
  }
}
