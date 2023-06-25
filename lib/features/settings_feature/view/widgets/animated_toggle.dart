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
                    if (object is Notifications) {
                      final notification = object.notificationCode;

                      return Text(
                        notification,
                        style: TextStyle(
                          color: Colors.white.withOpacity(.6),
                          fontSize: FontSizes.large,
                        ),
                      );
                    }
                    return Container();
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
                color: AppColors.kScaffoldSecondary,
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
                  if (widget.listOptions[0] is Notifications) {
                    return Text(
                      widget.toggleValue
                          ? Notifications.values[0].notificationCode
                          : Notifications.values[1].notificationCode,
                      style: style,
                    );
                  }
                  return Container();
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
