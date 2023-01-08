import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'home_screen.dart';
import 'map_screen.dart';
import 'map_screen2.dart';

void main() {
  runApp(const MyApp());
}

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();
final GlobalKey<NavigatorState> _homeNavigatorKey = GlobalKey<NavigatorState>();

final router = GoRouter(
  initialLocation: '/map',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _homeNavigatorKey,
      builder: (context, state, child) => HomeScreen(child: child),
      routes: [
        GoRoute(
          parentNavigatorKey: _homeNavigatorKey,
          path: '/map',
          builder: (context, state) => MapScreen(title: 'first'),
          routes: [
            GoRoute(
              parentNavigatorKey: _rootNavigatorKey,
              path: 'above',
              builder: (context, state) => MapScreen2(title: 'second'),
            )
          ],
        ),
      ],
    )
  ],
);

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routeInformationParser: router.routeInformationParser,
      routeInformationProvider: router.routeInformationProvider,
      routerDelegate: router.routerDelegate,
    );
  }
}
