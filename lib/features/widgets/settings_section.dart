import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/controllers/global_controller.dart';
import 'package:pomodoro_timer/features/models/settings_item_model.dart';
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
    GlobalController _controller = Provider.of<GlobalController>(context);

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
              );

              return SettingsItemWidget(
                setts: model.populateItemModel(
                    _controller)[count > 3 ? index + 2 : index],
                index: index,
              );
            },
          ),
        ),
      ],
    );
  }
}

class SettingsItemWidget extends StatelessWidget {
  const SettingsItemWidget({
    super.key,
    required this.setts,
    required this.index,
  });

  final int index;
  final SettingsItemModel setts;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        _showModalBottomSheet(context, index);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        color: AppColors.kCardBackground,
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 20),
          trailing: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                // setts.subTitle != null
                //     ?
                Row(
                  children: [
                    Text(
                      index == 2
                          ? '${setts.subTitle}'
                          : '${setts.subTitle} min',
                      style: TextStyle(
                        color: Colors.white.withOpacity(.6),
                        fontSize: FontSizes.large,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                        top: 2.0,
                        left: 4,
                        right: 4,
                      ),
                      child: Icon(
                        Icons.arrow_forward_ios_rounded,
                        size: 18,
                        color: Colors.white.withOpacity(.6),
                      ),
                    ),
                  ],
                )
                // : Padding(
                //   padding: const EdgeInsets.only(right: 4.0),
                //   child: CupertinoSwitch(
                //       value: true,
                //       onChanged: (c) {},
                //     ),
                // ),
              ],
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              setts.title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: FontSizes.large,
              ),
            ),
          ),
        ),
      ),
    );
  }

  _showModalBottomSheet(BuildContext context, int index) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Digite algo',
              ),
            ),
            ElevatedButton(
              onPressed: () {
                print(index);
              },
              child: const Text('Salvar'),
            ),
          ],
        );
      },
    );
  }
}
