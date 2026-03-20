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
