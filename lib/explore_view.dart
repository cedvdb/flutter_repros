import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  bool showBottomLoader = true;

  @override
  void initState() {
    super.initState();
    _scheduleLoader();
  }

  Future<void> _scheduleLoader() async {
    await Future.delayed(const Duration(seconds: 2));
    setState(() => showBottomLoader = false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: const Text('map'),
        ),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 400,
            child: ListView.builder(
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
                const GoogleMap(
                  initialCameraPosition:
                      CameraPosition(target: LatLng(48.8566, 2.3522), zoom: 17),
                ),
                if (showBottomLoader == true)
                  Positioned(
                    bottom: 0,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width,
                      child: const LinearProgressIndicator(),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
