import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import 'map.dart';

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

  void _openDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => Dialog(
        child: Column(
          children: [
            ElevatedButton(onPressed: () {}, child: const Text('press me too'))
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          const MyMap(
            initialPosition: LatLng(48.8566, 2.35),
          ),
          Positioned(
            child: ElevatedButton(
              onPressed: () => print('clicked'),
              child: const Text('clicked'),
            ),
          ),
          Positioned(
            child: ElevatedButton(
              onPressed: () => _openDialog(context),
              child: const Text('click me'),
            ),
          )
        ],
      ),
    );
  }
}
