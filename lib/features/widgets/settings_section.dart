import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/controllers/global_controller.dart';
import 'package:pomodoro_timer/features/models/settings_item_model.dart';
import 'package:pomodoro_timer/features/widgets/settings_items_widget.dart';
import 'package:provider/provider.dart';

class SettingsSection extends StatelessWidget {
  const SettingsSection({
    Key? key,
    required this.count,
    required this.title,
  }) : super(key: key);

  // count < list.length
  final int count;
  final String title;

  @override
  Widget build(BuildContext context) {
    GlobalController controller = Provider.of<GlobalController>(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ? title
        Padding(
          padding: const EdgeInsets.only(
            left: 22.0,
            bottom: 6,
            top: 12,
          ),
          child: Text(
            title,
            style: TextStyle(
              color: Colors.white.withOpacity(.85),
              fontSize: FontSizes.medium,
            ),
          ),
        ),

        // ? section
        Container(
          height: 55 * count.toDouble(),
          decoration: BoxDecoration(
            color: AppColors.kCardBackground,
            border: Border.all(
              color: AppColors.kLinesColor,
              width: 2,
            ),
          ),
          child: ListView.separated(
            itemCount: count,
            physics: const NeverScrollableScrollPhysics(),
            separatorBuilder: (context, index) {
              return const Divider(
                height: 6,
                color: AppColors.kLinesColor,
                thickness: 2,
                indent: 20,
              );
            },
            itemBuilder: (context, index) {
              SettingsItemModel model = SettingsItemModel(
                title: 'pp',
                subTitle: 'qq',
                onPress: (_) {},
              );

              return SettingsItemWidget(
                setts: model.populateItemModel(
                    controller)[count > 3 ? index + 2 : index],
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}
