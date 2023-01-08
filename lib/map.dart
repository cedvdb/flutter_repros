import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef OnPositionUpdated = void Function(LatLng newPosition);

class MapLocationPicker extends StatefulWidget {
  const MapLocationPicker({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: CameraPosition(
        target: LatLng(41.99, 21.42),
        zoom: 7.2373,
      ),
    );
  }
}
