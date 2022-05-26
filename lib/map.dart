import 'dart:math';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef OnPositionUpdated = void Function(LatLng newPosition);

class MapLocationPicker extends StatefulWidget {
  final LatLng initialPosition;

  MapLocationPicker({
    required this.initialPosition,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  late CameraPosition initialCameraPosition;

  @override
  void didChangeDependencies() {
    initialCameraPosition = _computeCameraPosition();
    super.didChangeDependencies();
  }

  void _onMapCreated(GoogleMapController controller) {
    controller.setMapStyle(null);
  }

  CameraPosition _computeCameraPosition() {
    final initialCenter = LatLng(
      widget.initialPosition.latitude,
      widget.initialPosition.longitude,
    );
    final zoom = _computeZoomForScreenSize();
    return CameraPosition(
      target: initialCenter,
      zoom: zoom,
    );
  }

  double _computeZoomForScreenSize() {
    final screenSize = MediaQuery.of(context).size;
    final minSize = min(screenSize.width, screenSize.height);
    return _computeZoom(
      screenSize: minSize,
      latitude: widget.initialPosition.latitude,
      distanceMeters: 4000,
    );
  }

  double _computeZoom({
    required double screenSize,
    required double latitude,
    required double distanceMeters,
  }) {
    //https://stackoverflow.com/a/54704665/4299560
    const equatorLength = 40075004;

    final latitudinalAdjustment = cos(pi * latitude / 180.0);
    final arg = equatorLength *
        screenSize *
        latitudinalAdjustment /
        (distanceMeters * 256);
    return log(arg) / log(2.0);
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: initialCameraPosition,
      onMapCreated: _onMapCreated,
    );
  }
}
