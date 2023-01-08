import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pointer_interceptor/pointer_interceptor.dart';

import 'map.dart';

class MapScreen extends StatelessWidget {
  final String title;
  const MapScreen({
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title)),
      body: LayoutBuilder(
        builder: (ctx, constraints) => Stack(
          children: [
            PointerInterceptor(
              child:
                  ElevatedButton(onPressed: () {}, child: Text('some button')),
            ),
            SizedBox(
              height: constraints.maxHeight,
              width: constraints.maxWidth,
              child: MapLocationPicker(),
            ),
          ],
        ),
      ),
      floatingActionButton: PointerInterceptor(
        child: FloatingActionButton(onPressed: () => context.go('/map/above')),
      ),
    );
  }
}
