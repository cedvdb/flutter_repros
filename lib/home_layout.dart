import 'package:flutter/material.dart';
import 'package:flutter_repros/router.dart';

class HomeLayout extends StatelessWidget {
  const HomeLayout({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        NavigationRail(
          destinations: const [
            NavigationRailDestination(
              icon: Icon(Icons.map),
              label: Text('map'),
            ),
            NavigationRailDestination(
              icon: Icon(Icons.map),
              label: Text('map'),
            ),
          ],
          selectedIndex: 0,
        ),
        Expanded(
          child: Router(
            routerDelegate: router.childRouterStore.findDelegate(Routes.app),
          ),
        ),
      ],
    );
  }
}
