import 'dart:async';

import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

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

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key}) : super(key: key);

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  BehaviorSubject<int> streamController = BehaviorSubject.seeded(0);

  void _showOtherPage(BuildContext context) async {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (ctx) => Scaffold(
          appBar: AppBar(),
          body: TextFormField(
            autofocus: true,
          ),
        ),
      ),
    );
    streamController.add(streamController.value + 1);
    await Future.delayed(const Duration(milliseconds: 800));
    streamController.add(streamController.value + 1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: streamController.stream,
        builder: (ctx, AsyncSnapshot<int> snap) {
          if (!snap.hasData) {
            return Container();
          }
          if (snap.data! % 2 == 0) {
            return Column(
              children: [
                TextFormField(autofocus: true),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () => _showOtherPage(context),
                  child: const Text('show other page'),
                ),
              ],
            );
          }
          return Container();
        },
      ),
    );
  }
}
