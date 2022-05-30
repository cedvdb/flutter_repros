import 'package:flutter/material.dart';
import 'package:flutter_repros/explore_state.dart';
import 'package:flutter_repros/router.dart';

class ChangeLocationView extends StatelessWidget {
  const ChangeLocationView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('change location'),
      ),
      body: Center(
        child: ElevatedButton(
            onPressed: () {
              toggleState();
              router.goTo(Routes.map);
            },
            child: const Text('change location')),
      ),
    );
  }
}
