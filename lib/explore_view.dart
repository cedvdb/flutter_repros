import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ExploreView extends StatefulWidget {
  const ExploreView({Key? key}) : super(key: key);

  @override
  State<ExploreView> createState() => _ExploreViewState();
}

class _ExploreViewState extends State<ExploreView> {
  static const pageStateParis =
      PageState(position: LatLng(48.8566, 2.3522), itemCount: 30);
  static const pageStateNewYork =
      PageState(position: LatLng(40.7128, 74.0060), itemCount: 0);

  PageState _state = pageStateParis;

  void _toggleState() {
    setState(() {
      _state = _state == pageStateParis ? pageStateNewYork : pageStateParis;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: AppBar(
          title: ElevatedButton(
              onPressed: _toggleState, child: const Text('change state')),
        ),
      ),
      body: Row(
        children: [
          SizedBox(
            width: 400,
            child: _state.itemCount == 0
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
                      CameraPosition(target: _state.position, zoom: 17),
                ),
                ElevatedButton(
                  onPressed: () {},
                  child: const Text('does nothing'),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class PageState {
  final LatLng position;
  final int itemCount;
  const PageState({
    required this.position,
    required this.itemCount,
  });

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is PageState &&
        other.position == position &&
        other.itemCount == itemCount;
  }

  @override
  int get hashCode => position.hashCode ^ itemCount.hashCode;
}
