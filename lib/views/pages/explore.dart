import 'package:adventure_log/controllers/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class Explore extends StatelessWidget {
  const Explore({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            headerText("Explore", context),
            SizedBox(width: 400, height: 400, child: MapPage()),
          ],
        ),
      ),
    );
  }
}

class MapPage extends StatelessWidget {
  const MapPage({super.key});

  static const CameraPosition _initialPosition = CameraPosition(
    target: LatLng(37.7749, -122.4194),
    zoom: 12,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Google Map')),
      body: const GoogleMap(
        initialCameraPosition: _initialPosition,
        myLocationButtonEnabled: false,
        zoomControlsEnabled: true,
      ),
    );
  }
}
