import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/features/models/settings_item_model.dart';
import 'package:pomodoro_timer/features/widgets/animated_toggle.dart';
import 'package:pomodoro_timer/features/widgets/settings_bottom_sheet.dart';

class SettingsItemWidget extends StatefulWidget {
  const SettingsItemWidget({
    super.key,
    required this.setts,
    required this.index,
  });

  final int index;
  final SettingsItemModel setts;

  @override
  State<SettingsItemWidget> createState() => _SettingsItemWidgetState();
}

class _SettingsItemWidgetState extends State<SettingsItemWidget> {
  final formKey = GlobalKey<FormState>();
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.index == 1 && widget.setts.subTitle == null) {
          return;
        }

        _showModalBottomSheet(
            context, widget.setts.openModalBottomSheet, controller);
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
                widget.setts.subTitle == null
                    ? const AnimatedToggle(
                        buttonColor: AppColors.kScaffoldSecondary,
                        backgroundColor: Colors.transparent,
                        textColor: Color(0xFFFFFFFF),
                      )
                    : Row(
                        children: [
                          Text(
                            widget.index == 2
                                ? '${widget.setts.subTitle}'
                                : '${widget.setts.subTitle} min',
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
                      ),
              ],
            ),
          ),
          leading: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Text(
              widget.setts.title,
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

  void _showModalBottomSheet(
    BuildContext context,
    Function(TextEditingController) onPress,
    TextEditingController controller
  ) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      enableDrag: true,
      builder: (BuildContext context) {
        return SettingsBottomSheet(
          onPress: onPress,
          controller: controller,
          formKey: formKey,
        );
      },
    );
  }
}