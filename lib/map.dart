import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

typedef OnPositionUpdated = void Function(LatLng newPosition);

class MapLocationPicker extends StatefulWidget {
  final LatLng? initialPosition;
  final OnPositionUpdated? onPositionUpdated;
  final bool readOnly;

  const MapLocationPicker({
    this.initialPosition,
    this.onPositionUpdated,
    this.readOnly = true,
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _MapLocationPickerState();
}

class _MapLocationPickerState extends State<MapLocationPicker> {
  final String _pickedLocationMarkerId = "pickedLocation";

  final _defaultPosition = const CameraPosition(
    target: LatLng(41.99, 21.42),
    zoom: 7.2373,
  );

  final double _defaultPickedLocationZoom = 14.4746;

  late GoogleMapController _mapController;
  bool _isMapCreated = false;

  LatLng? _position;

  @override
  void initState() {
    super.initState();

    _position = initialPosition;
  }

  @override
  void dispose() {
    if (_isMapCreated) {
      _mapController.dispose();
    }

    super.dispose();
  }

  void _updatePosition(LatLng newPosition) {
    if (readOnly) {
      return;
    }

    onPositionUpdated?.call(newPosition);

    if (mounted) {
      setState(() {
        _position = newPosition;
      });
    }
  }

  Set<Marker> _getMarkers() {
    return {
      if (_position != null)
        Marker(
          draggable: !readOnly,
          onDragEnd: _updatePosition,
          markerId: MarkerId(_pickedLocationMarkerId),
          position: _position!,
          infoWindow: InfoWindow(
            title: "${_position!.latitude}, ${_position!.longitude}",
          ),
        ),
    };
  }

  @override
  Widget build(BuildContext context) {
    return GoogleMap(
      initialCameraPosition: _defaultPosition,
      onMapCreated: (GoogleMapController controller) {
        if (mounted) {
          setState(() {
            _mapController = controller;
            _isMapCreated = true;

            if (_position != null) {
              controller.animateCamera(CameraUpdate.newCameraPosition(
                CameraPosition(
                  target: _position!,
                  zoom: _defaultPickedLocationZoom,
                ),
              ));
            }
          });
        }
      },
      markers: _getMarkers(),
      onTap: (LatLng? location) {
        if (!readOnly && _position == null && location != null) {
          _updatePosition(location);
        }
      },
    );
  }

  LatLng? get initialPosition => widget.initialPosition;
  OnPositionUpdated? get onPositionUpdated => widget.onPositionUpdated;
  bool get readOnly => widget.readOnly;
}
