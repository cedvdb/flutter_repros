import 'package:flutter/material.dart';
import 'package:flutter_repros/explore_state.dart';
import 'package:flutter_repros/router.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: const Text('map'),
        ),
      ),
      body: StreamBuilder(
          stream: stateController.stream,
          builder: (context, snapshot) {
            final state = snapshot.data as PageState;
            return Row(
              children: [
                SizedBox(
                  width: 400,
                  child: state.itemCount == 0
                      ? const CircularProgressIndicator()
                      : ListView.builder(
                          itemCount: 30,
                          itemBuilder: (ctx, index) => ListTile(
                            title: Text(
                              index.toString(),
                            ),
                          ),
                        ),
                ),
                Expanded(
                  child: Stack(
                    children: [
                      GoogleMap(
                        initialCameraPosition:
                            CameraPosition(target: state.position, zoom: 17),
                      ),
                      ElevatedButton(
                        onPressed: () => router.goTo(Routes.changeLocation),
                        child: const Text('change location'),
                      )
                    ],
                  ),
                ),
              ],
            );
          }),
    );
  }
}
