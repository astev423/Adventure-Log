import "package:adventure_log/controllers/utils/constants.dart" as constants;
import "package:adventure_log/data/review_queries.dart";
import "package:adventure_log/data/models/review_info.dart";
import "package:adventure_log/views/pages/filtered_reviews_page_layout.dart";
import "package:adventure_log/views/component_widgets/reviews_list.dart";
import "package:flutter/material.dart";
import "package:geolocator/geolocator.dart";

class ClosestReviews extends StatelessWidget {
  const ClosestReviews({super.key});

  @override
  Widget build(BuildContext context) {
    var header = Align(
      alignment: .topCenter,
      child: constants.headerText("Closest reviews:", context),
    );

    return FilteredReviewsPageLayout(header, const _NeedLocationReviewsList());
  }
}

class _NeedLocationReviewsList extends StatefulWidget {
  const _NeedLocationReviewsList();

  @override
  State<_NeedLocationReviewsList> createState() =>
      _NeedLocationReviewsListState();
}

class _NeedLocationReviewsListState extends State<_NeedLocationReviewsList> {
  Future<List<ReviewInfo>> reviews = Future.value(<ReviewInfo>[]);
  Position? _userLocation;
  LocationPermission? _permission;

  @override
  void initState() {
    super.initState();
    fetchReviews();
  }

  @override
  Widget build(BuildContext context) {
    if (_permission == LocationPermission.denied ||
        _permission == LocationPermission.deniedForever) {
      return constants.headerText(
        "Location services must be enabled to continue",
        context,
      );
    }

    return ReviewsList(reviews, fetchReviews);
  }

  Future<List<ReviewInfo>> _getPosAndFetchClosestReviews() async {
    _permission = await Geolocator.checkPermission();
    if (_permission == LocationPermission.denied) {
      _permission = await Geolocator.requestPermission();
    }

    if (_permission == LocationPermission.always ||
        _permission == LocationPermission.whileInUse) {
      _userLocation = await Geolocator.getCurrentPosition();
    }

    setState(() {
      _permission = _permission;
      _userLocation = _userLocation;
    });

    if (_userLocation == null) {
      return [];
    }

    return fetchReviewsClosestFirst(_userLocation!);
  }

  void fetchReviews() {
    setState(() {
      reviews = _getPosAndFetchClosestReviews();
    });
  }
}
