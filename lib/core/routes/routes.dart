import 'package:auto_route/auto_route.dart';
import 'package:pomodoro_timer/core/routes/routes.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Screen,Route')
class Routes extends $Routes {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(page: HomeRoute.page, initial: true),
    AutoRoute(page: SettingsRoute.page),
  ];
}