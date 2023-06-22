import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/utils/extensions/language_helper.dart';
import 'package:pomodoro_timer/core/utils/extensions/notifications_helper.dart';
import 'package:pomodoro_timer/features/widgets/settings_items_widget.dart';
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

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final style = TextStyle(
      fontSize: size * 0.045,
      color: widget.textColor,
      fontWeight: FontWeight.bold,
    );
    return SizedBox(
      width: size * 0.45,
      height: size * 0.13,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: widget.onTap,
            child: Container(
              width: size * 0.45,
              height: size * 0.13,
              decoration: ShapeDecoration(
                color: widget.backgroundColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size * 0.1),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: List.generate(
                  widget.listOptions.length,
                  (index) {
                    final object = widget.listOptions[index];

                    if (object is Language) {
                      final language = object.languageCode;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: size * 0.05),
                        child: Text(
                          language,
                          style: TextStyle(
                            color: Colors.white.withOpacity(.6),
                            fontSize: size * 0.045,
                          ),
                        ),
                      );
                    }
                    if (object is Notifications) {
                      final notification = object.notificationCode;

                      return Padding(
                        padding: EdgeInsets.symmetric(horizontal: size * 0.07),
                        child: Text(
                          notification,
                          style: TextStyle(
                            color: Colors.white.withOpacity(.6),
                            fontSize: size * 0.045,
                          ),
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
              width: size * 0.25,
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
