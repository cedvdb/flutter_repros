import 'package:flutter_repros/change_location_view.dart';
import 'package:flutter_repros/explore_view.dart';
import 'package:x_router/x_router.dart';

import 'home_layout.dart';

final routes = [
  XRoute(
    path: Routes.app,
    builder: (context, activatedRoute) => const HomeLayout(),
    childRouterConfig: XChildRouterConfig(
      routes: [
        XRoute(
          path: Routes.map,
          builder: (context, activatedRoute) => const ExploreView(),
        ),
        XRoute(
          path: Routes.changeLocation,
          builder: (context, activatedRoute) => const ChangeLocationView(),
        ),
      ],
    ),
  ),
];
final resolvers = [XNotFoundResolver(redirectTo: Routes.map, routes: routes)];
final router = XRouter(
  resolvers: resolvers,
  routes: routes,
);

abstract class Routes {
  static const app = '/app';
  static const map = '$app/map';
  static const changeLocation = '$app/change_location';
}
