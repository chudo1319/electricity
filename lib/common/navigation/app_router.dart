import 'package:auto_route/auto_route.dart';
import 'package:electricity/common/navigation/app_route_paths.dart';
import 'package:electricity/common/navigation/app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    CustomRoute(
      initial: true,
      page: AuthRoute.page,
      path: AppRoutePaths.auth,
    ),
    CustomRoute(
      page: MainRoute.page,
      path: AppRoutePaths.main,
    ),
    CustomRoute(
      page: StatisticsRoute.page,
      path: AppRoutePaths.statistics,
    ),  
  ];
}
