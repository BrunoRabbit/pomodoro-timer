import 'package:flutter/material.dart';
import 'package:pomodoro_timer/features/controllers/settings_controller.dart';
import 'package:provider/provider.dart';

enum Language {
  ptBR,
  enEN,
}

extension LanguageExtension on Language {
  String get languageCode {
    switch (this) {
      case Language.ptBR:
        return 'pt-BR';
      case Language.enEN:
        return 'en-EN';
    }
  }
}

class AnimatedToggle extends StatefulWidget {
  const AnimatedToggle({
    Key? key,
    this.backgroundColor = const Color(0xFFe7e7e8),
    this.buttonColor = const Color(0xFFFFFFFF),
    this.textColor = const Color(0xFF000000),
  }) : super(key: key);

  final Color backgroundColor;
  final Color buttonColor;
  final Color textColor;

  @override
  State<AnimatedToggle> createState() => _AnimatedToggleState();
}

class _AnimatedToggleState extends State<AnimatedToggle> {
  late double size;
  @override
  void initState() {
    super.initState();
    context.read<SettingsController>().loadToggleValue();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    size = MediaQuery.of(context).size.width;
  }

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<SettingsController>(context);

    return SizedBox(
      width: size * 0.45,
      height: size * 0.13,
      child: Stack(
        children: <Widget>[
          GestureDetector(
            onTap: () async {
              controller.moveButton();

              await controller.changeLocale(context, mounted);
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
                children: List.generate(Language.values.length, (index) {
                  final language = Language.values[index].languageCode;

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
                }),
              ),
            ),
          ),
          AnimatedAlign(
            duration: const Duration(milliseconds: 250),
            curve: Curves.decelerate,
            alignment: controller.toggleValue == 0
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
                controller.toggleValue == 0
                    ? Language.values[0].languageCode
                    : Language.values[1].languageCode,
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
