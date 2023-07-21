import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';
import 'package:pomodoro_timer/core/utils/enums/language.dart';
import 'package:pomodoro_timer/core/utils/enums/notifications.dart';
import 'package:pomodoro_timer/core/utils/extensions/language_helper.dart';
import 'package:pomodoro_timer/core/utils/extensions/notifications_helper.dart';
import 'package:pomodoro_timer/core/themes/app_colors.dart';

class AnimatedToggle extends StatefulWidget {
  const AnimatedToggle({
    Key? key,
    this.textColor = const Color(0xFFFFFFFF),
    this.backgroundColor = Colors.transparent,
    required this.onTap,
    required this.toggleValue,
    required this.listOptions,
  }) : super(key: key);

  final Color textColor;
  final Color backgroundColor;
  final VoidCallback onTap;
  final bool toggleValue;
  final List<Object> listOptions;

  @override
  State<AnimatedToggle> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  late double size;
  late bool deviceOrientation;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    deviceOrientation =
        MediaQuery.of(context).orientation == Orientation.landscape;
    size = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: FontSizes.large,
      color: widget.textColor,
      fontWeight: FontWeight.bold,
    );

    final locale = Localizations.localeOf(context).toString();

    return SizedBox(
      width: deviceOrientation ? size * 0.38 : size * 0.45,
      height: size * 0.13,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: deviceOrientation ? size * 0.38 : size * 0.45,
              height: size * 0.13,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size * 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: List.generate(
                  widget.listOptions.length,
                  (index) {
                    final object = widget.listOptions[index];

                    if (object is Language) {
                      final language = object.languageCode;

                      return Text(
                        language,
                        style: TextStyle(
                          color: Colors.white.withOpacity(.6),
                          fontSize: FontSizes.large,
                        ),
                      );
                    }

                    return Text(
                      _formattedLocale(locale, (object as Notifications)),
                      style: TextStyle(
                        color: Colors.white.withOpacity(.6),
                        fontSize: FontSizes.large,
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: widget.toggleValue
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: deviceOrientation ? size * 0.20 : size * 0.25,
              decoration: ShapeDecoration(
                color: AppColors.scaffoldColorSecondary,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size * 0.1),
                ),
              ),
              alignment: Alignment.center,
              child: Builder(
                builder: (context) {
                  if (widget.listOptions[0] is Language) {
                    return Text(
                      widget.toggleValue
                          ? Language.values[0].languageCode
                          : Language.values[1].languageCode,
                      style: style,
                    );
                  }

                  return Text(
                    _formattedNotification(locale),
                    style: style,
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  String _formattedLocale(String locale, Notifications object) {
    if (locale == 'pt') {
      final notification = object.notificationCode;

      return notification;
    }

    return object.name[0].toUpperCase() +
        object.name.substring(1).toLowerCase();
  }

  String _formattedNotification(String locale) {
    if (locale == 'pt') {
      return widget.toggleValue
          ? Notifications.values[0].notificationCode
          : Notifications.values[1].notificationCode;
    }

    String yesOption = Notifications.values[0].name;
    String noOption = Notifications.values[1].name;

    return widget.toggleValue
        ? yesOption[0].toUpperCase() + yesOption.substring(1).toLowerCase()
        : noOption[0].toUpperCase() + noOption.substring(1).toLowerCase();
  }
}
