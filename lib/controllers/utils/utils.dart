import "package:adventure_log/data/models/review_info.dart";
import "package:flutter/material.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

Set<Marker> convertReviewsToMarkers(
  List<ReviewInfo> reviews,
  BuildContext context,
) {
  return reviews.indexed.map((entry) {
    final index = entry.$1;
    final coords = entry.$2.locationCoordinates.split(',');

    final lat = double.parse(coords[0].trim());
    final lng = double.parse(coords[1].trim());

    return Marker(
      markerId: MarkerId('marker_$index'),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: "${entry.$2.locationName} ${entry.$2.locationRating}/5",
        snippet: "Click/Tap here for more info",
        onTap: () =>
            Navigator.pushNamed(context, '/view-review', arguments: entry.$2),
      ),
    );
  }).toSet();
}
