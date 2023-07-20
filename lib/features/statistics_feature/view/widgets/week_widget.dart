import 'package:flutter/material.dart';
import 'package:pomodoro_timer/shared/custom_painter/tool_tip_custom_shape.dart';
import 'package:provider/provider.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/features/statistics_feature/view_model/statistics_view_model.dart';

class WeekWidget extends StatefulWidget {
  const WeekWidget({required this.locale, super.key});

  final String locale;

  @override
  State<WeekWidget> createState() => _WeekWidgetState();
}

class _WeekWidgetState extends State<WeekWidget> {
  late LanguageModel langModel;
  late StatisticsViewModel viewModel;
  late Orientation orientation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<StatisticsViewModel>(context);
    langModel = MultiLanguagesImpl.of(context)!.instance();
    orientation = MediaQuery.of(context).orientation;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 22, top: 22),
            child: Text(
              viewModel.weekOfTheMonth(widget.locale),
              style: TextStyle(
                color: Colors.white.withOpacity(.85),
                fontSize: FontSizes.medium,
              ),
            ),
          ),
          Center(
            child: WeekChart(
              widget.locale,
              langModel,
              viewModel,
              orientation,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}

class WeekChart extends StatelessWidget {
  const WeekChart(
    this.locale,
    this.langModel,
    this.viewModel,
    this.orientation, {
    super.key,
  });

  final String locale;
  final LanguageModel langModel;
  final StatisticsViewModel viewModel;
  final Orientation orientation;

  static const double chartHeight = 300.0;

  double get itemExtent =>
      orientation == Orientation.portrait ? chartHeight / 6 : chartHeight / 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: chartHeight,
      margin: const EdgeInsets.only(top: 8),
      decoration: BoxDecoration(
        color: AppColors.kCardBackground,
        border: Border.all(
          color: AppColors.kLinesColor,
          width: 2,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ? Chart
          Expanded(
            child: Stack(
              children: [
                // ? Chart Title
                Padding(
                  padding: const EdgeInsets.only(top: 22),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Text(
                      langModel.statisticsFocusSessions,
                      style: const TextStyle(
                        fontFamily: 'Raleway',
                        fontWeight: FontWeight.w600,
                        color: Colors.white70,
                        fontSize: FontSizes.medium,
                        letterSpacing: .6,
                      ),
                    ),
                  ),
                ),

                // ? Vertical Numbers
                Padding(
                  padding: const EdgeInsets.fromLTRB(22.0, 44.0, 22.0, 24.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      for (int i = 5; i >= 0; i--)
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Flexible(
                              child: Text(
                                '${i * 3}',
                                style: const TextStyle(
                                  color: Colors.white70,
                                ),
                              ),
                            ),
                            const SizedBox(width: 10),
                            const Expanded(
                              flex: 16,
                              child: Divider(
                                color: AppColors.kLinesColor,
                                thickness: 2,
                              ),
                            ),
                          ],
                        ),
                    ],
                  ),
                ),

                // ? Bars Chart
                Padding(
                  padding: const EdgeInsets.only(left: 22),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: ListView.builder(
                          physics: const NeverScrollableScrollPhysics(),
                          scrollDirection: Axis.horizontal,
                          itemExtent: itemExtent,
                          padding: const EdgeInsets.only(left: 22),
                          itemCount: 7,
                          itemBuilder: (context, i) {
                            return BarChart(
                              index: i,
                              locale: locale,
                              viewModel: viewModel,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class BarChart extends StatelessWidget {
  const BarChart({
    Key? key,
    required this.index,
    required this.locale,
    required this.viewModel,
  }) : super(key: key);

  final int index;
  final String locale;
  final StatisticsViewModel viewModel;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        // ? Bar Chart
        Consumer<StatisticsViewModel>(
          builder: (context, value, child) {
            final mediaQuery = MediaQuery.of(context);

            bool orientation = mediaQuery.orientation == Orientation.portrait;

            double chartBarHeight = orientation
                ? mediaQuery.size.height / 4.15
                : mediaQuery.size.width / 4.15;

            double verticalOffset = orientation
                ? -viewModel.getBarHeight(index, 15, true) +
                    mediaQuery.size.width / 8
                : -viewModel.getBarHeight(index, 15, true) +
                    mediaQuery.size.height / 8;

            int dayUserSection = viewModel.retrieveUserSection(
              index,
              viewModel.finishedSection,
            );

            return Tooltip(
              message: '$dayUserSection pomodoro',
              triggerMode: TooltipTriggerMode.tap,
              textStyle: const TextStyle(
                  fontWeight: FontWeight.w600,
                  color: AppColors.kScaffoldPrimary,
                  fontSize: 15),
              verticalOffset: verticalOffset,
              padding: const EdgeInsets.symmetric(
                vertical: 8,
                horizontal: 14,
              ),
              decoration: ShapeDecoration(
                color: Colors.white,
                shape: ToolTipCustomShape(index: index),
              ),
              child: Stack(
                alignment: AlignmentDirectional.bottomEnd,
                children: [
                  Container(
                    width: 13,
                    height: chartBarHeight,
                    decoration: BoxDecoration(
                      color: AppColors.kProgressColor,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                  Container(
                    width: 13,
                    height: value.getBarHeight(index, 15, true),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(20),
                    ),
                  ),
                ],
              ),
            );
          },
        ),

        const SizedBox(height: 15),

        Text(
          viewModel.daysOfTheWeek(index, locale),
          style: TextStyle(
            color: viewModel.getTextColorForDay(index, locale),
          ),
        ),

        const SizedBox(height: 14),
      ],
    );
  }
}
