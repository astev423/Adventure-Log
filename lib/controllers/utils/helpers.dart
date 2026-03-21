import "dart:math";

import "package:adventure_log/data/models/review_info.dart";
import "package:geolocator/geolocator.dart";

List<ReviewInfo> sortReviewsByClosestToUser(
  Position userCoords,
  List<ReviewInfo> reviews,
) {
  final reviewsSortedClosestFirst = <ReviewInfo>[];
  final indicesChecked = <int>{};

  for (var _ in Iterable<int>.generate(reviews.length)) {
    int? indexOfReviewClosestToUser;
    double curClosestDistanceToUser = double.infinity;

    for (var index in Iterable<int>.generate(reviews.length)) {
      if (indicesChecked.contains(index)) {
        continue;
      }

      final (latitude, longitude) = findLatitudeAndLongitude(
        reviews[index].locationCoordinates,
      );

      final curDistanceToUser = sqrt(
        pow(userCoords.latitude - latitude, 2) +
            pow(userCoords.longitude - longitude, 2),
      );

      if (curDistanceToUser < curClosestDistanceToUser) {
        indexOfReviewClosestToUser = index;
        curClosestDistanceToUser = curDistanceToUser;
      }
    }

    if (indexOfReviewClosestToUser != null) {
      reviewsSortedClosestFirst.add(reviews[indexOfReviewClosestToUser]);
      indicesChecked.add(indexOfReviewClosestToUser);
    }
  }

  return reviewsSortedClosestFirst;
}

(double, double) findLatitudeAndLongitude(String locationCoordinates) {
  const delimiter = ",";
  final indexOfComma = locationCoordinates.indexOf(delimiter);
  final latitude = double.parse(
    locationCoordinates.substring(0, indexOfComma).trim(),
  );
  final longitude = double.parse(
    locationCoordinates
        .substring(indexOfComma + 1, locationCoordinates.length)
        .trim(),
  );

  return (latitude, longitude);
}

String getCoordsStrFromPos(Position pos) {
  final latitude = pos.latitude;
  final longitude = pos.longitude;

  // Only want 6 digits after the decimal
  final latitudeCut = (latitude * 1000000).truncate() / 1000000;
  final longitudeCut = (longitude * 1000000).truncate() / 1000000;

  final latitudeStr = latitudeCut.toStringAsFixed(6);
  final longitudeStr = longitudeCut.toStringAsFixed(6);

  return "$latitudeStr, $longitudeStr";
}

List<ReviewInfo> sortReviewsByNewestFirst(List<ReviewInfo> reviews) {
  final sortedReviews = List<ReviewInfo>.from(reviews);
  sortedReviews.sort((a, b) => b.timePosted.compareTo(a.timePosted));
  return sortedReviews;
}

List<ReviewInfo> sortReviewsByHighestRatedFirst(List<ReviewInfo> reviews) {
  final sortedReviews = List<ReviewInfo>.from(reviews);
  sortedReviews.sort((a, b) => b.locationRating.compareTo(a.locationRating));
  return sortedReviews;
}
