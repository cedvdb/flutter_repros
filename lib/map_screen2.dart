import 'package:flutter/material.dart';

import 'map.dart';

class MapScreen2 extends StatelessWidget {
  final String title;
  const MapScreen2({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(title)), body: MapLocationPicker());
  }
}
