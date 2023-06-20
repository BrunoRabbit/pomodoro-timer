import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/controllers/settings_controller.dart';
import 'package:provider/provider.dart';

class AnimatedToggle extends StatefulWidget {
  const AnimatedToggle({
    Key? key,
    required this.values,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  }) : super(key: key);

  final List<String> values;
  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  @override
  State<AnimatedToggle> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size.width;
    final controller = Provider.of<SettingsController>(context);

    return SizedBox(
      width: size * 0.45,
      height: size * 0.13,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () {
              controller.moveButton();
              controller.changeLocale(context, mounted);
            },
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
                  widget.values.length,
                  (index) => Padding(
                    padding: EdgeInsets.symmetric(horizontal: size * 0.05),
                    child: Text(
                      widget.values[index],
                      style: TextStyle(
                        color: Colors.white.withOpacity(.6),
                        fontSize: size * 0.045,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: controller.initialPosition
                ? Alignment.centerLeft
                : Alignment.centerRight,
            child: Container(
              width: size * 0.25,
              decoration: ShapeDecoration(
                color: widget.buttonColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(size * 0.1),
                ),
              ),
              alignment: Alignment.center,
              child: Text(
                controller.initialPosition
                    ? widget.values[0]
                    : widget.values[1],
                style: TextStyle(
                  fontSize: size * 0.045,
                  color: widget.textColor,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
