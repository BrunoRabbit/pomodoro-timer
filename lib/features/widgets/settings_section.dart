// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/controllers/settings_controller.dart';
import 'package:pomodoro_timer/features/models/section_list_model.dart';
import 'package:pomodoro_timer/features/widgets/settings_items_widget.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    Key? key,
    required this.index,
  }) : super(key: key);

  final int index;

  @override
  Widget build(BuildContext context) {
    SettingsController settings = Provider.of<SettingsController>(context);

    List<SectionListModel> sectionList = settings.settingsSections(context);

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
              sectionList[index].title,
              style: TextStyle(
                color: Colors.white.withOpacity(.85),
                fontSize: FontSizes.medium,
              ),
            ),
          ),

          // ? section item
          Container(
            height: 55 * sectionList[index].items.length.toDouble(),
            decoration: BoxDecoration(
              color: AppColors.kCardBackground,
              border: Border.all(
                color: AppColors.kLinesColor,
                width: 2,
              ),
            ),
            child: ListView.separated(
              itemCount: sectionList[index].items.length,
              physics: const NeverScrollableScrollPhysics(),
              separatorBuilder: (context, _) {
                return const Divider(
                  height: 6,
                  color: AppColors.kLinesColor,
                  thickness: 2,
                  indent: 20,
                );
              },
              itemBuilder: (context, j) {
                final item = sectionList[index].items[j];

                return SettingsItemWidget(
                  setts: item,
                  index: j,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}