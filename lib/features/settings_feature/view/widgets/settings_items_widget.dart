import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/localization/multi_languages.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/core/utils/enums/language.dart';
import 'package:pomodoro_timer/core/utils/enums/notifications.dart';
import 'package:pomodoro_timer/features/language_feature/models/language_model.dart';
import 'package:pomodoro_timer/features/notifications_feature/view_model/notifications_view_model.dart';
import 'package:pomodoro_timer/features/settings_feature/model/settings_item_model.dart';
import 'package:pomodoro_timer/features/settings_feature/view_model/settings_view_model.dart';
import 'package:pomodoro_timer/features/settings_feature/view/widgets/animated_toggle.dart';
import 'package:pomodoro_timer/features/settings_feature/view/widgets/settings_bottom_sheet.dart';
import 'package:provider/provider.dart';

class SettingsItemWidget extends StatefulWidget {
  const SettingsItemWidget({
    super.key,
    required this.setts,
    required this.index,
    required this.title,
  });

  final int index;
  final String title;
  final SettingsItemModel setts;

  @override
  State<SettingsItemWidget> createState() => _SettingsItemWidgetState();
}

class _SettingsItemWidgetState extends State<SettingsItemWidget> {
  late SettingsViewModel settingsViewModel;
  late NotificationsViewModel notificationsViewModel;
  late LanguageModel model;

  @override
  void initState() {
    super.initState();
    context.read<SettingsViewModel>().loadToggleValue();
    context.read<NotificationsViewModel>().getUserNotificationPrefs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    settingsViewModel = Provider.of<SettingsViewModel>(context);
    notificationsViewModel = Provider.of<NotificationsViewModel>(context);
    model = MultiLanguagesImpl.of(context)!.instance();
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if ((widget.index == 0 || widget.index == 1) &&
            widget.setts.subTitle == null) {
          return;
        }

        _showModalBottomSheet(context, widget.setts.openModalBottomSheet);
      },
      child: Container(
        height: 50,
        width: double.infinity,
        color: AppColors.cardRedBackground,
        child: ListTile(
          contentPadding: const EdgeInsets.only(left: 20),
          trailing: Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                if (widget.setts.subTitle == null)
                  widget.index == 1
                      ? AnimatedToggle(
                          toggleValue: settingsViewModel.toggleValue == 0,
                          listOptions: Language.values,
                          onTap: () async {
                            settingsViewModel.moveButton();

                            await settingsViewModel.changeLocale(
                                context, mounted);
                          },
                        )
                      : AnimatedToggle(
                          listOptions: Notifications.values,
                          toggleValue:
                              notificationsViewModel.isNotificationAllowed,
                          onTap: () {
                            notificationsViewModel.toggleNotifications();

                            notificationsViewModel.saveUserNotificationPrefs();
                          },
                        )
                else
                  Row(
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
              widget.title,
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

  void _showModalBottomSheet(BuildContext context, Function(double) onPress) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return SafeArea(
          top: false,
          child: Material(
            child: Container(
              height: 320,
              padding: const EdgeInsets.only(top: 6.0),
              margin: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
              ),
              child: SettingsBottomSheet(
                onPress: onPress,
                title: widget.title,
                model: model,
                index: widget.index,
              ),
            ),
          ),
        );
      },
    );
  }
}
