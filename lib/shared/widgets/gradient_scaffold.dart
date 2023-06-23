import 'package:pomodoro_timer/core/themes/app_colors.dart';
import 'package:flutter/material.dart';

class GradientScaffold extends StatelessWidget {
  const GradientScaffold({
    Key? key,
    required this.body,
    this.bottomNavBar,
    this.gradient,
    this.appBar,
    this.bgColor,
  }) : super(key: key);
  
  final Widget body;
  final BottomNavigationBar? bottomNavBar;
  final LinearGradient? gradient;
  final PreferredSizeWidget? appBar;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) => Scaffold(
        backgroundColor: bgColor ?? AppColors.kScaffoldSecondary,
        body: Container(
          decoration: BoxDecoration(
            gradient: gradient ??
                const LinearGradient(
                  colors: [
                    AppColors.kScaffoldPrimary,
                    AppColors.kScaffoldSecondary,
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
          ),
          child: body,
        ),
        appBar: appBar,
        bottomNavigationBar: bottomNavBar,
      );
}
