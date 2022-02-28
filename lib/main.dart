import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
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
      home: const MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const ScaledCard(
      key: ValueKey('tap-me'),
    );
  }
}

class ScaledCard extends StatelessWidget {
  const ScaledCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AnimatedScale(
      scale: 1.05,
      duration: const Duration(seconds: 1),
      child: Card(
        child: InkWell(
          onTap: () {},
          child: const Text('tap me'),
        ),
      ),
    );
  }
}
