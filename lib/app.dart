import 'package:flutter/material.dart';
import 'package:pomodoro_timer/core/routes/routes.dart';
import 'package:pomodoro_timer/features/controllers/global_controller.dart';
import 'package:provider/provider.dart';

void application() {
  runApp(const Application());
}

class Application extends StatefulWidget {
  const Application({super.key});

  @override
  State<Application> createState() => _ApplicationState();
}

class _ApplicationState extends State<Application> {
  final _appRouter = Routes();
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GlobalController>(
      create: (context) => GlobalController(),
      child: MaterialApp.router(
        routerConfig: _appRouter.config(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
