import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  final Widget child;
  const HomeScreen({
    Key? key,
    required this.child,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          destinations: const [
            NavigationRailDestination(
                icon: Icon(Icons.map), label: Text('map')),
            NavigationRailDestination(
                icon: Icon(Icons.map), label: Text('map')),
          ],
          selectedIndex: 0,
        ),
        Expanded(
          child: Row(
            children: [
              Expanded(
                child: child,
              )
            ],
          ),
        ),
      ],
    );
  }
}
