import 'package:flutter/material.dart';
import 'package:flutter_repros/router.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      routerDelegate: router.delegate,
      routeInformationParser: router.informationParser,
      routeInformationProvider: router.informationProvider,
    );
  }
}
