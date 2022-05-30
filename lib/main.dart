import 'package:flutter/material.dart';
import 'package:flutter_repros/explore_view.dart';

void main() {
  runApp(const MyApp());
  FlutterError.onError = (details) => print(details);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const ExploreView(),
    );
  }
}
