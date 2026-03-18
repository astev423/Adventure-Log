import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool _isLocationVisible = false;
  Position? _coordinates;
  LocationPermission? _permission;

  void _checkLocation() async {
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
    }

    if (_permission == LocationPermission.always ||
        _permission == LocationPermission.whileInUse) {
      _coordinates = await Geolocator.getCurrentPosition();
      _isLocationVisible = true;
    }

    setState(() {
      _permission = _permission;
      _coordinates = _coordinates;
      _isLocationVisible = _isLocationVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    _checkLocation();
    if (!_isLocationVisible) {
      return Text("You must enable location services to see this page");
    }

    return EmbeddedMap(_coordinates);
  }
}

class EmbeddedMap extends StatelessWidget {
  final Position? _coordinates;

  const EmbeddedMap(this._coordinates, {super.key});

  @override
  Widget build(BuildContext context) {
    CameraPosition cameraPosition = CameraPosition(
      target: LatLng(_coordinates!.latitude, _coordinates!.longitude),
      zoom: 16,
    );

    return GoogleMap(
      initialCameraPosition: cameraPosition,
      myLocationButtonEnabled: false,
      zoomControlsEnabled: true,
    );
  }
}
