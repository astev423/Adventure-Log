import "../../controllers/utils/constants.dart";
import "../../data/firestore_queries.dart";
import "../../data/models/review_info.dart";
import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";
import "package:google_maps_flutter/google_maps_flutter.dart";

class Explore extends StatefulWidget {
  const Explore({super.key});

  @override
  State<Explore> createState() => _ExploreState();
}

class _ExploreState extends State<Explore> {
  bool _isLocationVisible = false;
  Position? _coordinates;
  LocationPermission? _permission;
  List<ReviewInfo> _reviews = [];
  bool _isFetchingDone = false;

  @override
  void initState() {
    super.initState();
    _checkLocation();
    getReviewsForMap();
  }

  void getReviewsForMap() async {
    _reviews = await fetchAllReviews();
    setState(() {
      _reviews = _reviews;
      _isFetchingDone = true;
    });
  }

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
    if (!_isLocationVisible || _coordinates == null) {
      return headerText(
        "You must enable location services to see this page",
        context,
      );
    }
    if (!_isFetchingDone) {
      return headerText("Loading...", context);
    }

    return EmbeddedMap(
      _coordinates,
      _convertReviewsToMarkers(_reviews, context),
    );
  }
}

class EmbeddedMap extends StatelessWidget {
  final Position? _coordinates;
  final Set<Marker> _markers;

  const EmbeddedMap(this._coordinates, this._markers, {super.key});

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
      markers: _markers,
    );
  }
}

Set<Marker> _convertReviewsToMarkers(
  List<ReviewInfo> reviews,
  BuildContext context,
) {
  return reviews.indexed.map((entry) {
    final index = entry.$1;
    final coords = entry.$2.locationCoordinates.split(",");

    final lat = double.parse(coords[0].trim());
    final lng = double.parse(coords[1].trim());

    return Marker(
      markerId: MarkerId("marker_$index"),
      position: LatLng(lat, lng),
      infoWindow: InfoWindow(
        title: "${entry.$2.locationName} ${entry.$2.locationRating}/5",
        snippet: "Click/Tap here for more info",
        onTap: () =>
            Navigator.pushNamed(context, "/view-review", arguments: entry.$2),
      ),
    );
  }).toSet();
}
