import "package:google_maps_flutter/google_maps_flutter.dart";

Set<Marker> convertCoordsToMarkers(List<String> coords) {
  return coords.indexed.map((entry) {
    final index = entry.$1;
    final coords = entry.$2.split(',');

    final lat = double.parse(coords[0].trim());
    final lng = double.parse(coords[1].trim());

    return Marker(
      markerId: MarkerId('marker_$index'),
      position: LatLng(lat, lng),
    );
  }).toSet();
}
