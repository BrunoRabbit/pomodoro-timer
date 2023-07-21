import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/themes/font_sizes.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.onPressed,
    required this.title,
    required this.isWorking,
    this.shape,
  }) : super(key: key);

  final VoidCallback onPressed;
  final String title;
  final bool isWorking;
  final OutlinedBorder? shape;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 24),
        backgroundColor: Colors.white,
        shape: shape ?? const StadiumBorder(),
      ),
      onPressed: onPressed,
      child: Text(
        title,
        style: TextStyle(
          fontFamily: 'Raleway',
          fontWeight: FontWeight.w600,
          fontSize: FontSizes.large,
          color: isWorking
              ? AppColors.scaffoldColorPrimary
              : AppColors.scaffoldGreenPrimary,
        ),
      ),
    );
  }
}
