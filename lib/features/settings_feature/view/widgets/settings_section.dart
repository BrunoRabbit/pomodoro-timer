import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/features/settings_feature/view/widgets/settings_items_widget.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/settings_feature/view_model/settings_view_model.dart';
import 'package:provider/provider.dart';

class SettingsSection extends StatefulWidget {
  const SettingsSection({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  State<SettingsSection> createState() => _SettingsSectionState();
}

class _SettingsSectionState extends State<SettingsSection> {
  late LanguageModel model;
  late SettingsViewModel viewModel;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    viewModel = Provider.of<SettingsViewModel>(context);
    model = MultiLanguagesImpl.of(context)!.instance();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 15.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ? title
          Padding(
            padding: const EdgeInsets.only(
              left: 22.0,
              bottom: 8.0,
              top: 22.0,
            ),
            child: Text(
              model.settingsSection[widget.index].sectionTitle!,
              style: TextStyle(
                color: Colors.white.withOpacity(.85),
                fontSize: FontSizes.medium,
              ),
            ),
          ),

          // ? section item
          Container(
            height: 55 *
                model.settingsSection[widget.index].sectionItems!.length
                    .toDouble(),
            decoration: BoxDecoration(
              color: AppColors.cardRedBackground,
              border: Border.all(
                color: AppColors.linesCardBorderColor,
                width: 2,
              ),
            ),
            child: ListView.separated(
              itemCount: model.settingsSection[widget.index].sectionItems!.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return const Divider(
                  height: 6,
                  color: AppColors.linesCardBorderColor,
                  thickness: 2,
                  indent: 20,
                );
              },
              itemBuilder: (context, j) {
                final item = viewModel.settingsSections(model)[widget.index].items[j];
                final title = model.settingsSection[widget.index].sectionItems![j];

                return SettingsItemWidget(
                  setts: item,
                  index: j,
                  title: title,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
